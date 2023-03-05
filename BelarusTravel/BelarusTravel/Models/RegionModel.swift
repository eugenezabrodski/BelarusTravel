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
    var isExpanded: Bool?
    var travelType: [TravelType?]
}

struct TravelType: Codable {
    var categoriesType: CategoriesType?
}

struct CategoriesType: Codable {
    var categoriesId: Int
    var nameType: String?
    var typeId: TypeId?
}

struct TypeId: Codable {
    var nature: PlaceId?
    var architecture: PlaceId?
    var museum: PlaceId?
}

struct PlaceId: Codable {
    var namePlace: String?
    var text: String?
    var coordinates: Coordinates?
    var photoURL: String?
}

struct Coordinates: Codable {
    let lat: String?
    let lng: String?
}

