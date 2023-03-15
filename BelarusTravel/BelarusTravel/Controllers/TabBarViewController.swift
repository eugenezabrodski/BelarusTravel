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
    //let mapView = MapsViewController()
    //var informationVC = UIHostingController(rootView: InformationView())

    override func viewDidLoad() {
        super.viewDidLoad()
        //let informationVC = UIHostingController(rootView: InformationView(place: placeName))
        //self.mapView.place = placeName
        //Как сделать нормально???
        //self.viewControllers = [informationVC, mapView]
        self.viewControllers = createTabBar()
        setupUI()
    }
    
    private func createTabBar() -> [UIViewController] {
        var array = [UIViewController]()
        let a = MapsViewController()
        a.place = placeName
        let b = UIHostingController(rootView: InformationView(place: placeName))
        array.append(b)
        array.append(a)
        return array
    }
    
    private func setupUI() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 10
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 2)
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .fill
        tabBar.tintColor = .green
        tabBar.unselectedItemTintColor = .black
        roundLayer.fillColor = UIColor.gray.cgColor
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
