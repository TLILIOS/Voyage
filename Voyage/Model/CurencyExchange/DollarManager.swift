//
//  CoinManager.swift
//  Voyage
//
//  Created by HAMDI TLILI on 14/06/2023.
//

import Foundation
protocol DollarManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}
struct DollarManager {
    var delegate: DollarManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/USD/EUR"
    let apiKey = "4B632E0B-9714-47CA-9C34-42B920AEED4E"
    
    func getDollarPrice(for currency: String) {
        let urlString = "\(baseURL)/?apikey=\(apiKey)"
        
        //1. Create a URL:
        if let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    
                    if let dollarPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", dollarPrice)
                        delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DollarData.self, from: data)
            let price = decodedData.rate
            return price
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
