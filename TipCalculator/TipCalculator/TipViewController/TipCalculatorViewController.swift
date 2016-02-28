//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by nguyen trung quang on 1/30/16.
//  Copyright © 2016 nguyen trung quang. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {
//contraint for split
    @IBOutlet weak var marginLeftContrain: NSLayoutConstraint!
    @IBOutlet weak var split2_margin: NSLayoutConstraint!
    @IBOutlet weak var split3_margin: NSLayoutConstraint!
    @IBOutlet weak var split4_margin: NSLayoutConstraint!
    @IBOutlet weak var split5_margin: NSLayoutConstraint!
    @IBOutlet weak var splitmore_margin: NSLayoutConstraint!
    
//contraint for style Service
    @IBOutlet weak var service2_margin: NSLayoutConstraint!
    @IBOutlet weak var service3_margin: NSLayoutConstraint!
    @IBOutlet weak var service4_margin: NSLayoutConstraint!
    @IBOutlet weak var service5_margin: NSLayoutConstraint!
    @IBOutlet weak var servicemore_margin: NSLayoutConstraint!
    
//contraint for check Amount
    @IBOutlet weak var checkAmountMargin: NSLayoutConstraint!
// split OutLlet
    @IBOutlet weak var lblNumberSplit: UILabel!
    @IBOutlet weak var imageSplit: UIImageView!
    @IBOutlet weak var btnSplit_1: UIButton!
    @IBOutlet weak var btnSplit_2: UIButton!
    @IBOutlet weak var btnSplit_3: UIButton!
    @IBOutlet weak var btnSplit_4: UIButton!
    @IBOutlet weak var btnSplit_5: UIButton!
    @IBOutlet weak var btnMoreSplit: UIButton!
//style Service
    @IBOutlet weak var lblPercentTip: UILabel!
    @IBOutlet weak var imageStyleService: UIImageView!
    @IBOutlet weak var btnService_1: UIButton!
    @IBOutlet weak var btnService_2: UIButton!
    @IBOutlet weak var btnService_3: UIButton!
    @IBOutlet weak var btnService_4: UIButton!
    @IBOutlet weak var btnService_5: UIButton!
    @IBOutlet weak var btnServiceMore: UIButton!
//Check Amount Outlet
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var btnAmount: UIButton!
    @IBOutlet weak var imageAmount: UIImageView!
    
//__
//
    var arraySplit: NSArray = []
    var arrayService: NSArray = []
    var numberSplit: NSInteger = 0
    var percentTip: NSInteger = 0;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        
        //set Autolayout for split Icon
        let widthScreen = (UIScreen.mainScreen().bounds.size.width)
        let titleMargin = (widthScreen - (31*5) - 44 )/7
        let splitMargin = titleMargin
        marginLeftContrain.constant = titleMargin
        split2_margin.constant      = splitMargin
        split3_margin.constant      = splitMargin
        split4_margin.constant      = splitMargin
        split5_margin.constant      = splitMargin
        splitmore_margin.constant   = splitMargin
        
        //set Autolayout for style Service
        let serviceMargin = (widthScreen - (40*5) - 44 - titleMargin)/6
        service2_margin.constant = serviceMargin
        service3_margin.constant = serviceMargin
        service4_margin.constant = serviceMargin
        service5_margin.constant = serviceMargin
        servicemore_margin.constant = serviceMargin
        
        //set Autolayout for check Amount
        checkAmountMargin.constant = titleMargin
        
        //set AllButton for array
        arraySplit = [btnSplit_1,btnSplit_2,btnSplit_3,btnSplit_4,btnSplit_5,btnMoreSplit]
        arrayService = [btnService_1,btnService_2,btnService_3,btnService_4,btnService_5,btnServiceMore]
        
        //registry receive Notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedTip:", name:"pickerTipView", object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedSplit:", name:"pickerSplit", object: nil);
        
    }

    override func viewWillAppear(animated: Bool) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NSNotificationCenter.defaultCenter().removeObserver(self);
        
    }
//_____
//
    @IBAction func SettingButtonAction(sender: AnyObject) {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    @IBAction func tapOn(sender: AnyObject) {
        view.endEditing(true)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
//____
//
    @IBAction func splitAction(sender: AnyObject) {
        numberSplit = sender.tag;
        if((sender.tag) == 6){
            self.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }else{
            self.setSplit()
        }
    }
    
    @IBAction func styleServiceAction(sender: AnyObject) {
        percentTip = sender.tag * 5;
        if((sender.tag) == 6){
            self.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }else{
            self.setTip()
        }
    }
    @IBAction func checkAmountAction(sender: AnyObject) {
        print("sadas")
    }
//___receive Notification
//
    func receivedTip(notification: NSNotification){
        let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
        let messageString = userInfo["message"]
        if let number = messageString {
            self.percentTip = NSInteger(number)!
            self.setTip()
        }
    }
    func receivedSplit(notification: NSNotification){
        let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
        let messageString = userInfo["message"]
        if let number = messageString {
        self.numberSplit = NSInteger(number)!
            self.setSplit()
        }
    }
//___Private Method
//
    func setSelectedButton(index: NSInteger,array: NSArray){
        for var i = 0;i < index;i++ {
            var button = UIButton()
            button = array[i] as! UIButton
            button.selected = true;
        }
        for var i = index;i < 6;i++ {
            var button = UIButton()
            button = array[i] as! UIButton
            button.selected = false;
        }
    }
    
    func setSplit() {
        //setTextSplit()
        if(numberSplit == 1){
            lblNumberSplit.text = "";
            imageSplit.image = UIImage(named: "text_no_split");
        }else{
            lblNumberSplit.text = String(numberSplit)
            imageSplit.image = UIImage(named: "text_people_split");
        }
        //setButton Select Split
        if(numberSplit >= 6){
            self.setSelectedButton(6, array: arraySplit)
        }else{
            self.setSelectedButton(numberSplit, array: arraySplit)
        }
    }
    func setTip(){
        //setTextTip()
        lblPercentTip.text = String(percentTip)
        if(percentTip >= 25){
            imageStyleService.image = UIImage(named: "text_excellent")
        }else if(percentTip >= 20){
            imageStyleService.image = UIImage(named: "text_great")
        }else if(percentTip >= 15){
            imageStyleService.image = UIImage(named: "text_good")
        }else if(percentTip >= 10){
             imageStyleService.image = UIImage(named: "text_fair")
        }else if(percentTip >= 5){
            imageStyleService.image = UIImage(named: "text_poor")
        }else{
            imageStyleService.image = UIImage(named: "text_included")
        }
        //setButton Select Tip
        if(percentTip/5 >= 6){
            self.setSelectedButton(6, array: arrayService)
        }else{
            self.setSelectedButton(percentTip/5, array: arrayService)
        }
    }
}


