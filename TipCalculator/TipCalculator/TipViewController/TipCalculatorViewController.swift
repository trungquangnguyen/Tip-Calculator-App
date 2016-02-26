//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by nguyen trung quang on 1/30/16.
//  Copyright © 2016 nguyen trung quang. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
    }

    override func viewWillAppear(animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func SettingButtonAction(sender: AnyObject) {
        self.navigationController?.pushViewController(SettingsViewController(), animated: false)
    }
    @IBAction func tapOn(sender: AnyObject) {
        view.endEditing(true)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
