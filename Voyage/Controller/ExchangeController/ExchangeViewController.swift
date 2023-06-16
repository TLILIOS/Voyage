//
//  ExchangeTableViewController.swift
//  Voyage
//
//  Created by HAMDI TLILI on 18/05/2023.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    var dollarManager = DollarManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dollarManager.delegate = self
        
    }
    
}
//MARK: - DollarManagerDelegate

extension ExchangeViewController: DollarManagerDelegate {
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.dollarLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    func didFailWithError(error: Error) {
        print(error)
        
    }
    
}

