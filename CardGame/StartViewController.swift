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
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Enter Name", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter your name"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let textField = alertController?.textFields?.first, let name = textField.text else { return }
            self?.nameLBL.text = "Hello \(name)"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
