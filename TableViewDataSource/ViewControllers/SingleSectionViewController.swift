//
//  SingleSectionViewController.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

class SingleSectionViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    let array = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    var dataSource: TableViewDataSource<String>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let reuseId = "SingleSectionViewControllerReuseId"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)

        dataSource = TableViewDataSource(objects: array, cellReuseId: reuseId)
        tableView.dataSource = dataSource
    }
}

extension SingleSectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = dataSource?.object(indexPath)

        cell.textLabel?.text = object
    }
}
