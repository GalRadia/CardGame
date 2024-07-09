import UIKit
import CoreLocation

class StartViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var westImageView: UIImageView!
    @IBOutlet weak var eastImageView: UIImageView!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var playGameButton: UIButton!
    
    private let userDefaults = UserDefaults.standard
    private var locationManager: CLLocationManager!
    private var playerName: String? {
        didSet {
            refreshUI()
        }
    }
    private var playerLocation: CLLocation? {
        didSet {
            refreshUI()
        }
    }
    private var locatedInEast: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        configureLocationManager()
        retrievePlayerName()
        refreshUI()
    }
    
    private func initializeView() {
        playGameButton.isHidden = true
    }
    
    private func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func retrievePlayerName() {
        playerName = userDefaults.string(forKey: "playerName")
    }
    
    private func refreshUI() {
        updateWelcomeLabel()
        toggleNameButtonVisibility()
        updateLocationBasedViews()
        togglePlayButtonVisibility()
    }
    
    private func updateWelcomeLabel() {
        if let name = playerName {
            welcomeLabel.text = "Hello, \(name)!"
        } else {
            welcomeLabel.text = "Please enter your name"
        }
    }
    
    private func toggleNameButtonVisibility() {
        nameButton.isHidden = playerName != nil
    }
    
    private func updateLocationBasedViews() {
        if let location = playerLocation {
            if location.coordinate.latitude > 34.817549168324334 {
                eastImageView.isHidden = false
                westImageView.isHidden = true
            } else {
                eastImageView.isHidden = true
                westImageView.isHidden = false
            }
        }
    }
    
    private func togglePlayButtonVisibility() {
        playGameButton.isHidden = playerName == nil || playerLocation == nil
    }
    
    @IBAction private func nameButtonTapped(_ sender: UIButton) {
        showNameEntryAlert()
    }
    
    private func showNameEntryAlert() {
        let alertController = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter your name"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first, let name = textField.text else { return }
            self?.savePlayerName(name)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func savePlayerName(_ name: String) {
        userDefaults.set(name, forKey: "playerName")
        playerName = name
    }
    
    @IBAction private func playGameButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "startGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            if let gameVC = segue.destination as? ViewController {
                gameVC.playerName = playerName
                gameVC.isLocatedInEast = locatedInEast
            }
        }
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            playerLocation = location
            locatedInEast = location.coordinate.latitude > 34.817549168324334
            locationManager.stopUpdatingLocation()
        }
    }
}
