//
//  ViewController.swift
//  tippy
//
//  Created by alex_liu on 10/11/16.
//  Copyright © 2016 alex_liu. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var tipControl: UISegmentedControl!

  var tipPercentages: [Double]?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    loadDefaults()
    calculateTip(self)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Auto-show keyboard
    billField.becomeFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func loadDefaults() {
    let defaults = UserDefaults.standard

    if let tipPercentages = defaults.object(forKey: "tip_percentages") as? [Double] {
        print(tipPercentages)
        self.tipPercentages = tipPercentages
        for (index, element) in tipPercentages.enumerated() {
            tipControl.setTitle(String(format:"%.2f%%", element), forSegmentAt: index)
        }
    } else {
        // set the default tips
        defaults.set([0.18, 0.20, 0.25], forKey: "tip_percentages")
        defaults.set(0, forKey: "tip_default")
        defaults.synchronize()
    }

    let selectedTip = defaults.integer(forKey: "tip_default")
    tipControl.selectedSegmentIndex = selectedTip

    let isDarkTheme = defaults.bool(forKey: "is_dark_theme")
    setTheme(isDarkTheme: isDarkTheme)

  }

  private func setTheme(isDarkTheme: Bool) {
    if isDarkTheme {
      self.view.backgroundColor = UIColor.darkGray
    } else {
      self.view.backgroundColor = UIColor.init(red: 0, green: 0.651, blue: 0.6, alpha: 1.0)
    }
  }

  @IBAction func onTap(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }

  @IBAction func calculateTip(_ sender: AnyObject) {

    if let billText = billField.text, let tipPercentages = self.tipPercentages {

      let billAmount = Double(billText) ?? 0
      let tipAmount = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
      let totalAmount = billAmount + tipAmount

      tipLabel.text = String(format: "$%.2f", tipAmount)
      totalLabel.text = String(format: "$%.2f", totalAmount)
    }
  }

  @IBAction func didTapTipControl(_ sender: AnyObject) {
    calculateTip(sender)
  }
}

