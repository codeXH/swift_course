//
//  SettingsViewController.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    
    func controllerDidChangeTimeMode(controller: SettingsViewController)
    func controllerDidChangeTempuratureMode(controller: SettingsViewController)
}

class SettingsViewController: UITableViewController {

    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected section index")
        }
        return section.numbersOfRows
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Date format"
        }
        return "Temperature unit"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.reuseIdentifier, for: indexPath) as? SettingsTableCell else {
            fatalError("Unexpected talbe view cell")
        }
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        var vm: SettingsRepresentable?
        switch section {
        case .date:
            guard let dateMode = DateMode.init(rawValue: indexPath.row) else {
                fatalError("Invalide IndexPath")
            }
            vm = SettingsDateViewModel.init(dateMode: dateMode)
            
        case .tempurature:
            guard let temperatureMode = TemperatureMode.init(rawValue: indexPath.row) else {
                fatalError("Invalide IndexPath")
            }
            vm = SettingsTemperatureViewModel.init(temperatureMode: temperatureMode)
        }
        if let vm = vm {
            cell.configue(with: vm)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section index")
        }
        switch section {
        case .date:
            let dateMode = UserDefaults.dateMode()
            
            guard indexPath.row != dateMode.rawValue else { return }
            
            if let newMode = DateMode.init(rawValue: indexPath.row) {
                UserDefaults.setDateMode(to: newMode)
            }
            delegate?.controllerDidChangeTimeMode(controller: self)
            
        case .tempurature:
            let tempuratureMode = UserDefaults.temperatureMode()
            
            guard indexPath.row != tempuratureMode.rawValue else { return }
            
            if let newMode = TemperatureMode.init(rawValue: indexPath.row) {
                UserDefaults.setTemperatureMode(to: newMode)
            }
            delegate?.controllerDidChangeTempuratureMode(controller: self)
        }
        
        let sections = IndexSet(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
    }
}

extension SettingsViewController {
    
    private enum Section: Int {
        case date
        case tempurature
        
        var numbersOfRows: Int {
            return 2
        }
        
        static var count: Int {
            return Section.tempurature.rawValue + 1
        }
    }
}






