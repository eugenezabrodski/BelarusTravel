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
        
        ScrollView {
                Text("\(place?.place?.namePlace ?? "")")
                    .font(.title)
                AsyncImage(url: URL(string: (place?.place?.photoURL) ?? "person.fill")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 400, height: 250)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer(minLength: 20)
            HStack {
                Text("Погода сегодня - \(temperature())")
                    .bold()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Spacer()
            }.padding(10)
                Text("\(place?.place?.text ?? "")")
                        .font(.subheadline)
                        .padding(10)
        }
    }
    
    private func temperature() -> String {
        var infoTemp = ""
        let lat = Double((place?.place?.coordinates?.lat)!)
        let lng = Double((place?.place?.coordinates?.lng)!)
        WeatherManager.shared.sendRequest(coordinates: CLLocationCoordinate2D(latitude: lat!, longitude: lng!)) { weather in
            DispatchQueue.main.async {
                var text = ""
                if let weather = weather {
                    text = "temp: \(weather.main.temp) feels like: \(weather.main.feels_like)"
                    //infoTemp = text
                }
                infoTemp = text
            }
        }
        return infoTemp
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(place: TravelType(nameType: "nn", place: Place(namePlace: "Беловежская пуща", text: "Это одна из самых интересных достопримечательностей Беларуси и, пожалуй, один из самых значимых реликтов всей Европы. Это место можно назвать настоящим природно-экологическим музеем под открытым небом, ведь именно здесь до наших дней природа сохранилась в первозданном виде, здесь обитают редкие виды диких животных, а живописный древний лес буквально завораживает своей красотой. Беловежская пуща – один из четырех национальных парков Беларуси и одна из главных достопримечательностей страны. В 1992 году парк вошел в Список Всемирного культурного наследия ЮНЕСКО.", coordinates: Coordinates(lat: "23", lng: "24"), photoURL: "https://d1k39sp5rjli2z.cloudfront.net/belovezhskaya-pushcha-1.jpg")))
    }
}
