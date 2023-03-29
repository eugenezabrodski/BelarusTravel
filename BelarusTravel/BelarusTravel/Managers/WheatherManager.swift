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
    
    func sendRequest(coordinates: CLLocationCoordinate2D, completion: @escaping (WeatherData?) -> ()) {
        
        let latilude = coordinates.latitude
        let longitude = coordinates.longitude

        let urlString = "\(ApiConstants.apiWeatherUrl)lat=\(latilude)&lon=\(longitude)&APPID=\(ApiConstants.apiAccessWeatherKey)"
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
