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
        let headerTitles = ["Section One", "Section Two", "Section Three"]

        dataSource = TableViewDataSource(objects: array, cellReuseId: reuseId, cellPresenter: { (cell, object) in
            cell.textLabel?.text = object
        })

        dataSource?.headerTitles = headerTitles
        tableView.dataSource = dataSource
    }
}
