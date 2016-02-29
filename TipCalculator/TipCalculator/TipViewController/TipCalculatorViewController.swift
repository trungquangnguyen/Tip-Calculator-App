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
    
    @IBOutlet weak var lblTipPerson: UILabel!
    @IBOutlet weak var lblTotalPerson: UILabel!
    
    @IBOutlet weak var lblTotalPay: UILabel!
    @IBOutlet weak var lblTotalTip: UILabel!
//__
//
    var arraySplit: NSArray = []
    var arrayService: NSArray = []
    var numberSplit: NSInteger = 1
    var percentTip: NSInteger = 5
    var textField:UITextField!
    var stringAmount:String!
    var numberDecimal: NSInteger = 0;
    
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedTip:", name:"pickerTipView", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receivedSplit:", name:"pickerSplit", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "saveData", name: UIApplicationDidEnterBackgroundNotification, object: nil)
        
        self.textField = UITextField(frame: CGRectZero)
        self.view .addSubview(self.textField);
        textField.keyboardType = .DecimalPad
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        //getData From userDefault
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if(userDefaults.valueForKey("stringAmount") != nil){
            stringAmount = userDefaults.valueForKey("stringAmount")! as! String
            lblAmount.text = "$" + stringAmount
        }else{
            stringAmount = "0"
        }
        if(userDefaults.valueForKey("numberSplit") != nil){
            numberSplit = (userDefaults.valueForKey("numberSplit")?.integerValue)!
        }else{
            numberSplit = 1
        }
        
        if(userDefaults.valueForKey("percentTip") != nil){
            percentTip = (userDefaults.valueForKey("percentTip")?.integerValue)!
        }else{
            percentTip = 0;
        }
        
        if(userDefaults.valueForKey("numberDecimal") != nil){
            numberDecimal = (userDefaults.valueForKey("numberDecimal")?.integerValue)!
        }
        self.setSplit()
        self.setTip()
        
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
        let viewControler = SettingsViewController()
        viewControler.numberSplit = numberSplit
        viewControler.tipPerCent = percentTip
        self.navigationController?.pushViewController(viewControler, animated: true)
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
        if((sender.tag) == 6){
            let viewControler = SettingsViewController()
            viewControler.numberSplit = numberSplit
            viewControler.tipPerCent = percentTip
            self.navigationController?.pushViewController(viewControler, animated: true)
        }else{
            numberSplit = sender.tag;
            self.setSplit()
        }
    }
    
    @IBAction func styleServiceAction(sender: AnyObject) {
  
        if((sender.tag) == 6){
            let viewControler = SettingsViewController()
            viewControler.numberSplit = numberSplit
            viewControler.tipPerCent = percentTip
            self.navigationController?.pushViewController(viewControler, animated: true)
        }else{
            percentTip = sender.tag * 5;
            self.setTip()
        }
    }
    @IBAction func checkAmountAction(sender: AnyObject) {
        textField.becomeFirstResponder()
        textField.text = "";
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
        self.calculate()
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
        self.calculate()
    }
    
//_____ UItextField  Did Change
//
    func textFieldDidChange(textField: UITextField) {
        if (textField.text == ""){
            textField.text = "0"
            lblAmount.text = "$0"
           return
        }
        if let number = textField.text {
            if (NSString(string: textField.text!).length > 9){
                textField.text = self.stringAmount
            }else{
                 self .formatNumberFromString(number)
            }
           
        }
    }
//_____
//
    func formatNumberFromString(var string: NSString) {
        //,xxxx
        if (string.characterAtIndex(0) == 44) {
            string = "0" + (string as String);
        }
        //0xxxx
        if (string.length > 1){
            var char =  string.characterAtIndex(0)
            var char1 = string.characterAtIndex(1)
            while ( string.length > 1 && char == 48 && char1 != 44){
                string =  string.stringByReplacingCharactersInRange(NSRange(location: 0, length: 1), withString: "")
                char =  string.characterAtIndex(0)
                if( string.length > 1 ){
                    char1 = string.characterAtIndex(1)
                }
            }
        }
        //x,x,x
        let range = string.rangeOfString(",")
        if (range.location <= 9) {
            string = string.stringByReplacingOccurrencesOfString(",", withString: "", options: .LiteralSearch, range: NSRange(location: 0, length: string.length) )
            //insert char ","
            var stringTam = "";
            for var i = 0; i < range.location; i++ {
                stringTam = stringTam + (NSString(characters:[string.characterAtIndex(i)], length: 1) as String)
            }
            stringTam = stringTam + ","
            for var i = range.location; i < string.length; i++ {
                stringTam = stringTam + (NSString(characters:[string.characterAtIndex(i)], length: 1) as String)
            }
            string = stringTam
        }
        stringAmount = string as String
        self.textField.text = stringAmount
        lblAmount.text = "$" + stringAmount
        
        self.calculate()

    }
    func calculate() {
        let string = NSString(string: stringAmount)
        if (string.length == 0){
            return
        }
        var range = string.rangeOfString(",")
        if range.location > 9 {
                  range = string.rangeOfString(".")  
        }

        var float = 0
        if range.location <= 9 {
            self.numberDecimal = string.length - range.location - 1
            for var i = 0; i<string.length ; i++ {
                if( i != range.location){
                    float = float * 10 + NSInteger(string.characterAtIndex(i)) - 48;
                }
            }
        }else{
            for var i = 0; i<string.length ; i++ {
                float = float * 10 + NSInteger(string.characterAtIndex(i)) - 48;
            }
        }
        //device for 100
        var totalPay = 0.0000
        totalPay = Double(float) * (100.00 + Double(percentTip))/100.00
        var totalTip = 0.0000
        totalTip = Double(float) * Double(percentTip)/100.00
        var totalPerPerson = 0.0000
        totalPerPerson = Double(totalPay)/Double(numberSplit)
        var tipPerPerson = 0.0000
        tipPerPerson = Double(totalTip)/Double(numberSplit)
        if(self.numberDecimal > 0){
            totalPay = totalPay/(10.000 * Double(numberDecimal))
            totalTip = totalTip/(10.000 * Double(numberDecimal))
            totalPerPerson = totalPerPerson/(10.000 * Double(numberDecimal))
            tipPerPerson = tipPerPerson/(10.000 * Double(numberDecimal))
        }
        
        

        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        lblTotalPay.text = "$" + nf.stringFromNumber(totalPay)!
        lblTotalTip.text = "$" + nf.stringFromNumber(totalTip)!
        lblTotalPerson.text = "$" + nf.stringFromNumber(totalPerPerson)!
        lblTipPerson.text = "$" + nf.stringFromNumber(tipPerPerson)!
    }
//____ Save Data
//
    func saveData(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(stringAmount  , forKey: "stringAmount")
        userDefaults.setValue(numberSplit  , forKey: "numberSplit")
        userDefaults.setValue(percentTip  , forKey: "percentTip")
        userDefaults.setValue(numberDecimal  , forKey: "numberDecimal")
        userDefaults.synchronize()
    }
    
}


