 //
//  ViewController.swift
//  CardGame
//
//  Created by Student17 on 27/06/2024.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var lblR: UILabel!
    @IBOutlet weak var lblB: UILabel!
    @IBOutlet weak var cardR: UIImageView!
    @IBOutlet weak var cardB: UIImageView!
    private var playerBIndex = -1
    private var playerRIndex = -1
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gameTimer = GameTimer(cb: self)
        gameTimer.startTimer()
    }
 
}
extension ViewController: CallBack_GameTimer{
    func changeImages() {
        playerBIndex = Int.random(in:2...14)
        playerRIndex = Int.random(in:2...14)
        cardB.image = UIImage(named: "card\(playerBIndex)")
        cardR.image = UIImage(named: "card\(playerRIndex)")
        
    }
    
    func closeImages() {
        cardB.image = UIImage(named: "cardBB")
        cardR.image = UIImage(named: "cardBR")
    }
    
    func updateResult() {
        if(playerBIndex>playerRIndex){
            
        }
        else if(playerRIndex>playerBIndex){
            
        }
        else{
            
        }
    }
}
