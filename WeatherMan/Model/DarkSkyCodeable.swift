//
//  DarkSkyCodeable.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 11/30/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

//   let welcome = try? newJSONDecoder().decode(DarkSky.self, from: jsonData)

import Foundation

struct DarkSky: Codable {
    let latitude, longitude: Double
    let timezone: String
    let currently: Currently?
    let minutely: Minutely?
    let hourly: Hourly?
    let daily: Daily?
    let alerts: [Alert]?
    let flags: Flags?
    let offset: Int?
}

struct Alert: Codable {
    let title: String
    let regions: [String]
    let severity: String
    let time, expires: Int
    let description: String
    let uri: String
}

struct Currently: Codable {
    let time: Int
    let summary: String
    let icon: Icon?
    let nearestStormDistance, nearestStormBearing: Int?
    let precipIntensity, precipProbability, temperature, apparentTemperature: Double
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility, ozone: Double
    let precipType: PrecipType?
}

enum Icon: String, Codable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case hail = "hail"
    case thunderstorm = "thunderstorm"
    case tornado = "tornado"
}

enum PrecipType: String, Codable {
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
}

struct Daily: Codable {
    let summary: String
    let icon: Icon?
    let data: [DailyDatum]
}

struct DailyDatum: Codable {
    let time: Int
    let summary: String
    let icon: Icon?
    let sunriseTime, sunsetTime: Int
    let moonPhase, precipIntensity, precipIntensityMax: Double
    let precipIntensityMaxTime: Int?
    let precipProbability: Double?
    let precipType: PrecipType?
    let temperatureHigh: Double
    let temperatureHighTime: Int
    let temperatureLow: Double
    let temperatureLowTime: Int
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Int
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Int
    let dewPoint, humidity, pressure, windSpeed: Double
    let windGust: Double
    let windGustTime, windBearing: Int
    let cloudCover: Double
    let uvIndex, uvIndexTime: Int
    let visibility, ozone, temperatureMin: Double
    let temperatureMinTime: Int
    let temperatureMax: Double
    let temperatureMaxTime: Int
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Int
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Int
}

struct Flags: Codable {
    let sources: [String]
    let nearestStation: Double
    let units: String
    
    enum CodingKeys: String, CodingKey {
        case sources
        case nearestStation = "nearest-station"
        case units
    }
}

struct Hourly: Codable {
    let summary: String
    let icon: Icon?
    let data: [Currently]?
}

struct Minutely: Codable {
    let summary: String
    let icon: Icon?
    let data: [MinutelyDatum]
}

struct MinutelyDatum: Codable {
    let time: Int
    let precipIntensity, precipProbability: Double
    let precipIntensityError: Double?
    let precipType: PrecipType?
}
