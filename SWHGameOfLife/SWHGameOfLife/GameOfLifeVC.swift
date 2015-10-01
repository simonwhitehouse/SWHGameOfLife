//
//  ViewController.swift
//  SWHGameOfLife
//
//  Created by Simon J Whitehouse on 01/10/2015.
//  Copyright © 2015 co.swhitehouse. All rights reserved.
//

import UIKit

class GameOfLifeVC: UIViewController {

    @IBOutlet weak var gameBoard: UIView! {
        didSet {
            gameBoard.layer.borderColor = UIColor.whiteColor().CGColor
            gameBoard.layer.borderWidth = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

