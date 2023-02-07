//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Emil on 12.12.2022.
//

import Foundation
import UIKit

struct Weather: Codable {
    
    static let sharedWeather = Weather()
    
    var name: String? = "Loading city..."
    var temperatureCurrent: Double = 0
    var elevation: Int = 0
    var weathercodeCurrent: Int = 0
    var time: String = ""
    var timeZone: String = ""
    var currentTime: String = ""
    var timeHourly: [String] = [""]
    var temperature2MHourly: [Double] = [0]
    var sunrise = [String]()
    var timezoneAbbreviation: String = ""
    var sunset = [String]()
    var timeDaily = [String]()
    var weathercodeHourly: [Int] = [5]
    var weathercodeDaily: [Int] = [0]
    var indexHourlyTime: Int = 0
    var indexSunrise: Int = 0
    var indexSunset: Int = 0
    var temperature2MMaxDaily: [Double] = [0]
    var temperature2MMinDaily: [Double] = [0]
    
    
    //MARK: format values
    var timezoneAbbreviationString: String {
        return String(timezoneAbbreviation)
    }
    
    var elevationtString: String {
        return String(elevation)
    }
    
    var temperatureCurrentString: String {
        return String(format: "%.0f", temperatureCurrent)
    }
    
    var weathercodeCurrentString: String {
        switch weathercodeCurrent {
        case 0: return "Clear sky"
        case 1: return "Mainly clear"
        case 2: return "Partly cloudy"
        case 3: return "Overcast"
        case 45, 48: return "Fog"
        case 61, 63, 65: return "Rainly"
        case 66, 67, 80, 81, 82, 96, 99: return "Rainly"
        case 95, 51, 53, 55, 56, 57: return "Rainly"
        case 85, 86, 77, 71, 73, 75: return "Snowly"
        default:
            "Download..."
        }
        return String(weathercodeCurrent)
    }
    
    var temperature2MHourlyString: [String] {
        return temperature2MHourly.map {String(format: "%.0f", $0)}
    }
    
    var weathercodeHourlyString: [String] {
        return weathercodeHourly.map{String($0)}
    }
    
    var weathercodeDailyString: [String] {
        return weathercodeDaily.map{String($0)}
    }
    
    var temperature2MMaxDailyString: [String] {
        return temperature2MMaxDaily.map{String(format: "%.0f", $0)}
    }
    
    var temperature2MMinDailyString: [String] {
        return temperature2MMinDaily.map{String(format: "%.0f", $0)}
    }
    
    func getIndex() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: currentDate)
        let hour = currentTime.prefix(2)
        return String(hour)
    }

    func getIndexForTime(weatherForHourly: [String]) -> Int {
        let ww = weatherForHourly
        let two = ww.map { time -> String in
            let start = time.index(time.startIndex, offsetBy: 11)
            let end = time.index(time.endIndex, offsetBy: -3)
            let range = start..<end
            let mySubstring = time[range]
            let string = String(mySubstring)
            return string
        }
        let gg = getIndex()
        guard let start = two.firstIndex(of: gg) else {return 0}
        
        return start
    }
    
    func currentIndexTime(weatherForHourly: [String], indexFrom: Int ) -> [String] {
        let ww = weatherForHourly
        let two = ww.map { time -> String in
            let start = time.index(time.startIndex, offsetBy: 11)
            let end = time.index(time.endIndex, offsetBy: -3)
            let range = start..<end
            let mySubstring = time[range]
            let string = String(mySubstring)
            return string
        }
        let start = indexFrom
        let uu = Array(two[start..<two.count])
        return uu
    }
    
    func currentIndexTemperature(weatherForHourly: [Double], indexFrom: Int ) -> [Double] {
        let start = indexFrom
        let yy = weatherForHourly
        let two1 = yy.map { $0 }
        let uu1 = Array(two1[start..<two1.count])
        return uu1
    }
    
    func currentIndexWCode(weatherForHourly: [Int], indexFrom: Int ) -> [Int] {
        let start = indexFrom
        let yy = weatherForHourly
        let two1 = yy.map { Int($0) }
        let uu1 = Array(two1[start..<two1.count])
        return uu1
    }
    
    //MARK: init
    init?(weatherData: WeatherData) {
        //hourlyIndex
        indexHourlyTime = getIndexForTime(weatherForHourly: weatherData.hourly.time)
        //currentWeathetSet
        time = weatherData.currentWeather.time
        temperatureCurrent = weatherData.currentWeather.temperature
        weathercodeCurrent = weatherData.currentWeather.weathercode
        //hourly
        timeHourly = currentIndexTime(weatherForHourly: weatherData.hourly.time, indexFrom: indexHourlyTime)
        temperature2MHourly = currentIndexTemperature(weatherForHourly: weatherData.hourly.temperature2M, indexFrom: indexHourlyTime)
        weathercodeHourly = currentIndexWCode(weatherForHourly: weatherData.hourly.weathercode, indexFrom: indexHourlyTime)
        //daily
        timeDaily = weatherData.daily.time
        weathercodeDaily = weatherData.daily.weathercode
        temperature2MMaxDaily = weatherData.daily.temperature2MMax
        temperature2MMinDaily = weatherData.daily.temperature2MMin
    }
    
    init() {}

}


   














//    init?(weatherHourly: Hourly) {
//        timeHourly = weatherData.time
//        temperature2MHourly = weatherData.temperature2M
//        weathercodeHourly = weatherData.weathercode
//    }
//
//    init?(weatherDaily: Daily) {
//        timeDaily = weatherData.time
//        weathercodeDaily = weatherData.weathercode
//        temperature2MMaxDaily = weatherData.temperature2MMax
//    }
    
    
    
//    func localTime11(in timeZone: String) -> String {
//        let f = ISO8601DateFormatter()
//
//        f.formatOptions = [.withFullTime]
//        f.timeZone = TimeZone(identifier: timeZone)
//
//        return f.string(from: Date())
//    }


