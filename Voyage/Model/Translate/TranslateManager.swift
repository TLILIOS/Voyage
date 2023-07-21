//
//  TranslateManager.swift
//  Voyage
//
//  Created by HAMDI TLILI on 13/07/2023.
//

import Foundation

struct TranslateManager {
    let translateURL = URL(string: "https://translation.googleapis.com/language/translate/v2")!
   
    func getTranslation() {
        var request = URLRequest(url: translateURL)
        request.httpMethod = "POST"
        
        let body = "method=Translation&format=json&lang=en"
        request.httpBody = body.data(using: .utf8)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            guard let responseJSON = try? JSONDecoder().decode([String: String].self, from: data),
                   let text = responseJSON["translatedTex"] else {
                return
            }
            print(text)
        }
            
        task.resume()
    }
   
    
}
