//
//  HomeViewController.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    struct Selection {
        let title: String
        let viewController: UIViewController
    }

    @IBOutlet var tableView: UITableView!

    var dataSource: TableViewDataSource<Selection>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let reuseId = "HomeViewControllerReuseId"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)

        let array = [Selection(title: "Single Section", viewController: SingleSectionViewController()),
                     Selection(title: "Multiple Sections", viewController: MultiSectionViewController())]
        dataSource = TableViewDataSource(objects: array, cellReuseId: reuseId)
        tableView.dataSource = dataSource
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = dataSource?.object(indexPath) else {
            return
        }

        navigationController?.pushViewController(object.viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = dataSource?.object(indexPath)

        cell.textLabel?.text = object?.title
    }
}
