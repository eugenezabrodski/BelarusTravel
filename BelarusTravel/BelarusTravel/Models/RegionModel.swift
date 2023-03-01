//
//  RegionModel.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 6.02.23.
//

import UIKit

struct Region: Codable {
    var regionId: Int
    var nameRegion: String?
    var typeId: String?
    var placeId: String?
    var text: String?
    var coordinates: Coordinates?
    var photoURL: String?
    var isExpanded: Bool?
}

struct Coordinates: Codable {
    let lat: String?
    let lng: String?
}

