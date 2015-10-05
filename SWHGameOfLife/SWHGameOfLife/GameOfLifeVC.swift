//
//  ViewController.swift
//  SWHGameOfLife
//
//  Created by Simon J Whitehouse on 01/10/2015.
//  Copyright © 2015 co.swhitehouse. All rights reserved.
//

import UIKit

class GameOfLifeVC: UIViewController {
    
    typealias GameBoardViews = Array<Array<LivingView>>
    var gameCells = GameBoardViews()
    
    var gameOfLife = GameOfLideModel()
    
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
    
    /// View controller life cylce methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameOfLife.buildGird()
        showCells()
    }
    
    // shows the cells
    func showCells() {
        var startOriginX: CGFloat = 0.0
        var startOriginY: CGFloat = 0.0
        
        let cellHeight = GameOfLifeVC.CellHeight
        
        var counter = 0
        
        for row in gameOfLife.livingCells {
            gameCells.append([LivingView]())
            for cell in row {
                let newCell = LivingView(frame: CGRectMake(startOriginX, startOriginY, cellHeight, cellHeight))
                newCell.configure(LivingViewState.randomCellState())
                startOriginX += cellHeight
                gameBoard.addSubview(newCell)
                gameCells[counter].append(newCell)
            }
            counter++
            startOriginX = 0
            startOriginY += cellHeight
        }
        
    }
    
    func updateView() {
        for var y = 0; y < GameOfLifeVC.NumberOfCellsPerRow; y++ {
            for var x = 0; x < GameOfLifeVC.NumberOfCellsPerRow; x++ {

                var cellState = gameOfLife.livingCells[y][x]
                gameCells[y][x].currentLivingViewState = cellState
            }
        }
    }

    @IBAction func stepButtonPressed(sender: UIButton) {
        gameOfLife.step()
        updateView()
    }

    @IBAction func stepBackButtonPressed(sender: UIButton) {
        gameOfLife.stepBack()
        updateView()
    }
    
    @IBAction func clearGameBoard(sender: UIButton) {
        
        for v in gameBoard.subviews {
            v.removeFromSuperview()
        }
        
        gameOfLife = GameOfLideModel()
    }

}

extension GameOfLifeVC {
    
    
}

