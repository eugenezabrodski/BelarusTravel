//
//  MapsViewController.swift
//  BelarusTravel
//
//  Created by Eugene on 15/03/2023.
//

import UIKit

class MapsViewController: UIViewController {
    
    var place: TravelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title?.removeAll()
        // Как убрать кнопку назад?
        self.view.backgroundColor = .gray
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
