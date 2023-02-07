//
//  GetCityFromName.swift
//  WeatherApp
//
//  Created by Emil on 14.12.2022.
//

import Foundation
import CoreLocation

private let networkWeatherManager = NetworkWeatherManager()

 func getCityWeather(citiesArray: [String], completition: @escaping (Int, Weather) -> Void ) {
    for (index, item) in citiesArray.enumerated() {
        getCoordinate(city: item) { coordinate, error in
            guard let coordinate = coordinate else { return }
            
            networkWeatherManager.fetchWeaterData(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                completition(index, weather)
                //print(weather)
            }
        }
    }
}

 func getCoordinate (city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> ()) {
    CLGeocoder().geocodeAddressString(city) { placemark, error in
        completion(placemark?.first?.location?.coordinate, error)
    }
}


