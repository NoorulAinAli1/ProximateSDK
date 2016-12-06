//
//  ViewController.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit
import ProximateiOSSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func openProximateSDK () {
        self.presentViewController(ProximateSDK.openProximateSDK(), animated: true, completion: nil)
//        self.navigationController?.pushViewController(ProximateSDK.openProximateSDK(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

