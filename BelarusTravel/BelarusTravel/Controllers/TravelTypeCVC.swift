//
//  TravelTypeCVC.swift
//  BelarusTravel
//
//  Created by Eugene on 06/03/2023.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftUI

private let reuseIdentifier = "Cell"

final class TravelTypeCVC: UICollectionViewController {
    
    //MARK: - Properties
    
    var places: [Place]?

    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Collection view data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places?.count ?? 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        cell.nameLabel.text = places?[indexPath.row].namePlace
        let backgroundPhotoURL = places?[indexPath.row].photoURL
        cell.backgroundPhotoUrl = backgroundPhotoURL
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let place = places?[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        tabVC.typePlace = place
        navigationController?.pushViewController(tabVC, animated: true)
    }
    
    private func setupUI() {
        collectionView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "flower12"))
        
    }
    

}
