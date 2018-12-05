//
//  WebService.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 11/30/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

import UIKit


enum WebServiceError: Error {
    case invalidURL(forURL: String)
    case invalidRequest(error: String)
    case serialization(error: String)
    case noData
}

enum WebServiceOperation: String {
    case get = "GET"
    case post = "POST"
}

class WebService {
    typealias completionHandler = (_ data: Data?, Error?) -> Void
    
    class func execute(urlString: String, forType type: WebServiceOperation, completionHandler: @escaping completionHandler) {
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil, WebServiceError.invalidURL(forURL: urlString))
            return
        }
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = type.rawValue
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                completionHandler(nil, WebServiceError.invalidRequest(error: error?.localizedDescription ?? ""))
            }
            else {
                guard let data = data else {
                    completionHandler(nil, WebServiceError.noData)
                    return
                }
                completionHandler(data, nil)
            }
        }
        
        task.resume()
    }
}

