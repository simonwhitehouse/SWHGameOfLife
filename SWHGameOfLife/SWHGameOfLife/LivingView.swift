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
}

class LivingView: UIView {
    
    var currentLivingViewState: LivingViewState = .Dead {
        didSet {
            if currentLivingViewState == .Alive {
                backgroundColor = UIColor.whiteColor()
            } else {
                backgroundColor = UIColor.clearColor()
            }
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