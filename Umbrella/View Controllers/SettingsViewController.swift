//
//  SettingsViewController.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    var currentZip = ""
    var tempScale = TempScales.f
    
    @IBAction func tempScaleChanged(_ sender: AnyObject) {
        tempScale = TempScales(rawValue: sender.selectedSegmentIndex)!
    }
    
    @IBOutlet weak var tempScaleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var zipTextField: UITextField!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(zipTextField.isFirstResponder) {
            self.view.endEditing(true)
        } else {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        zipTextField.text = currentZip
        tempScaleSegmentedControl.selectedSegmentIndex = tempScale.rawValue
        
    }
    
 
    
    

}
