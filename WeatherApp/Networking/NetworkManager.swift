//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Emil on 27.11.2022.
//

import Foundation
import UIKit
import CoreLocation

class NetworkWeatherManager {
    
    func fetchWeaterData(latitude: Double, longitude: Double, completition: @escaping (Weather) -> Void )   {
        
        let latitude = String(format: "%.2f", latitude)
        let longitude = String(format: "%.2f", longitude)
        
        let url = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,precipitation,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset&current_weather=true&windspeed_unit=ms&timezone=Europe%2FMoscow"
        
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url ) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8))
            
            if let weather = self.parceJson(with: data) {
                completition(weather)
            }
        }
        dataTask.resume()
    }
    
    
    func parceJson (with data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
            //print(weather)
        } catch let error  {
            print(error.localizedDescription)
        }
        return nil
    }
}


//if need fetchImage

//    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void ) {
//        URLSession.shared.dataTask(with: url) { (data, responce, error) in
//
//            guard let responce = responce, let data = data else {
//                print(error?.localizedDescription ?? "have a problem")
//                return
//            }
//
//            guard url == responce.url else { return }
//
//            completion(data, responce)
//        }
//    }



    

