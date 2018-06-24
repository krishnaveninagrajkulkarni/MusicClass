//
//  NewRaagViewController.swift
//  MusicClass
//
//  Created by krishnaveni kulkarni on 22/06/18.
//  Copyright © 2018 krishnaveni kulkarni. All rights reserved.
//

import UIKit

class NewRaagViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var saptakTextField: UITextField!
    @IBOutlet weak var sargamTextField: UITextField!
    @IBOutlet weak var taalTextField: UITextField!
    @IBOutlet weak var jaankariTextField: UITextField!
    
    @IBOutlet var newRaagView: UIView!
    
    var kheight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saptakTextField.delegate = self
        sargamTextField.delegate = self
        taalTextField.delegate = self
        jaankariTextField.delegate = self
        
        
        
        //Create a Tap Gesture - when user clicks on View after typing is donein textfield, the keyboard should gooff
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        newRaagView.addGestureRecognizer(tapGesture)
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        print("Data Entered = \(saptakTextField.text!)")        
    }
    
    //Mark - Textfield Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == jaankariTextField {
            print("Its Jaankari text field")
        }
    }
/*
    //Mark: Configuring View for Keyboard display
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillShow:")), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillHide:")), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
                kheight = keyboardSize.height
                self.animatedTextField(up: true)
            }
        }
    }
    
    func keyboardWillHide(notification: Notification){
        self.animatedTextField(up: false)
     }
    func animatedTextField(up: Bool){
       // var movement = (up ? (-(kheight)) : (kheight))
        UIView.animate(withDuration: 0.3) {
            
        }
    }
    */
    
    @objc func viewTapped()
    {
        saptakTextField.endEditing(true)
        sargamTextField.endEditing(true)
        taalTextField.endEditing(true)
        jaankariTextField.endEditing(true)
    }

}
