//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by nguyen trung quang on 1/30/16.
//  Copyright © 2016 nguyen trung quang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var pickerTipView: UIPickerView!
    @IBOutlet weak var pickerSplit: UIPickerView!
    
    
    var pickerTipDataSource: NSMutableArray = []
    var pickerSplitDataSource: NSMutableArray = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.pickerTipView.dataSource = self
        self.pickerTipView.delegate = self
        
        self.pickerSplit.dataSource = self
        self.pickerSplit.delegate = self
        
        //set Data default for pickerView
        for var i = 0; i<=50; i++ {
            if(i == 0){
                pickerSplitDataSource.addObject("no Split")
                pickerTipDataSource.addObject("0% (Included)")
            }else{
                pickerSplitDataSource.addObject("\(i) People")
                if(i == 5){
                    pickerTipDataSource.addObject("\(i)% (Poor)")
                }else if (i == 10){
                    pickerTipDataSource.addObject("\(i)% (Fair)")
                }else if (i == 15){
                    pickerTipDataSource.addObject("\(i)% (Good)")
                }else if (i == 20){
                    pickerTipDataSource.addObject("\(i)% (Great)")
                }else if (i == 25){
                    pickerTipDataSource.addObject("\(i)% (Excellent)")
                }else{
                    pickerTipDataSource.addObject("\(i)%")
                }
            }
        }
        
        // get from USER default
        self.pickerTipView.selectRow(1, inComponent: 0, animated: true)
        self.pickerSplit.selectRow(1, inComponent: 0, animated: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 51;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView .isEqual(pickerTipView)){
            return pickerTipDataSource[row] as? String
        }
        return pickerSplitDataSource[row] as? String
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(pickerView.isEqual(pickerTipView)){
            NSNotificationCenter.defaultCenter().postNotificationName("pickerTipView", object:nil, userInfo: ["message":"\(row)"] );
        }else{
            NSNotificationCenter.defaultCenter().postNotificationName("pickerSplit", object:nil, userInfo: ["message":"\(row)"]);
        }
    }

    @IBAction func disMissSelf(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
