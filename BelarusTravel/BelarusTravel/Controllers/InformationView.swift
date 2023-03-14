//
//  InformationView.swift
//  BelarusTravel
//
//  Created by Eugene on 12/03/2023.
//

import SwiftUI
import CoreLocation

struct InformationView: View {
    
    var place: TravelType?
    
    var body: some View {
        VStack {
            Text("\(place?.place?.namePlace ?? "")")
                .font(.largeTitle)
            VStack(alignment: .center, spacing: 20) {
                AsyncImage(url: URL(string: (place?.place?.photoURL)!))
                VStack {
                    Text("Погода сегодня - \(temperature())")
                    Text("Координаты: - широта -\(place?.place?.coordinates?.lat ?? "") долгота - \(place?.place?.coordinates?.lng ?? "")")
                }
                .font(.headline)
                HStack {
                    Text("\(place?.place?.text ?? "")")
                }
                .font(.headline)
            }
            .padding(.top)
            
            Spacer()
        }.padding(.top)
    }
    
    private func temperature() -> String {
        var infoTemp = ""
        let lat = Double((place?.place?.coordinates?.lat)!)
        let lng = Double((place?.place?.coordinates?.lng)!)
        WeatherManager.shared.sendRequest(coordinates: CLLocationCoordinate2D(latitude: lat!, longitude: lng!)) { weather in
            DispatchQueue.main.async {
                var text = ""
                if let weather = weather {
                    text = "temp: \(weather.main.temp)\nfeels like: \(weather.main.feels_like)"
                    infoTemp = text
                }
            }
        }
        return infoTemp
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(place: TravelType(nameType: "nn", place: Place(namePlace: "qwe", text: "12333333333", coordinates: Coordinates(lat: "23", lng: "24"), photoURL: "fafs")))
    }
}
