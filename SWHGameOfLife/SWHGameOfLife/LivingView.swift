//
//  LivingView.swift
//  SWHGameOfLife
//
//  Created by Simon J Whitehouse on 01/10/2015.
//  Copyright © 2015 co.swhitehouse. All rights reserved.
//

import Foundation
import UIKit

enum LivingViewState {
    case Alive, Dead
    
    /// creates a random cell state either alive or dead
    static func randomCellState() -> LivingViewState {
        let randomNumber = arc4random_uniform(2) == 1
        if randomNumber {
            return .Alive
        } else {
            return .Dead
        }
    }
}

/// Living View - represents a cell that is alive (white) or dead (black)
class LivingView: UIView {
    
    /// the curent living state of the view
    var currentLivingViewState: LivingViewState = .Dead {
        didSet {
            backgroundColor = currentLivingViewState == .Alive ? UIColor.whiteColor() : UIColor.clearColor()
        }
    }
    
    /// tap gesture for recognising taps
    lazy var tapGesture: UITapGestureRecognizer = {
        var tempTap = UITapGestureRecognizer(target: self, action: "tapped:")
        return tempTap
    }()
    
    func tapped(tapGesture: UITapGestureRecognizer) {
        currentLivingViewState = currentLivingViewState == .Dead ? .Alive : .Dead
    }
    
    func configure(startState: LivingViewState) {
        addGestureRecognizer(tapGesture)
        currentLivingViewState = startState
    }
    
}