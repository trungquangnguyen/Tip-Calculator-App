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
        self.navigationController?.navigationBar.translucent = false;
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "setting_icon"), style: .Plain, target: self, action:"rightButtonAction:")
//        let rightButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action:"rightButtonAction:")
        self.navigationItem.rightBarButtonItem = rightButton;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func rightButtonAction(sender:UIBarButtonItem){
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
