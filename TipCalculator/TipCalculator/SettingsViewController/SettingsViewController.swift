//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by nguyen trung quang on 1/30/16.
//  Copyright © 2016 nguyen trung quang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapOn(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func disMissSelf(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
