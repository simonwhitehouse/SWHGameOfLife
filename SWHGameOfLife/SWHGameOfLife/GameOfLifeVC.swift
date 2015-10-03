//
//  ViewController.swift
//  SWHGameOfLife
//
//  Created by Simon J Whitehouse on 01/10/2015.
//  Copyright © 2015 co.swhitehouse. All rights reserved.
//

import UIKit

class GameOfLifeVC: UIViewController {
    
    
    var gameOfLife = GameOfLideModel()
    
    /// number of flys per row
    static let NumberOfCellsPerRow = 50
    
    /// size of each fly
    static let CellHeight = (300 / CGFloat(GameOfLifeVC.NumberOfCellsPerRow))

    @IBOutlet weak var gameBoard: UIView! {
        didSet {
            gameBoard.layer.borderColor = UIColor.whiteColor().CGColor
            gameBoard.layer.borderWidth = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameOfLife.buildGird()
        showCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showCells() {
        for row in gameOfLife.livingCells {
            for cell in row {
                gameBoard.addSubview(cell)
            }
        }
    }

    @IBAction func stepButtonPressed(sender: UIButton) {
        gameOfLife.step()
    }

}

extension GameOfLifeVC {
    
    
}

