//
//  GameOfLifeModel.swift
//  SWHGameOfLife
//
//  Created by Simon J Whitehouse on 02/10/2015.
//  Copyright © 2015 co.swhitehouse. All rights reserved.
//

import Foundation
import UIKit

struct GameOfLideModel {
    
    
    typealias GameBoardState = Array<Array<LivingView>>
    var livingCells = GameBoardState()
    
    var gameOfLifeStateStack = [GameBoardState]()
    
    mutating func buildGird() {
        var startOriginX: CGFloat = 0.0
        var startOriginY: CGFloat = 0.0
        
        let cellHeight = GameOfLifeVC.CellHeight
        
        for var y = 0; y < GameOfLifeVC.NumberOfCellsPerRow; y++ {
            livingCells.append([LivingView]())
            for var x = 0; x < GameOfLifeVC.NumberOfCellsPerRow; x++ {
                let newCell = LivingView(frame: CGRectMake(startOriginX, startOriginY, cellHeight, cellHeight))
                newCell.configure(LivingViewState.randomCellState())
                startOriginX += cellHeight
                livingCells[y].append(newCell)
            }
            
            startOriginX = 0
            startOriginY += cellHeight
            
        }
        
        gameOfLifeStateStack.append(livingCells) // initial state stack
    }
    
    mutating func step() {
        
    }
    
    typealias NeighbourCellStates = (aliveNeightbours: Bool, deadNeighbours: Bool)
    
    func neighBouringCellStates(topLeftCell: LivingViewState?, topMiddleCell: LivingViewState?, topRightCell: LivingViewState?, leftCenter: LivingViewState?, rightCenter: LivingViewState?, bottomLeftCell: LivingViewState?, bottomMiddle: LivingViewState?, bottomRightCell: LivingViewState?) -> NeighbourCellStates {
        
        
        for neighBour in [topLeftCell, topMiddleCell, topRightCell, leftCenter, rightCenter, bottomLeftCell, bottomMiddle, bottomRightCell] {
            
            
            
        }
        
        
        return (true, false)
    }
    
//    Any live cell with fewer than two live neighbours dies, as if caused by under-population.
//    Any live cell with two or three live neighbours lives on to the next generation.
//    Any live cell with more than three live neighbours dies, as if by over-population.
//    Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    
    
    
    
}