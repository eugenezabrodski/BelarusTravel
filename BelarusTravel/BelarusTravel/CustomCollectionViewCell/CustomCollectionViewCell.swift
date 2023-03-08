//
//  CustomCollectionViewCell.swift
//  BelarusTravel
//
//  Created by Eugene on 06/03/2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var region: Region?
    
    var url: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var backgroundCell: UIView!
    
    func fetchImage(url: String?) {
        guard let url = url,
              let url = URL(string: url) else { return }
        let uRLRequest = URLRequest(url: url)
        
        let data = URLSession.shared.dataTask(with: uRLRequest) { data, urlResponse, error in
            
            DispatchQueue.main.async {
            
            if let error = error {
                 print(error.localizedDescription)
                return
            }
            if let response = urlResponse {
                print(response)
            }
            
            print("\n", data ?? "", "\n")
            
           guard let data = data,
                 let image = UIImage(data: data) else { return }
        }
        }
        data.resume()
}
}
