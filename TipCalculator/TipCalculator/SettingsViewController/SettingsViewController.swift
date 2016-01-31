//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by nguyen trung quang on 1/30/16.
//  Copyright © 2016 nguyen trung quang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tfMin: UITextField!
    @IBOutlet weak var tfMax: UITextField!
    @IBOutlet weak var lblTipPerCent: UILabel!
    @IBOutlet weak var lblMinTipPerCent: UILabel!
    @IBOutlet weak var lblMaxTipPerCent: UILabel!
    @IBOutlet weak var sliderTipPerCent: UISlider!
    var minPerCent: Double = 0.0
    var maxPerCent: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        self.navigationController?.navigationBar.translucent = false
        
        let leftButton = UIBarButtonItem(image: UIImage(named: "back_icon"), style: .Plain, target: self, action:"leftButtonAction:")

        self.navigationItem.leftBarButtonItem = leftButton;
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if(userDefaults.valueForKey("minPerCent") != nil){
            sliderTipPerCent.minimumValue = (userDefaults.valueForKey("minPerCent")?.floatValue)!
        }else{
            sliderTipPerCent.minimumValue = 0.0
        }
        if(userDefaults.valueForKey("maxPerCent") != nil){
            sliderTipPerCent.maximumValue = (userDefaults.valueForKey("maxPerCent")?.floatValue)!
        }else{
            sliderTipPerCent.maximumValue = 100.0
        }
        if(userDefaults.valueForKey("currentPerCent") != nil){
            sliderTipPerCent.value        = (userDefaults.valueForKey("currentPerCent")?.floatValue)!
        }else{
            sliderTipPerCent.value = 0.0
        }
        
        
        lblTipPerCent.text = "%" + String(sliderTipPerCent.value)
        lblMinTipPerCent.text = String(sliderTipPerCent.minimumValue)
        lblMaxTipPerCent.text = String(sliderTipPerCent.maximumValue)
        
        minPerCent = Double(sliderTipPerCent.minimumValue)
        maxPerCent = Double(sliderTipPerCent.maximumValue)
        
        tfMax.text = String(maxPerCent)
        tfMin.text = String(minPerCent)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func leftButtonAction(Sender:UIBarButtonItem){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(minPerCent, forKey: "minPerCent")
        userDefaults.setValue(maxPerCent, forKey: "maxPerCent")
        userDefaults.setValue(sliderTipPerCent.value  , forKey: "currentPerCent")
        userDefaults.synchronize()
//        NSNotificationCenter.defaultCenter().postNotificationName("popToRoot", object: String(sliderTipPerCent.value));
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func beginEditingMinTextField(sender: AnyObject) {
        if((tfMin.text) != nil){
            tfMin.text = ""
        }
    }
    @IBAction func endEdittingMinTextField(sender: AnyObject) {
        let value = NSNumberFormatter().numberFromString(tfMin.text!)
        let min = NSNumberFormatter().numberFromString(tfMin.text!)
        let max = Float(maxPerCent)
        
        if((value) == nil || max < min?.floatValue){
            tfMin.text = String(minPerCent)
        }else{
            sliderTipPerCent.minimumValue = (value?.floatValue)!
            minPerCent = Double(sliderTipPerCent.minimumValue)
            lblMinTipPerCent.text = String(sliderTipPerCent.minimumValue)
            
            lblTipPerCent.text = "%" + String(sliderTipPerCent.value)
            //            NSNotificationCenter.defaultCenter().postNotificationName("changeMinPerCent", object: nil);
        }
    }
    @IBAction func changedMinTextField(sender: AnyObject) {
        let value = NSNumberFormatter().numberFromString(tfMin.text!)
        
        if((value) != nil){
            let _minPerCent = (value?.doubleValue)!
            if(_minPerCent > 100.0 || _minPerCent < 0){
                let alert = UIAlertController(title: "Error!", message: "Input again,Please", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                tfMin.text = ""
            }
        }else{
            
        }
        
    }
    
    @IBAction func beginEdittingMaxTextField(sender: AnyObject) {
        if((tfMax.text) != nil){
            tfMax.text = ""
        }
    }
    @IBAction func endEdittingMaxTextField(sender: AnyObject) {
        let value = NSNumberFormatter().numberFromString(tfMax.text!)
        let min = Float(minPerCent)
        let max = NSNumberFormatter().numberFromString(tfMax.text!)
        
        if((value) == nil || max?.floatValue < min){
            tfMax.text = String(maxPerCent)
        }else{
            sliderTipPerCent.maximumValue = (value?.floatValue)!
            maxPerCent = Double(sliderTipPerCent.maximumValue)
            lblMaxTipPerCent.text = String(sliderTipPerCent.maximumValue)
            
            lblTipPerCent.text = "%" + String(sliderTipPerCent.value)
            //             NSNotificationCenter.defaultCenter().postNotificationName("changeMaxPerCent", object: nil);
        }
    }
    @IBAction func changeEditMaxValueTextField(sender: AnyObject) {
        let value = NSNumberFormatter().numberFromString(tfMax.text!)
        
        if((value) != nil){
            let _maxPerCent = (value?.doubleValue)!
            if(_maxPerCent > 100.0 || _maxPerCent < 0){
                let alert = UIAlertController(title: "Error!", message: "Input again,Please", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                tfMax.text = ""
            }
        }else{
            
        }
        
    }
 
    @IBAction func changedValueTipPerCent(sender: AnyObject) {
        lblTipPerCent.text = "%" + String(sliderTipPerCent.value)
//         NSNotificationCenter.defaultCenter().postNotificationName("changeTipPerCent", object: String(sliderTipPerCent.value));

    }

    @IBAction func tapOn(sender: AnyObject) {
        view.endEditing(true)
    }
}
