//
//  SettingsViewController.swift
//  tippy
//
//  Created by alex_liu on 10/11/16.
//  Copyright © 2016 alex_liu. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController {

  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var themeControl: UISegmentedControl!

  var tipPercentages: [Double]?

  override func viewDidLoad() {
    super.viewDidLoad()

    loadDefaults()

    let defaults = UserDefaults.standard

    if let tipPercentages = defaults.object(forKey: "tip_percentages") as? [Double] {
      self.tipPercentages = tipPercentages
      for (index, element) in tipPercentages.enumerated() {
        tipControl.setTitle(String(format:"%.2f%%", element), forSegmentAt: index)
      }

      let selectedTip = defaults.integer(forKey: "tip_default")
        tipControl.selectedSegmentIndex = selectedTip


      let isDarkTheme = defaults.bool(forKey: "is_dark_theme")
      setTheme(isDarkTheme: isDarkTheme)
      themeControl.selectedSegmentIndex = isDarkTheme ? 1 : 0
      themeControl.setTitle("Light", forSegmentAt: 0)
      themeControl.setTitle("Dark", forSegmentAt: 1)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  private func loadDefaults() {
    let defaults = UserDefaults.init()

    if let tipPercentages = defaults.object(forKey: "tip_percentages") as? [Double] {
      self.tipPercentages = tipPercentages
    } else {
        // set the default tips
      defaults.set([0.18, 0.20, 0.25], forKey: "tip_percentages")
      defaults.set(0, forKey: "tip_default")
    }
  }

  private func setTheme(isDarkTheme: Bool) {
    if isDarkTheme {
      self.view.backgroundColor = UIColor.darkGray
    } else {
      self.view.backgroundColor = UIColor.init(red: 0, green: 0.651, blue: 0.6, alpha: 1.0)
    }
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

  @IBAction func setDefaultTip(_ sender: AnyObject) {
    let defaults = UserDefaults.init()
    let index = tipControl.selectedSegmentIndex
    defaults.set(index, forKey: "tip_default")
    defaults.synchronize()
  }

  @IBAction func setThemeTapped(_ sender: UISegmentedControl) {
    let defaults = UserDefaults.init()
    let isDark = themeControl.selectedSegmentIndex != 0 ? true : false
    defaults.set(isDark, forKey: "is_dark_theme")
    defaults.synchronize()

    setTheme(isDarkTheme: isDark)
  }
}
