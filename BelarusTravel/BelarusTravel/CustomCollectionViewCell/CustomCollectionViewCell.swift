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
    
    //MARK: - Properties
    
    var region: Region?
    
    var backgroundPhotoUrl: String? {
        didSet {
            getImage()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Methods

    func getImage() {
        guard let backgroundPhotoUrl = backgroundPhotoUrl else { return }
        
        self.getPhoto(imageURL: backgroundPhotoUrl) { [weak self] image, error in
            self?.backgroundView = UIImageView(image: image)
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
