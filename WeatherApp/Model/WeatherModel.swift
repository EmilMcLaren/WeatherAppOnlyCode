//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Emil on 28.11.2022.
//
import Foundation

// MARK: WeatherData
struct WeatherData: Codable {
    
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone: String
    let timezoneAbbreviation: String
    let elevation: Int
    let currentWeather: CurrentWeather
    let hourlyUnits: HourlyUnits
    let hourly: Hourly
    let dailyUnits: DailyUnits
    let daily: Daily

    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone = "timezone"
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation = "elevation"
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly = "hourly"
        case dailyUnits = "daily_units"
        case daily
    }
}


// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    let temperature: Double
    let windspeed: Double
    let winddirection, weathercode: Int
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature"
        case weathercode = "weathercode"
        case windspeed = "windspeed"
        case winddirection = "winddirection"
        case time = "time"
    }
}


// MARK: - Daily
struct Daily: Codable {
    let time: [String]
    let weathercode: [Int]
    let temperature2MMax, temperature2MMin: [Double]
    let sunrise, sunset: [String]

    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case sunrise, sunset
    }
}


// MARK: - DailyUnits
struct DailyUnits: Codable {
    let time, weathercode, temperature2MMax, temperature2MMin: String
    let sunrise, sunset: String

    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
        case sunrise, sunset
    }
}


// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]
    let temperature2M: [Double]
    let precipitation: [Double]
    let weathercode: [Int]
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case temperature2M = "temperature_2m"
        case precipitation = "precipitation"
        case weathercode = "weathercode"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Codable {
    let time, temperature2M, precipitation, weathercode: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case precipitation, weathercode
    }
}
