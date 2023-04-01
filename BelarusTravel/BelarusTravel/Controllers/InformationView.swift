//
//  InformationView.swift
//  BelarusTravel
//
//  Created by Eugene on 12/03/2023.
//

import SwiftUI
import CoreLocation

struct InformationView: View {
    
    var place: Place?
    @State var temperature: String = ""
    
    var body: some View {
        
        ScrollView {
            Text("\(place?.namePlace ?? "Not connected to Internet")")
                    .font(.title)
            AsyncImage(url: URL(string: (place?.photoURL) ?? "person.fill")) { image in
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
                Text("Погода сегодня: \(temperature)")
                    .bold()
                    .background(.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Spacer()
            }.padding(10)
            Text("\(place?.text ?? "Not connected to Internet")")
                        .font(.subheadline)
                        .padding(10)
        }
        .onAppear {
            temperatureInfo()
        }
    }
    
    private func temperatureInfo() {
        let lat = Double(place?.coordinates?.lat ?? "0.00")
        let lng = Double(place?.coordinates?.lng ?? "0.00")
        WeatherManager.shared.sendRequest(coordinates: CLLocationCoordinate2D(latitude: lat!, longitude: lng!)) { weather  in
            DispatchQueue.main.async {
                if let weather = weather {
                    temperature = " \(weather.main.temp), ощущается как: \(weather.main.feels_like). Cкорость ветра: \(weather.wind.speed)"
                }
            }
            
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(place: Place(namePlace: "Беловежская пуща", text: "Это одна из самых интересных достопримечательностей Беларуси и, пожалуй, один из самых значимых реликтов всей Европы. Это место можно назвать настоящим природно-экологическим музеем под открытым небом, ведь именно здесь до наших дней природа сохранилась в первозданном виде, здесь обитают редкие виды диких животных, а живописный древний лес буквально завораживает своей красотой. Беловежская пуща – один из четырех национальных парков Беларуси и одна из главных достопримечательностей страны. В 1992 году парк вошел в Список Всемирного культурного наследия ЮНЕСКО.", coordinates: Coordinates(lat: "23", lng: "24"), photoURL: "https://d1k39sp5rjli2z.cloudfront.net/belovezhskaya-pushcha-1.jpg"))
    }
}
