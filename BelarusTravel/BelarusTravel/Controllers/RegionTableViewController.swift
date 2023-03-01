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
    
    var regions: [Region] = []
    let headerID = String(describing: CustomHeaderView.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        tableViewConfig()
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "MEANWHILE"))
         
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
        regions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !regions[section].isExpanded! {
                    return 0
                }
        return regions[section].travelType!.categoriesType!.categoriesId
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = regions[indexPath.section].travelType?.categoriesType?.nameType
        cell.backgroundView = UIImageView(image: #imageLiteral(resourceName: "backgroundcell"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID) as! CustomHeaderView
        header.configure(title: regions[section].nameRegion!, section: section)
        header.rotateImage(regions[section].isExpanded!)
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

    
    private func fetchUsers() {
        guard let url = URL(string: "http://localhost:3000/travel") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            do {
                self?.regions = try JSONDecoder().decode([Region].self, from: data)
            } catch {
                print (error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
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

let isExpanded = regions[section].isExpanded
    regions[section].isExpanded = !isExpanded!

tableView.reloadSections(IndexSet(integer: section), with: .automatic)
}
}
