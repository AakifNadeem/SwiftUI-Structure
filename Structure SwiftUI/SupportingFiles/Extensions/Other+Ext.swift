//
//  OtherExtensions.swift
//
//  Created by Aakif Nadeem on 24/11/2023.
//

import UIKit
import Foundation

extension UITableView {
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
}
