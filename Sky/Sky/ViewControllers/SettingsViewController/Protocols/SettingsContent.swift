//
//  SettingsContent.swift
//  Sky
//
//  Created by zhangjianyun on 2018/4/18.
//  Copyright © 2018年 Mars. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    
    var labelText: String { get }
    var accessory: UITableViewCellAccessoryType { get }
    
}
