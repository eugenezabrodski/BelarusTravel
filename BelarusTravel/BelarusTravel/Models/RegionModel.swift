//
//  RegionModel.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 6.02.23.
//

import UIKit

//MARK: - Region

struct Region: Codable {
    var regionId: Int
    var nameRegion: String?
    var isExpanded: Bool?
    var travelType: [TravelType?]
}

//MARK: - TravelType

struct TravelType: Codable {
    var nameType: String?
    var place: [Place?]
}

//MARK: - Place

struct Place: Codable {
    var namePlace: String?
    var text: String?
    var coordinates: Coordinates?
    var photoURL: String?
}

//MARK: - Coordinates

struct Coordinates: Codable {
    let lat: String?
    let lng: String?
}

