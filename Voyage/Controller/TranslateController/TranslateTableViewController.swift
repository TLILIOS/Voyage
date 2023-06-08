//
//  TranslateTableViewController.swift
//  Voyage
//
//  Created by HAMDI TLILI on 18/05/2023.
//

import UIKit

class TranslateTableViewController: UIViewController {

    @IBOutlet weak var translateText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateText.delegate = self
    }

}

extension TranslateTableViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        translateText.text = ""
    }
    
}
