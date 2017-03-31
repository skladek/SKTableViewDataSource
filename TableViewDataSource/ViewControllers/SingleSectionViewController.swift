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
    let dataSource: TableViewDataSource<String>

    init() {
        dataSource = TableViewDataSource(objects: array)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: dataSource.reuseId)
        tableView.dataSource = dataSource
    }
}

extension SingleSectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = dataSource.object(indexPath)

        cell.textLabel?.text = object
    }
}
