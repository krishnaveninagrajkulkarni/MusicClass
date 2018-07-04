//
//  NewRaagViewController.swift
//  MusicClass
//
//  Created by krishnaveni kulkarni on 22/06/18.
//  Copyright © 2018 krishnaveni kulkarni. All rights reserved.
//

import UIKit
import CoreData

protocol sendDataToRaagTable{
    
    func delegateMethodOfNewRaag(data: String)
}

class NewRaagViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var bottomViewForSaveButton: UIView!
    @IBOutlet var newRaagView: UIView!
    @IBOutlet weak var raagNameTextField: UITextField!
    
    @IBOutlet weak var saptakTextView: UITextView!
    @IBOutlet weak var taalTextView: UITextView!
    @IBOutlet weak var sargamTextView: UITextView!
    @IBOutlet weak var jaankariTextView: UITextView!
    
    var sendDataDelegate : sendDataToRaagTable?

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        raagNameTextField.delegate = self
        saptakTextView.delegate = self
        taalTextView.delegate = self
        sargamTextView.delegate = self
        jaankariTextView.delegate = self
        
        //Create a Tap Gesture - when user clicks on View after typing is donein textfield, the keyboard should gooff
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title =  "New Raag Details"
        newRaagView.backgroundColor = UIColor.flatSkyBlue
        bottomViewForSaveButton.backgroundColor = UIColor.flatSkyBlue
    }
    
    
    //Mark - TextField n TextView Delegates Methods
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == jaankariTextView {
            listenToKeyboardNotifications()
        }
        return true
    }
 
    func textViewDidEndEditing(_ textView: UITextView) {
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
      let keyboardRect =  (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
    
        if notification.name == NSNotification.Name.UIKeyboardWillHide {
           
            newRaagView.frame.origin.y = 0
        }else {
             newRaagView.frame.origin.y  = (-((keyboardRect?.height)!))
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
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        let newRaag = NewRaagDetails(context: context)
        
        newRaag.raagName = raagNameTextField.text!
        newRaag.saptak = saptakTextView.text
        newRaag.taal = taalTextView.text
        newRaag.sargamGeet = sargamTextView.text
        newRaag.jaankari = jaankariTextView.text

        saveNewRaagDetails()
        print("Data Saved Successfully......")
        
        let alert = UIAlertController(title: "Alert", message: "Raag Saved Successfully ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default comment"), style: .default, handler: { (_) in
            print("OK Alert!!")
           self.navigationController?.popViewController(animated: true)  // GoBack to previous controller of stack of Navigation Controller
        }))
        present(alert, animated: true , completion: nil)
        //Send Only new added Raag Name to RaagsTableViewController to display raagName on its list
        sendDataDelegate?.delegateMethodOfNewRaag(data: raagNameTextField.text!)
        
    }
    func saveNewRaagDetails(){
        do{
            try context.save()
            
        }catch{
            print("Error in saving \(error)")
        }
    }
    
    
}
