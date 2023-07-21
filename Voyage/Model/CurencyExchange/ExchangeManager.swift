//
//  CoinManager.swift
//  Voyage
//
//  Created by HAMDI TLILI on 14/06/2023.
//

import Foundation
protocol ExchangeDelegate {
    func didUpdateExchange(_ exchangeManager: ExchangeManager, exchange: ExchangeModel)
    func didFailWithError(error: Error)
}
struct ExchangeManager {
  
    var delegate: ExchangeDelegate?
    func getExchange() {
        let rateURL = "https://rest.coinapi.io/v1/exchangerate/EUR/USD?apikey=4B632E0B-9714-47CA-9C34-42B920AEED4E"
      performRequest(with: rateURL)
        
        
    }
        
        
    
    func performRequest(with rateURL: String) {
        if let url = URL(string: rateURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let rate = self.parseJSON(safeData) {
                        let exchange = ExchangeModel(rate: rate)
                  
                        self.delegate?.didUpdateExchange(self, exchange: exchange)
                       return
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ exchangeData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ExchangeData.self, from: exchangeData)
            let rate = decodedData.rate
            return rate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
