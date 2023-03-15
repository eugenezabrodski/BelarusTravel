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

class TravelTypeCVC: UICollectionViewController {
    
    //var region: Region?
    
    var places: TravelType?

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // тут в базе данных надо создавать массив плэйсайди
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        cell.nameLabel.text = places?.place?.namePlace
        let backgroundPhotoURL = places?.place?.photoURL
        cell.backgroundPhotoUrl = backgroundPhotoURL
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dest = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
//        dest.placeName = places
//        navigationController?.pushViewController(dest, animated: true)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showTabBarController" else { return }
        let tabBarViewController = segue.destination as! TabBarViewController
        tabBarViewController.placeName = places
    }
    
    
    
//    @IBSegueAction func toInformationView(_ coder: NSCoder, sender: Any?) -> UIViewController? {
//
//        guard let indexPath = collectionView.indexPathsForSelectedItems else {
//            return nil
//        }
//        let place = places
//        return UIHostingController(coder: coder, rootView: InformationView(place: place))
//    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
