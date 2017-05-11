//
//  EditableViewController.swift
//  TableViewDataSource
//
//  Created by Sean on 5/11/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

class EditableViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var dataSource: TableViewDataSource<String>?

    func editTapped() {
        tableView.isEditing = !tableView.isEditing
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let reuseId = "SingleSectionViewControllerReuseId"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)

        let array = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
        dataSource = TableViewDataSource(objects: array, cellReuseId: reuseId)
        dataSource?.delegate = self
        tableView.dataSource = dataSource

        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = editButton
    }
}

extension EditableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = dataSource?.object(indexPath)

        cell.textLabel?.text = object
    }
}

extension EditableViewController: TableViewDataSourceDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < 5
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }

        dataSource?.delete(indexPath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
