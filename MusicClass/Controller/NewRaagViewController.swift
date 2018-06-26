//
//  NewRaagViewController.swift
//  MusicClass
//
//  Created by krishnaveni kulkarni on 22/06/18.
//  Copyright © 2018 krishnaveni kulkarni. All rights reserved.
//

import UIKit
import CoreData

class NewRaagViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    
    @IBOutlet var newRaagView: UIView!
    @IBOutlet weak var raagNameTextField: UITextField!
    
    @IBOutlet weak var saptakTextView: UITextView!
    @IBOutlet weak var taalTextView: UITextView!
    @IBOutlet weak var sargamTextView: UITextView!
    @IBOutlet weak var jaankariTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        raagNameTextField.delegate = self
        saptakTextView.delegate = self
        taalTextView.delegate = self
        sargamTextView.delegate = self
        jaankariTextView.delegate = self
        
        //listenToKeyboardNotifications()
        
        //Create a Tap Gesture - when user clicks on View after typing is donein textfield, the keyboard should gooff
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    //Mark - TextField n TextView Delegates Methods
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("i am in textViewShouldBeginEditing")
        if textView == jaankariTextView {
            listenToKeyboardNotifications()
        }
        return true
    }
 
    func textViewDidEndEditing(_ textView: UITextView) {
          print("i am in textViewDidEndEditing")
        if textView == jaankariTextView {
            stopListeningToKeyboardNotification()
        }
    }

    func listenToKeyboardNotifications()
    {
        print("I am listening to keyboardNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func stopListeningToKeyboardNotification(){
        print("I am NOT listening to keyboardNotification")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillChange(notification: NSNotification) {
          print("notification name= \(notification.name)")
        //calculate keyboard rect area, whic is used to calculate keyboard height
       // let keyboardEndFrameScreenCoordinates =  (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
   
       // let keyboardEndrame = self.view.convert(keyboardEndFrameScreenCoordinates!, to: view.window)
        
        
      let keyboardRect =  (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        
      
        
        if notification.name == NSNotification.Name.UIKeyboardWillHide {
            print("UIView Resumes #################")
            newRaagView.frame.origin.y = 0
           // jaankariTextView.contentInset = UIEdgeInsets.zero
            
            
        }else {
             print("UIView Moved *************")
             newRaagView.frame.origin.y  = (-((keyboardRect?.height)!))
            
            //jaankariTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndrame.height, right: 0)
            //jaankariTextView.scrollIndicatorInsets = jaankariTextView.contentInset
        }
    }
    //Keyboard hides on Tap Gesture
    @objc func viewTapped()
    {
        raagNameTextField.endEditing(true)
        saptakTextView.endEditing(true)
        taalTextView.endEditing(true)
        sargamTextView.endEditing(true)
        jaankariTextView.endEditing(true)
    }

}
