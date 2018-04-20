//
//  AddLocationViewController.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/20.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController, location: Location)
}

class AddLocationViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var viewModel: AddLocationViewModel!
    var delegate: AddLocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add a location"
        searchBar.becomeFirstResponder()
        viewModel = AddLocationViewModel()
        
        viewModel.locationsDidChanges = {
            [unowned self] location in
            self.tableView.reloadData()
        }
        viewModel.queryingStatusDidChange = {
            [unowned self] isQuerying in
            if isQuerying {
                self.title = "Searching..."
            }
            else {
                self.title = "Add a location"
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else {
            fatalError("Unexpected table view cell")
        }
        
        if let viewModel = viewModel.locationViewModel(at: indexPath.row) {
            cell.configue(of: viewModel)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let location = viewModel.location(at: indexPath.row) else { return }
        delegate?.controller(self, location: location)
        navigationController?.popViewController(animated: true)
    }
}

extension AddLocationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.queryText = searchBar.text ?? ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.queryText = searchBar.text ?? ""
    }
}
