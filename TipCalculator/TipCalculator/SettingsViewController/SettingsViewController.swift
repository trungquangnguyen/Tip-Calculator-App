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
        self.title = "Settings"
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .Plain, target: self, action:"leftButtonAction:")
        //        let rightButton = UIBarButtonItem(title: "Settings", style: .Plain, target: self, action:"rightButtonAction:")
        self.navigationItem.leftBarButtonItem = leftButton;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func leftButtonAction(Sender:UIBarButtonItem){
        self.navigationController?.popToRootViewControllerAnimated(true)
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
