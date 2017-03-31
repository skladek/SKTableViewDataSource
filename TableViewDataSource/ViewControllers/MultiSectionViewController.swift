//
//  MultiSectionViewController.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

class MultiSectionViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var dataSource: TableViewDataSource<String>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let reuseId = "MultiSectionViewControllerReuseId"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)

        let array = [["One", "Two", "Three"], ["Four", "Five", "Six"], ["Seven", "Eight", "Nine", "Ten"]]
        dataSource = TableViewDataSource(objects: array, cellReuseId: reuseId)
        tableView.dataSource = dataSource
    }
}

extension MultiSectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = dataSource?.object(indexPath)

        cell.textLabel?.text = object
    }
}
