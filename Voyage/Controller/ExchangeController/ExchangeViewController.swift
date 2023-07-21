//
//  ExchangeTableViewController.swift
//  Voyage
//
//  Created by HAMDI TLILI on 18/05/2023.
//

import UIKit

class ExchangeViewController: UIViewController, UITextFieldDelegate, ExchangeDelegate {
    
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    @IBOutlet weak var exchangeTextField: UITextField!
    
    var exchangeManager = ExchangeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeManager.delegate = self
        exchangeTextField.delegate = self
        
    }
    @IBAction func exchangeButton(_ sender: UIButton) {
        exchangeTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        exchangeTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please type an amount€"
            return false
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        exchangeManager.getExchange()
        
    }
    func didUpdateExchange(_ exchangeManager: ExchangeManager, exchange: ExchangeModel) {
        DispatchQueue.main.async {
            guard let text = self.exchangeTextField.text,
                  let amountDouble = Double(text) else {
                return
            }
            
            let exchangeDollarRate = exchange.rateAmount(amount: amountDouble)
            
            var dollarRateString: String {
                return String(format: "%.3f", exchangeDollarRate)
            }
            self.dollarLabel.text = dollarRateString
            
            
        }
        
        
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
