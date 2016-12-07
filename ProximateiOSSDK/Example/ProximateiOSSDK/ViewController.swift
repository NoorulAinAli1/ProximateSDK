//
//  ViewController.swift
//  ProximateiOSSDK
//
//  Created by noorulain.ali on 12/07/2016.
//  Copyright (c) 2016 noorulain.ali. All rights reserved.
//

import UIKit
import ProximateiOSSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openSDK() {
        ProximateSDK.openProximateSDK(self)
    }
}

