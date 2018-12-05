//
//  WeatherAPIService.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 11/30/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

import Foundation

class DarkSkyWeather {
    
    static let apiURI = "https://api.darksky.net/forecast/"
    
    class func weatherForLocation(latitude:Double, longitude:Double,  completionHandler: @escaping (DarkSky)->()) {
        let longLat = "/\(latitude),\(longitude)"
        let url = apiURI + DarkSkyApiKey + longLat
        WebService.execute(urlString: url, forType: .get) { data, error  in
            do {
                if error == nil {
                    let json = try JSONDecoder().decode(DarkSky.self, from: data!)
                    completionHandler(json)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
