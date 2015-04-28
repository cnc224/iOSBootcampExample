//
//  SettingsViewController.swift
//  BootcampExample
//
//  Created by Ningchong Chen on 4/28/15.
//  Copyright (c) 2015 Ningchong Chen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tipRate3Field: UITextField!
    @IBOutlet weak var tipRate2Field: UITextField!
    @IBOutlet weak var tipRate1Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getTipRates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onTipRateChanged(sender: UITextField) {
        var field = -1
        if (sender == tipRate1Field) {
            field = 0
        } else if (sender == tipRate2Field) {
            field = 1
        } else if (sender == tipRate3Field) {
            field = 2
        }
        if (field != -1) {
            setTipRate(field, tipRate: (sender.text as NSString).integerValue)
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    var tipRateKey = "tipRateKey"
    
    func getTipRates() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var key = tipRateKey
        var tipArray : [Int] = []
        
        if (defaults.valueForKey(key) == nil) {
            tipArray = [18, 20, 25]
            defaults.setObject(tipArray, forKey: key)
        } else {
            tipArray = defaults.valueForKey(key) as [Int]
        }

        tipRate1Field.text = String(format: "%d", tipArray[0] as Int)
        tipRate2Field.text = String(format: "%d", tipArray[1] as Int)
        tipRate3Field.text = String(format: "%d", tipArray[2] as Int)
    }
    
    func setTipRate(idx : Int, tipRate : Int) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipArray : [Int] = []
        if (defaults.valueForKey(tipRateKey) == nil) {
            tipArray = [18, 20, 25]
        } else {
            tipArray = defaults.valueForKey(tipRateKey) as [Int]
        }
        tipArray[idx] = tipRate
        defaults.setObject(tipArray, forKey: tipRateKey)
        defaults.synchronize()
    }
    
}