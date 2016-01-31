//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by nguyen trung quang on 1/30/16.
//  Copyright © 2016 nguyen trung quang. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {

    @IBOutlet weak var lblTipAmount: UILabel!
    
    @IBOutlet weak var tfBillAmount: UITextField!
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var lblTipPercent: UILabel!
    
    @IBOutlet weak var sliderTipPercent: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        self.navigationController?.navigationBar.translucent = false;
        
        let rightButton = UIBarButtonItem(image: UIImage(named: "setting_icon"), style: .Plain, target: self, action:"rightButtonAction:")
        self.navigationItem.rightBarButtonItem = rightButton;
        
        tfBillAmount.adjustsFontSizeToFitWidth = true
        lblTotal.adjustsFontSizeToFitWidth = true
        lblTipAmount.adjustsFontSizeToFitWidth = true
        
        
        
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeTipPerCent:", name:"changeTipPerCent", object: nil);
    }

    override func viewWillAppear(animated: Bool) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if(userDefaults.valueForKey("minPerCent") != nil){
            sliderTipPercent.minimumValue = (userDefaults.valueForKey("minPerCent")?.floatValue)!
        }else{
            sliderTipPercent.minimumValue = 0.0
        }
        if(userDefaults.valueForKey("maxPerCent") != nil){
            sliderTipPercent.maximumValue = (userDefaults.valueForKey("maxPerCent")?.floatValue)!
        }else{
            sliderTipPercent.maximumValue = 100.0
        }
        if(userDefaults.valueForKey("currentPerCent") != nil){
            sliderTipPercent.value        = (userDefaults.valueForKey("currentPerCent")?.floatValue)!
        }else{
            sliderTipPercent.value = 0.0
        }
        
        lblTipPercent.text = "%" + String(sliderTipPercent.value)
        self.EditChangedTextField(tfBillAmount);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    
    //Notification
//    func changeTipPerCent(notification:NSNotification){
//        let string = String(notification.object)
//        let double = NSNumberFormatter().numberFromString(string)?.doubleValue
//        print(string)
//    }
    
    //Action
    func rightButtonAction(sender:UIBarButtonItem){
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }

    @IBAction func EditChangedTextField(sender: UITextField) {
        let nf = NSNumberFormatter()
        nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
        nf.maximumFractionDigits = 2
        
        lblTipPercent.text = "%" + String(sliderTipPercent.value)
        let tipPercent = Double(sliderTipPercent.value)/100
        
        
        let billAmount = NSNumberFormatter().numberFromString(sender.text!)
        
        if((billAmount) != nil){
            let tip   = billAmount!.doubleValue * tipPercent
            let total = billAmount!.doubleValue + tip
            
            lblTipAmount.text = "$"+nf.stringFromNumber(tip)!
            lblTotal.text     = "$"+nf.stringFromNumber(total)!
        }else{
            lblTipAmount.text = "$ 0.0"
            lblTotal.text  = "$ 0.0"
        }

    }

    @IBAction func sliderTipPercentChange(sender: AnyObject) {
        self.EditChangedTextField(tfBillAmount);
            let userDefaults = NSUserDefaults.standardUserDefaults()
            userDefaults.setValue(sliderTipPercent.value  , forKey: "currentPerCent")
            userDefaults.synchronize()
    }

    @IBAction func tapOn(sender: AnyObject) {
        view.endEditing(true)
    }
    
}
