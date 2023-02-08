//
//  RegionTableViewController.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 1.02.23.
//

import UIKit
import Firebase
import FirebaseStorage

class RegionTableViewController: UITableViewController {
    
    var arrayOfRegion = [Region]()
    let headerID = String(describing: CustomHeaderView.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backgroundViewTableView.png"))
        arrayOfRegion = [
            Region(region: "Бресткая область", typeTravel: ["архитектура", "природа", "музеи"], isExpanded: false),
            Region(region: "Минская область", typeTravel: ["архитектура", "природа", "музеи"], isExpanded: false),
            Region(region: "Витебская область", typeTravel: ["архитектура", "природа", "музеи"], isExpanded: false),
            Region(region: "Гомельская область", typeTravel: ["архитектура", "природа", "музеи"], isExpanded: false),
            Region(region: "Гродненская область", typeTravel: ["архитектура", "природа", "музеи"], isExpanded: false),
            Region(region: "Могилевская область", typeTravel: ["архитектура", "природа", "музеи"], isExpanded: false)
        ]
         
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        arrayOfRegion.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !arrayOfRegion[section].isExpanded {
                    return 0
                }
        return arrayOfRegion[section].typeTravel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = arrayOfRegion[indexPath.section].typeTravel[indexPath.row]
        cell.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backgroundViewTableView.png"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! CustomHeaderView
        header.configure(title: arrayOfRegion[section].region, section: section)
        header.rotateImage(arrayOfRegion[section].isExpanded)
        header.delegate = self
        return header
        }
        
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 60
        }
    
    
    private func tableViewConfig() {
            let nib = UINib(nibName: headerID, bundle: nil)
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
            tableView.tableFooterView = UIView()
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

extension RegionTableViewController: HeaderViewDelegate {
func expandedSection(button: UIButton) {
let section = button.tag

let isExpanded = arrayOfRegion[section].isExpanded
    arrayOfRegion[section].isExpanded = !isExpanded

tableView.reloadSections(IndexSet(integer: section), with: .automatic)
}
}
