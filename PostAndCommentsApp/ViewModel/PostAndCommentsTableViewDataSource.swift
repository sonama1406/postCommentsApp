//
//  PostTableViewDataSource.swift
//  PostAndCommentsApp
//
//  Created by Sonam Mittal on 06/08/22.
//

import Foundation
import UIKit

class PostAndCommentsTableViewDataSource<CELL: UITableViewCell, T>: NSObject, UITableViewDataSource {
    private var cellIdentifier: String?
    private var items: [T]?
    var configureCell: (CELL, T) -> Void = { _, _ in }

    init(cellIdentifier: String, items: [T], configureCell: @escaping (CELL, T) -> Void) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ?? "", for: indexPath) as! CELL
        if let items = items {
            let item = items[indexPath.row]
            configureCell(cell, item)
            return cell
        }
        return UITableViewCell()
    }
}
