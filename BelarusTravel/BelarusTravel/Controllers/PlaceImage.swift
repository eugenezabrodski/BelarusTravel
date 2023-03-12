//
//  PlaceImage.swift
//  BelarusTravel
//
//  Created by Eugene on 12/03/2023.
//

import SwiftUI

struct PlaceImage: View {

   let url: URL

    var body: some View {
        getImage(from: url)
           .resizable()
           .cornerRadius(30)
           .frame(width: 230, height: 180)
           .shadow(radius: 10)
    }

    private func getImage(from url: URL) -> Image {
        guard let imageData = try? Data(contentsOf: url),
              let image = UIImage(data: imageData) else { return Image(systemName: "xmark.shield") }
        return Image(uiImage: image)
    }
}
