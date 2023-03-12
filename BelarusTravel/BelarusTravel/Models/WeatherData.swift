//
//  WeatherData.swift
//  BelarusTravel
//
//  Created by Eugene on 12/03/2023.
//

import UIKit

// MARK: - WeatherData

struct WeatherData: Decodable {
    var coord: Coordinate
    var weather: [Weather]
    var name: String
    var main: Main
    var base: String
    var wind: Wind
    var clouds: Clouds
}

// MARK: - Coordinates

struct Coordinate: Decodable {
    var lon: Double
    var lat: Double
}

// MARK: - Weather

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
}

// MARK: - Main

struct Main: Decodable {
    var temp: Double
    var pressure: Int
    var humidity: Int
    var temp_min: Double
    var temp_max: Double
    var feels_like: Double
}

// MARK: - Wind

struct Wind: Decodable {
    var speed: Double
    var deg: Int
}

// MARK: - Clouds

struct Clouds: Decodable {
    var all: Int
}
