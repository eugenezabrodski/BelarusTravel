//
//  TabBarViewController.swift
//  BelarusTravel
//
//  Created by Eugene on 15/03/2023.
//

import UIKit
import SwiftUI

class TabBarViewController: UITabBarController {
    
    //MARK: - Properties
    
    var typePlace: Place?
 
    //MARK: - Life cicle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = createTabBar()
        setupUI()
    }
    
    //MARK: - Methods
    
    private func createTabBar() -> [UIViewController] {
        var arrayControllers = [UIViewController]()
        let mapsVC = MapsViewController()
        mapsVC.place = typePlace
        let infoVC = UIHostingController(rootView: InformationView(place: typePlace))
        let hotelVC = HotelsViewController()
        arrayControllers.append(infoVC)
        arrayControllers.append(mapsVC)
        arrayControllers.append(hotelVC)
        return arrayControllers
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
        self.viewControllers![2].tabBarItem = UITabBarItem(title: "Где отдохнуть?", image: UIImage(systemName: "map"), tag: 1)
    }
    
}
