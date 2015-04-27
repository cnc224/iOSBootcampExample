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
    
    var tipArray = [0.18, 0.20, 0.25]
    var tipPerc = 0.18
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        tipPerc = tipArray[tipSegment.selectedSegmentIndex]
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
        tipPerc = tipArray[tipSegment.selectedSegmentIndex]
    }
}

