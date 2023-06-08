//
//  WeatherManager.swift
//  Voyage
//
//  Created by HAMDI TLILI on 08/06/2023.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c2122879715816905d687ef35e15f056&units=metric"
    
    func fetchWeather(cityname: String) {
        let urlString = "\(weatherURL)&q=\(cityname)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        let string = urlString.trimmingCharacters(in: .whitespacesAndNewlines)
        if let url = URL(string: string) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
           
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
