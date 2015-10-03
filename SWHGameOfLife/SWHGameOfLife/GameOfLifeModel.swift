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
        var nextInteraction = livingCells
        
        for var y = 0; y < GameOfLifeVC.NumberOfCellsPerRow; y++ {
            for var x = 0; x < GameOfLifeVC.NumberOfCellsPerRow; x++ {
                var cell = nextInteraction[y][x]
                
                var neighbourData = neighBouringCellStates(getCellNeighbours(livingCells, cell: cell, x: x, y: y))
            }
        }
    }
    
    func getCellNeighbours(nextInteraction: GameBoardState, cell: LivingView, x: Int, y: Int) -> NeighbourCells {
        var topLeftCell: LivingViewState?
        var topMiddleCell: LivingViewState?
        var topRightCell: LivingViewState?
        var leftCenter: LivingViewState?
        var rightCenter: LivingViewState?
        var bottomLeftCell: LivingViewState?
        var bottomMiddle: LivingViewState?
        var bottomRightCell: LivingViewState?
        
        if y > 0 {
            if x > 0 {
                let cell = nextInteraction[y-1][x-1]
                topLeftCell = cell.currentLivingViewState
            }
            
            
            if x+1 < GameOfLifeVC.NumberOfCellsPerRow  {
                let nextFly = nextInteraction[y-1][x+1]
                topRightCell = cell.currentLivingViewState
            }
            
            let nextFly = nextInteraction[y-1][x]
            topMiddleCell = nextFly.currentLivingViewState
        }
        
        
        
        if y+1 < GameOfLifeVC.NumberOfCellsPerRow {
            
            if x+1 <  GameOfLifeVC.NumberOfCellsPerRow  {
                let nextFly = nextInteraction[y+1][x+1]
                bottomRightCell = nextFly.currentLivingViewState
            }
            
            let nextFly = nextInteraction[y+1][x]
            bottomMiddle = nextFly.currentLivingViewState
            
            if x-1 > 0 {
                let nextFly = nextInteraction[y+1][x-1]
                bottomLeftCell = nextFly.currentLivingViewState
            }
        }

        if x+1 < GameOfLifeVC.NumberOfCellsPerRow  {
            let nextFly = nextInteraction[y][x+1]
            rightCenter = nextFly.currentLivingViewState
        }

        if x-1 > 0 {
            let nextFly = nextInteraction[y][x-1]
            leftCenter = nextFly.currentLivingViewState
        }
        
        return (topLeftCell, topMiddleCell, topRightCell, leftCenter, rightCenter, bottomLeftCell, bottomMiddle, bottomRightCell)
    }
    
    
    typealias NeighbourCells = (topLeftCell: LivingViewState?, topMiddleCell: LivingViewState?, topRightCell: LivingViewState?, leftCenter: LivingViewState?, rightCenter: LivingViewState?, bottomLeftCell: LivingViewState?, bottomMiddle: LivingViewState?, bottomRightCell: LivingViewState?)
    typealias NeighbourCellStates = (aliveNeightbours: Int, deadNeighbours: Int)
    
    func neighBouringCellStates(neighbours: NeighbourCells) -> NeighbourCellStates {
        
        var livingCount: Int = 0
        var deadCount: Int = 0
        
        for neighBour in [neighbours.topLeftCell, neighbours.topMiddleCell, neighbours.topRightCell, neighbours.leftCenter, neighbours.rightCenter, neighbours.bottomLeftCell, neighbours.bottomMiddle, neighbours.bottomRightCell] {
            
            if neighBour == LivingViewState.Alive {
                livingCount++
            } else {
                deadCount++
            }
        }
        
        
        return (livingCount, deadCount)
    }

}