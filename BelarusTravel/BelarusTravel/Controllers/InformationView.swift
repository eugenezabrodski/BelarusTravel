//
//  InformationView.swift
//  BelarusTravel
//
//  Created by Eugene on 12/03/2023.
//

import SwiftUI
import CoreLocation

struct InformationView: View {
    
    //var place: TravelType?
    var place: Place?
    
    //let a = temperature()
   //var infoTemp = "123"
    
    var body: some View {
        
        //var a: String = ""
        //var infoTemp = "123"
        
        ScrollView {
            //place?.place?.namePlace
            Text("\(place?.namePlace ?? "Not connected to Internet")")
                    .font(.title)
            //place?.place.photoURL
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
                Text("Погода сегодня - \(temperature())")
                    .bold()
                    .background(.teal)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                Spacer()
            }.padding(10)
            //"\(place?.place?.text
            Text("\(place?.text ?? "Not connected to Internet")")
                        .font(.subheadline)
                        .padding(10)
        }
    }
    
    private func temperature() -> String {
        var infoTemp = "123"
        //let lat = Double((place?.place?.coordinates?.lat)!)
        let lat = Double(place?.coordinates?.lat ?? "0.00")
        let lng = Double(place?.coordinates?.lng ?? "0.00")
        WeatherManager.shared.sendRequest(coordinates: CLLocationCoordinate2D(latitude: lat!, longitude: lng!)) { weather  in
            //var infoTemp = "123"
            DispatchQueue.main.async {
                var text = ""
                if let weather = weather {
                    text = "temp: \(weather.main.temp) feels like: \(weather.main.feels_like)"
                    infoTemp = text
                }
                //infoTemp = text
            }
        }//self.a.append(infoTemp)
        return infoTemp//self.a = infoTemp
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        //(place: TravelType(nameType: "nn", place: Place(namePlace: "Беловежская пуща", text: "Это одна из самых интересных достопримечательностей Беларуси и, пожалуй, один из самых значимых реликтов всей Европы. Это место можно назвать настоящим природно-экологическим музеем под открытым небом, ведь именно здесь до наших дней природа сохранилась в первозданном виде, здесь обитают редкие виды диких животных, а живописный древний лес буквально завораживает своей красотой. Беловежская пуща – один из четырех национальных парков Беларуси и одна из главных достопримечательностей страны. В 1992 году парк вошел в Список Всемирного культурного наследия ЮНЕСКО.", coordinates: Coordinates(lat: "23", lng: "24"), photoURL: "https://d1k39sp5rjli2z.cloudfront.net/belovezhskaya-pushcha-1.jpg")))
        InformationView(place: Place(namePlace: "Беловежская пуща", text: "Это одна из самых интересных достопримечательностей Беларуси и, пожалуй, один из самых значимых реликтов всей Европы. Это место можно назвать настоящим природно-экологическим музеем под открытым небом, ведь именно здесь до наших дней природа сохранилась в первозданном виде, здесь обитают редкие виды диких животных, а живописный древний лес буквально завораживает своей красотой. Беловежская пуща – один из четырех национальных парков Беларуси и одна из главных достопримечательностей страны. В 1992 году парк вошел в Список Всемирного культурного наследия ЮНЕСКО.", coordinates: Coordinates(lat: "23", lng: "24"), photoURL: "https://d1k39sp5rjli2z.cloudfront.net/belovezhskaya-pushcha-1.jpg"))
    }
}
