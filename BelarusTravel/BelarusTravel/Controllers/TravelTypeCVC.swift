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
    
    var places: [Place]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // тут в базе данных надо создавать массив плэйсайди
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
//        let region = regions[indexPath.section].travelType[indexPath.row]?.place
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "TravelTypeCVC") as! TravelTypeCVC
//        vc.places = region as? [Place]
        let place = places?[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        tabVC.typePlace = place
//        let dest = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
//        dest.typePlace = places?[indexPath.row]
        navigationController?.pushViewController(tabVC, animated: true)
    }
    
     //тут я закоментирую и удалю сегу и попробую через сториборд выше
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        //guard let indexPath = collectionView. else { return }
//        guard segue.identifier == "showTabBarController" else { return }
//        let tabBarViewController = segue.destination as! TabBarViewController
//        tabBarViewController.typePlace = places
//    }
    
    
    
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

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

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
