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
    
    static func randomCellState() -> LivingViewState {
        let randomNumber = arc4random_uniform(2) == 1
        if randomNumber {
            return .Alive
        } else {
            return .Dead
        }
    }
}

class LivingView: UIView {
    
    var currentLivingViewState: LivingViewState = .Dead {
        didSet {
            backgroundColor = currentLivingViewState == .Alive ? UIColor.whiteColor() : UIColor.clearColor()
        }
    }
    
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