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
    static let NumberOfCellsPerRow = 160
    
    /// size of each fly
    static let CellHeight = (320 / CGFloat(GameOfLifeVC.NumberOfCellsPerRow))

    /// UIView that contains the game board cells
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
            for _ in row {
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
    
    /// ensures the views match up to the state of the game of life game
    func updateView() {
        for var y = 0; y < GameOfLifeVC.NumberOfCellsPerRow; y++ {
            for var x = 0; x < GameOfLifeVC.NumberOfCellsPerRow; x++ {
                let cellState = gameOfLife.livingCells[y][x]
                gameCells[y][x].currentLivingViewState = cellState
            }
        }
        
        numberOfStepsCount.text = "\(gameOfLife.gameOfLifeStateStack.count)"
    }

    /// steps the game forwards - pushed on the stack
    @IBAction func stepButtonPressed(sender: UIButton) {
        gameOfLife.step()
        updateView()
    }

    /// steps the game backwards - pops off the stack
    @IBAction func stepBackButtonPressed(sender: UIButton) {
        gameOfLife.stepBack()
        updateView()
    }
    
    /// clear the game board and reset everything
    @IBAction func clearGameBoard(sender: UIButton) {
        
        numberOfStepsCount.text = "0"
        
        for v in gameBoard.subviews {
            v.removeFromSuperview()
        }
        
        gameCells = GameBoardViews()
        gameOfLife = GameOfLideModel()
        gameOfLife.buildGird()
        showCells()
    }

    /// label that keeps track of number of steps
    @IBOutlet weak var numberOfStepsCount: UILabel!
    
    /// loops the step button from being called
    @IBAction func startButtonPressed(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: "timerTicked:", userInfo: nil, repeats: true)
    }
    
    /// stops the timer properperty by calling invalidate
    @IBAction func stopButtonPressed(sender: UIButton) {
        timer?.invalidate()
    }
    
    /// timer property
    var timer: NSTimer?
}

private typealias GameOfLifeVCTimer = GameOfLifeVC
extension GameOfLifeVCTimer {
    
    /// called every 0.25 seconds
    func timerTicked(timer: NSTimer) {
        stepButtonPressed(UIButton())
    }
    
}

