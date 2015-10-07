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
    
    /// type aliase for an array off array of living view state
    typealias GameBoardState = Array<Array<LivingViewState>>
    
    /// current game state at a position in time
    var livingCells = GameBoardState()
    
    /// keeps track of the game over a period of time
    var gameOfLifeStateStack = [GameBoardState]()
    
    /// build grid of random cell states
    mutating func buildGird() {
        for var y = 0; y < GameOfLifeVC.NumberOfCellsPerRow; y++ {
            livingCells.append([LivingViewState]())
            for var x = 0; x < GameOfLifeVC.NumberOfCellsPerRow; x++ {
                livingCells[y].append(LivingViewState.randomCellState())
            }
        }
        
        gameOfLifeStateStack.append(livingCells) // initial state stack
    }
    
    /// steps back - pops off the stack and sets the next object
    mutating func stepBack() {
        if gameOfLifeStateStack.count > 1 {
            gameOfLifeStateStack.removeLast()
            livingCells = gameOfLifeStateStack.last!
        }
    }
    
    //    Any live cell with fewer than two live neighbours dies, as if caused by under-population.
    //    Any live cell with two or three live neighbours lives on to the next generation.
    //    Any live cell with more than three live neighbours dies, as if by over-population.
    //    Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
    
    /// steps forward one step - creates a new grid if needed
    mutating func step() {
        
        /// checks if game of
        if gameOfLifeStateStack.count == 0 {
            buildGird()
            return
        }
        
        var nextInteraction = livingCells
        
        for var y = 0; y < GameOfLifeVC.NumberOfCellsPerRow; y++ {
            for var x = 0; x < GameOfLifeVC.NumberOfCellsPerRow; x++ {
                var cell = nextInteraction[y][x]
                
                let neighbourData = neighBouringCellStates(getCellNeighbours(livingCells, x: x, y: y))
                
                if neighbourData.aliveNeightbours < 2 {
                    cell = LivingViewState.Dead
                } else if neighbourData.aliveNeightbours == 2 && neighbourData.aliveNeightbours == 3 && cell == LivingViewState.Alive{
                    cell = LivingViewState.Alive
                } else if neighbourData.aliveNeightbours > 3 {
                    cell = LivingViewState.Dead
                } else if neighbourData.aliveNeightbours == 3 {
                    cell = LivingViewState.Alive
                }
                
                nextInteraction[y][x] = cell
            }
        }
        
        gameOfLifeStateStack.append(nextInteraction)
        livingCells = nextInteraction
    }
    
    // gets the number counts for a cells neighbours
    func getCellNeighbours(nextInteraction: GameBoardState, x: Int, y: Int) -> NeighbourCells {
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
                topLeftCell = cell
            }
            
            
            if x+1 < GameOfLifeVC.NumberOfCellsPerRow  {
                let nextFly = nextInteraction[y-1][x+1]
                topRightCell = nextFly
            }
            
            let nextFly = nextInteraction[y-1][x]
            topMiddleCell = nextFly
        }
        
        if y+1 < GameOfLifeVC.NumberOfCellsPerRow {
            
            if x+1 <  GameOfLifeVC.NumberOfCellsPerRow  {
                let nextFly = nextInteraction[y+1][x+1]
                bottomRightCell = nextFly
            }
            
            let nextFly = nextInteraction[y+1][x]
            bottomMiddle = nextFly
            
            if x-1 > 0 {
                let nextFly = nextInteraction[y+1][x-1]
                bottomLeftCell = nextFly
            }
        }
        
        if x+1 < GameOfLifeVC.NumberOfCellsPerRow  {
            let nextFly = nextInteraction[y][x+1]
            rightCenter = nextFly
        }
        
        if x-1 > 0 {
            let nextFly = nextInteraction[y][x-1]
            leftCenter = nextFly
        }
        
        return (topLeftCell, topMiddleCell, topRightCell, leftCenter, rightCenter, bottomLeftCell, bottomMiddle, bottomRightCell)
    }
    
    
    /// type aliears for a list of cell states for all the surround cells of a central cell
    typealias NeighbourCells = (topLeftCell: LivingViewState?, topMiddleCell: LivingViewState?, topRightCell: LivingViewState?, leftCenter: LivingViewState?, rightCenter: LivingViewState?, bottomLeftCell: LivingViewState?, bottomMiddle: LivingViewState?, bottomRightCell: LivingViewState?)
    
    /// type allias for alive and dead cells
    typealias NeighbourCellStates = (aliveNeightbours: Int, deadNeighbours: Int)
    
    
    /// retruns the count of dead and alive cells
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
        
        // number of live cells and number of dead cells
        return (livingCount, deadCount)
    }
}