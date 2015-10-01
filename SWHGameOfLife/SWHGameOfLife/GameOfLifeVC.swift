//
//  ViewController.swift
//  SWHGameOfLife
//
//  Created by Simon J Whitehouse on 01/10/2015.
//  Copyright © 2015 co.swhitehouse. All rights reserved.
//

import UIKit

class GameOfLifeVC: UIViewController {
    
    var livingCells = Array<Array<LivingView>>()
    
    /// number of flys per row
    static let NumberOfCellsPerRow = 10
    
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
        
        buildGird()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension GameOfLifeVC {
    
    func buildGird() {
        var startOriginX: CGFloat = 0.0
        var startOriginY: CGFloat = 0.0
        
        let cellHeight = GameOfLifeVC.CellHeight
        
        for var y = 0; y < GameOfLifeVC.NumberOfCellsPerRow; y++ {
            livingCells.append([LivingView]())
            for var x = 0; x < GameOfLifeVC.NumberOfCellsPerRow; x++ {
                let newCell = LivingView(frame: CGRectMake(startOriginX, startOriginY, cellHeight, cellHeight))
                gameBoard.addSubview(newCell)
                newCell.configure(LivingViewState.randomCellState())
                startOriginX += cellHeight
                livingCells[y].append(newCell)
            }
            
            startOriginX = 0
            startOriginY += cellHeight
            
        }
        
    }
}

