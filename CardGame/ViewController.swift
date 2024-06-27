 //
//  ViewController.swift
//  CardGame
//
//  Created by Student17 on 27/06/2024.
//

import UIKit

class ViewController: UIViewController {
   
    
    private var player1Index = -1
    private var player2Index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var points = [0...13]
        var images = [#imageLiteral(resourceName: "card2"), #imageLiteral(resourceName: "card3"), #imageLiteral(resourceName: "card4"), #imageLiteral(resourceName: "card5"), #imageLiteral(resourceName: "card6"), #imageLiteral(resourceName: "card7"), #imageLiteral(resourceName: "card8"), #imageLiteral(resourceName: "card9"), #imageLiteral(resourceName: "card10"), #imageLiteral(resourceName: "card11"), #imageLiteral(resourceName: "card12"), #imageLiteral(resourceName: "card13"), #imageLiteral(resourceName: "card14")]
        
    }
 
}
extension ViewController: CallBack_GameTimer{
    func changeImages() {
        player1Index = Int.random(in:0...13)
        player2Index = Int.random(in:0...13)
        
    }
    
    func closeImages() {
        <#code#>
    }
    
    func updateResult() {
        <#code#>
    }
}
