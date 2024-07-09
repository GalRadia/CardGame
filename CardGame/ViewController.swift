import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var westCardImageView: UIImageView!
    @IBOutlet weak var eastCardImageView: UIImageView!
    @IBOutlet weak var westPlayerNameLabel: UILabel!
    @IBOutlet weak var eastPlayerNameLabel: UILabel!
    @IBOutlet weak var eastPlayerScoreLabel: UILabel!
    @IBOutlet weak var westPlayerScoreLabel: UILabel!
    
    private var eastScore = 0
    private var westScore = 0
    private var playCount = 0
    private let totalPlays = 10
    private var counter = 0
    private var cardsVisible = false
    var playerName: String?
    var isLocatedInEast: Bool?
    
    private let cardImages = (2...14).map { "card\($0)" }
    private var stepDetector: StepDetector?
    private var tickSoundPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession()
        initializeGame()
        setupAudioPlayer()
    }
    
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }
    
    private func initializeGame() {
        setupPlayerNames()
        resetGame()
    }
    
    private func setupPlayerNames() {
        if let name = playerName, let isLocatedInEast = isLocatedInEast {
            if isLocatedInEast {
                eastPlayerNameLabel.text = name
                westPlayerNameLabel.text = "West Player"
            } else {
                westPlayerNameLabel.text = name
                eastPlayerNameLabel.text = "East Player"
            }
        }
    }
    
    private func setupAudioPlayer() {
        guard let soundURL = Bundle.main.url(forResource: "tick", withExtension: "mp3") else {
            print("Tick sound file not found")
            return
        }
        
        do {
            tickSoundPlayer = try AVAudioPlayer(contentsOf: soundURL)
            tickSoundPlayer?.prepareToPlay()
        } catch {
            print("Error loading and playing tick sound: \(error.localizedDescription)")
        }
    }
    
    private func playTickSound() {
        tickSoundPlayer?.play()
    }
    
    private func resetGame() {
        eastScore = 0
        westScore = 0
        playCount = 0
        counter = 0
        cardsVisible = false
        updateUI()
        startGameTimer()
    }
    
    private func startGameTimer() {
        stepDetector = StepDetector(cb: self)
        stepDetector?.startSensors(steps: totalPlays)
    }
    
    private func stopGameTimer() {
        stepDetector?.stopSensors()
    }
    
    private func updateGameState() {
        playTickSound()
        counter += 1
        
        if cardsVisible && counter == 3 {
            hideCards()
        } else if !cardsVisible && counter == 2 {
            showNewCards()
        }
    }
    
    private func hideCards() {
        westCardImageView.image = UIImage(named: "back")
        eastCardImageView.image = UIImage(named: "back")
        cardsVisible = false
        counter = 0
    }
    
    private func showNewCards() {
        if playCount >= totalPlays {
            stopGameTimer()
            determineWinner()
            return
        }
        
        let eastCardIndex = Int.random(in: 0..<cardImages.count)
        let westCardIndex = Int.random(in: 0..<cardImages.count)
        
        eastCardImageView.image = UIImage(named: cardImages[eastCardIndex])
        westCardImageView.image = UIImage(named: cardImages[westCardIndex])
        
        updateScores(eastCardIndex: eastCardIndex, westCardIndex: westCardIndex)
        playCount += 1
        cardsVisible = true
        counter = 0
    }
    
    private func updateScores(eastCardIndex: Int, westCardIndex: Int) {
        if eastCardIndex > westCardIndex {
            eastScore += 1
        } else if eastCardIndex < westCardIndex {
            westScore += 1
        }
        updateUI()
    }
    
    private func updateUI() {
        eastPlayerScoreLabel.text = "\(eastScore)"
        westPlayerScoreLabel.text = "\(westScore)"
    }
    
    private func determineWinner() {
        let winner: String
        let winnerScore: Int
        
        if eastScore == westScore {
            winner = playerName ?? "Home Player"
            winnerScore = eastScore
        } else if eastScore > westScore {
            winner = isLocatedInEast == true ? playerName! : "East Player"
            winnerScore = eastScore
        } else {
            winner = isLocatedInEast == false ? playerName! : "West Player"
            winnerScore = westScore
        }
        
        performSegue(withIdentifier: "showEnd", sender: (winner, winnerScore))
    }
    
    @IBAction private func startButtonTapped(_ sender: UIButton) {
        resetGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEnd" {
            if let endVC = segue.destination as? EndViewController, let (winner, winnerScore) = sender as? (String, Int) {
                endVC.champion = winner
                endVC.championScore = winnerScore
            }
        }
    }
}

extension ViewController: CallBack_StepDetector {
    func step(counter: Int) {
        updateGameState()
    }
}
