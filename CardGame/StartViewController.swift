//
//  StartViewController.swift
//  CardGame
//
//  Created by Student17 on 06/07/2024.
//

import UIKit
class StartViewController : UIViewController{
    @IBOutlet weak var insertNameButton: UIButton!
    
    @IBOutlet weak var nameLBL: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve the username from UserDefaults
        if let username = UserDefaults.standard.string(forKey: "username") {
            // Assign the username to the UILabel
            nameLBL.text = "Username: \(username)"
        } else {
            // Handle case where username isn't found in UserDefaults
            nameLBL.text = "Username not found"
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter your name"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first, let name = textField.text else { return }
            self?.defaults.set(name, forKey: "username")
            self?.nameLBL.text = "Hello \(name)"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    @IBAction func buttonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "showSecondViewController", sender: self)
      //  dismiss(animated: true, completion: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewController" {
            // Get reference to the destination view controller
            let destinationVC = segue.destination as! ViewController
            
            // Pass any data to the destination view controller here, if needed
            if let username = UserDefaults.standard.string(forKey: "username") {
                // Assign the username to the UILabel
                destinationVC.property = username
            }
        }
        
        
    }
}
