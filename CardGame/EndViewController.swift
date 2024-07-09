import UIKit

class EndViewController: UIViewController {
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    var champion: String?
    var championScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayResult()
    }
    
    private func displayResult() {
        if let champion = champion, let championScore = championScore {
            resultLabel.text = "Winner: \(champion)"
            finalScoreLabel.text = "Score: \(championScore)"
        }
    }
    
    @IBAction func onMenuButtonTapped(_ sender: UIButton) {
        navigateToMainMenu()
    }
    
    private func navigateToMainMenu() {
        navigationController?.popToRootViewController(animated: true)
    }
}
