//
//  ViewController.swift
//  BootcampExample
//
//  Created by Ningchong Chen on 4/22/15.
//  Copyright (c) 2015 Ningchong Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSegment: UISegmentedControl!
    
    var tipArray : [Int] = [18, 20, 25]
    var tipPerc = 0.18
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        billField.text = "Tap On"
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        getTipSegment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnBillField(sender: UITextField) {
        billField.text = ""
    }
    
    @IBAction func didEditBillField(sender: UITextField) {
        updateTotalAmount()
    }

    
    
    @IBAction func onTipSegmentChanged(sender: AnyObject) {
        tipPerc = Double(tipArray[tipSegment.selectedSegmentIndex])*0.01
        updateTotalAmount()
        setTipSegment()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    func updateTotalAmount() {
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPerc
        var total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    var tipIndexKey = "tipSegmentIndex"
    func setTipSegment() {
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipSegment.selectedSegmentIndex, forKey: tipIndexKey)
        defaults.synchronize()
    }
    
    func getTipSegment() {
        var defaults = NSUserDefaults.standardUserDefaults()
        var defaultTipSegmentIndex = 0
        if (defaults.valueForKey(tipIndexKey) != nil) {
            defaultTipSegmentIndex = defaults.integerForKey(tipIndexKey)
        }
        tipSegment.selectedSegmentIndex = defaultTipSegmentIndex
        
        if (defaults.valueForKey(tipRateKey) != nil) {
            tipArray = defaults.valueForKey(tipRateKey) as [Int]
        }
        
        for (var i = 0;i < 3; ++i) {
            tipSegment.setTitle(String(format: "%d%%",tipArray[i]), forSegmentAtIndex: i)
        }
        tipPerc = Double(tipArray[tipSegment.selectedSegmentIndex])*0.01
    }
    var tipRateKey = "tipRateKey"
}

