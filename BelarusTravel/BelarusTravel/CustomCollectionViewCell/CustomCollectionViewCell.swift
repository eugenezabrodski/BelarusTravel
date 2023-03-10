//
//  CustomCollectionViewCell.swift
//  BelarusTravel
//
//  Created by Eugene on 06/03/2023.
//

import UIKit
import Alamofire
import AlamofireImage

class CustomCollectionViewCell: UICollectionViewCell {
    // Где колдовать на юай частью, а именно обрезать углы корнер радиус??
    var region: Region?
    
    var backgroundPhotoUrl: String? {
        didSet {
            getImage()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    


    
    func getImage() {
        guard let backgroundPhotoUrl = backgroundPhotoUrl else { return }
        
        self.getPhoto(imageURL: backgroundPhotoUrl) { [weak self] image, error in
            self?.backgroundView = UIImageView(image: image)
            // и здесь же можно использовать корнер радиус??
        }
    }
    
    
    func getPhoto(imageURL: String, callback: @escaping (_ result: UIImage?, _ error: AFError?) -> Void) {
        if let image = CacheManager.shared.imageCache.image(withIdentifier: imageURL) {
            callback(image, nil)
        } else {
           AF.request(imageURL).responseImage { response in
               if case .success(let image) = response.result {

                   CacheManager.shared.imageCache.add(image, withIdentifier: imageURL)
                   callback(image, nil)
             }
            }
        }
    }

}
