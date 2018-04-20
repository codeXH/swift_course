//
//  LocationTableViewCell.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/19.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    static let reuseIdentifier = "LocationCell"
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configue(of viewModel: LocationRepresentable) {
        self.label.text = viewModel.labelText
    }

}
