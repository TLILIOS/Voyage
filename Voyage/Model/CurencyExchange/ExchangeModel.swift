//
//  ExchageModel.swift
//  Voyage
//
//  Created by HAMDI TLILI on 18/06/2023.
//

import Foundation

struct ExchangeModel {
    var rate: Double
    

    func rateAmount(amount: Double) -> Double {
        return rate * amount
    }
}


