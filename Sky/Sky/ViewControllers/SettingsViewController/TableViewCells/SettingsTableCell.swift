//
//  SettingsTableCell.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

class SettingsTableCell: UITableViewCell {

    static let reuseIdentifier = "SettingsTableCell"
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configue(with viewModel: SettingsRepresentable) {
        self.label.text = viewModel.labelText
        self.accessoryType = viewModel.accessory
    }
}
