//
//  RegionTableViewController.swift
//  BelarusTravel
//
//  Created by Евгений Забродский on 1.02.23.
//

import UIKit

class RegionTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var regions: [Region] = []
    let headerID = String(describing: CustomHeaderView.self)
    
    //MARK: - Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRegions()
        tableViewConfig()
        setupUI()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        regions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !regions[section].isExpanded! {
                    return 0
                }
        return regions[section].travelType.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = regions[indexPath.section].travelType[indexPath.row]?.nameType
        cell.textLabel?.font = UIFont(name: "Noteworthy-Bold", size: 15)
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
            return 80
        }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let region = regions[indexPath.section].travelType[indexPath.row]?.place
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TravelTypeCVC") as! TravelTypeCVC
        vc.places = region as? [Place]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "flower11"))
    }
    
    
    private func tableViewConfig() {
            let nib = UINib(nibName: headerID, bundle: nil)
            tableView.register(nib, forHeaderFooterViewReuseIdentifier: headerID)
            tableView.tableFooterView = UIView()
        }
    
    private func fetchRegions() {

        guard let url = URL(string: ApiConstants.serverPath) else { return }

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
}

extension RegionTableViewController: HeaderViewDelegate {
    
    func expandedSection(button: UIButton) {
        let section = button.tag
        let isExpanded = regions[section].isExpanded
        regions[section].isExpanded = !isExpanded!
        
        tableView.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
