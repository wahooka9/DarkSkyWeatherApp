//
//  WeatherViewModel.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 12/4/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

import UIKit

protocol WeatherUpdateDelegate {
    func update()
}

class WeatherViewModel {
    var data : DarkSky?
    let dateFormatter = DateFormatter()
    var updateService : UpdateService?
    
    var delegate : WeatherUpdateDelegate? {
        didSet {
            updateService = UpdateService(time: 5) {
                LocationService.shared.locationUpdateHandler = { location in
                    DarkSkyWeather.weatherForLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { [weak self] weatherData in
                        self?.data = weatherData
                        if let del = self?.delegate {
                            del.update()
                        }
                    }
                }
                LocationService.shared.findLocation()
            }
        }
    }
    
    func restartPollTimer(){
        updateService?.restart()
    }
    
    
    init(){
        dateFormatter.dateFormat = "EEE, dd MMM yyyy"
    }
    
    func count() -> Int {
        guard let count = data?.daily?.data.count else {
            return 0
        }
        return count
    }
    
    func getDayData(index:Int) -> DailyDatum {
        return data!.daily!.data[index]
    }
    
    func getDate() -> String {
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    func getWeatherSummary() -> String {
        if let summary = data?.currently?.summary {
            return summary
        }
        return "Unknown"
    }
    
    func getPrecipitation() -> String {
        if var precip = data?.currently?.precipProbability {
            precip *= 100
            return "\(precip)"
        }
        return "Unknown"
    }
    
    func getCurrentTemp() -> String {
        if let temp = data?.currently?.temperature {
            return "\(temp)"
        }
        return "Unknown Temprature"
    }
    
    func getWindSpeed() -> String {
        if let windSpeed = data?.currently?.windSpeed {
            return "\(windSpeed)"
        }
        return "Unknown"
    }
    
    func getCurrentIcon() -> UIImage {
        if let weather = data?.currently?.icon {
            return weather.image()
        }
        return UIImage()
    }
    
}

extension Icon {
    func image() -> UIImage {
        switch self {
        case .clearDay:
            return UIImage(named: "sunny")!
        case .clearNight:
            return UIImage(named: "moon")!
        case .cloudy:
            return UIImage(named: "cloudy")!
        case .partlyCloudyDay:
            return UIImage(named: "cloudy")!
        case .partlyCloudyNight:
            return UIImage(named: "cloudy")!
        case .rain:
            return UIImage(named: "rain")!
        case .snow:
            return UIImage(named: "snow")!
        case .tornado:
            return UIImage(named: "tornado")!
        case .fog:
            return UIImage(named: "fog")!
        case .hail:
            return UIImage(named: "hail")!
        case .sleet:
            return UIImage(named: "sleet")!
        case .thunderstorm:
            return UIImage(named: "thunderstorm")!
        case .wind:
            return UIImage(named: "wind")!
        }
    }
}

