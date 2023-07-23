//
//  TranslateTableViewController.swift
//  Voyage
//
//  Created by HAMDI TLILI on 18/05/2023.
//

import UIKit

class TranslateTableViewController: UIViewController, UITextViewDelegate {
    
    
    
    @IBOutlet weak var textTranslated: UITextView!
    
    @IBOutlet weak var textToTranslate: UITextView!
    
    
    var translateManager = TranslateManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        textToTranslate.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil )
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        
    }
    @objc func keyBoardWillAppear(_ notification: Notification) {
         
        if let size = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let height = size.height
            UIView.animate(withDuration: 0.5) {
                self.view.center.y -= (height * 4/5)
            }
        }
        
    }
    @objc func keyBoardWillDisappear(_ notification: Notification) {
        
        if let size = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let height = size.height
            UIView.animate(withDuration: 0.5) {
                self.view.center.y += (height * 4/5)
            }
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textToTranslate.text = ""
        print("Did begin")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
       
        // ici je récupère ma traduction
        textTranslated.text = textToTranslate.text
        print("Did end ")
    }
    
    
    @IBAction func translate(_ sender: UIButton) {
        print(textToTranslate.text!)
        textToTranslate.endEditing(true)
        translateManager.getTranslation()
    }
    
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text != "" {
            textView.endEditing(true)
            return true
        } else {
            textView.text = "Please tape a text to be translate"
            textView.textColor = .lightGray
            textView.font = .boldSystemFont(ofSize: 20)
            return false
        }
    }
    
}


