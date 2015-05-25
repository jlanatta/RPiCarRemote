//
//  ViewController.swift
//  CarControl
//
//  Created by Javier Lanatta on 5/23/15.
//  Copyright (c) 2015 Quadion Techologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.performSegueWithIdentifier("showConfig", sender: self)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}