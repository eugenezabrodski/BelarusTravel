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

//struct TravelType: Codable {
  //  var categoriesType: CategoriesType?
//}

struct TravelType: Codable {
    var nameType: String?
    var place: Place?
}

//struct CategoriesType: Codable {
    //var categoriesId: Int
    //var nameType: String?
    //var place: Place?
//}

//struct Place: Codable {
   // var placeId: PlaceId
//}

struct Place: Codable {
    var namePlace: String?
    var text: String?
    var coordinates: Coordinates?
    var photoURL: String?
}

struct Coordinates: Codable {
    let lat: String?
    let lng: String?
}

