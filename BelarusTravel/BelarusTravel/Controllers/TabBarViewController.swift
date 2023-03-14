//
//  TabBarViewController.swift
//  BelarusTravel
//
//  Created by Eugene on 15/03/2023.
//

import UIKit
import SwiftUI

class TabBarViewController: UITabBarController {
    
    var placeName: TravelType?
    let mapView = MapsViewController()
    //var informationVC = UIHostingController(rootView: InformationView())

    override func viewDidLoad() {
        super.viewDidLoad()
        var informationVC = UIHostingController(rootView: InformationView(place: placeName))
        self.mapView.place = placeName
        //let informationView = getData()
        //Как сделать нормально???
        self.viewControllers = [informationVC, mapView]
        setupUI()
//        self.viewControllers![0].title = "Информация"
//        self.viewControllers![1].title = "Как добраться?"
    }
    
    private func setupUI() {
        //self.viewControllers![0].title = "Информация"
        //self.viewControllers![1].title = "Как добраться?"
        self.viewControllers![0].tabBarItem = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle"), tag: 0)
        self.viewControllers![1].tabBarItem = UITabBarItem(title: "Как добраться?", image: UIImage(systemName: "map"), tag: 1)
    }
    
   
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
