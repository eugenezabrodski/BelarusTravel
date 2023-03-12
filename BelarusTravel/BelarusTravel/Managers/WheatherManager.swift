//
//  WheatherManager.swift
//  BelarusTravel
//
//  Created by Eugene on 12/03/2023.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    static let shared = WeatherManager()
    private init() {}
    
    private let apiAccessKey = "3a5edcd15576a17cdf175469a6372cd3"
    private let apiUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&"
    
    //https://api.openweathermap.org/data/2.5/weather?units=metric&lat=53.902289&lon=27.561815&APPID=3a5edcd15576a17cdf175469a6372cd3
    
    func sendRequest(coordinates: CLLocationCoordinate2D, completion: @escaping (WeatherData?) -> ()) {
        
        let latilude = coordinates.latitude
        let longitude = coordinates.longitude

        let urlString = "\(apiUrl)lat=\(latilude)&lon=\(longitude)&APPID=\(apiAccessKey)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weather)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            } else {
                print(error?.localizedDescription ?? "sendRequest error")
                completion(nil)
            }
        }
        task.resume()
    }
}
