//
//  EditableViewController.swift
//  TableViewDataSource
//
//  Created by Sean on 5/11/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import TableViewDataSource
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

        let array = ["Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona", "California", "Colorado", "Connecticut", "District of Columbia", "Delaware", "Florida", "Georgia", "Guam", "Hawaii", "Iowa", "Idaho", "Illinois", "Indiana", "Kansas", "Kentucky", "Louisiana", "Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana", "North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Virginia", "Virgin Islands", "Vermont", "Washington", "Wisconsin", "West Virginia", "Wyoming"]
        dataSource = TableViewDataSource(objects: array, cellReuseId: reuseId, cellPresenter: { (cell, object) in
            cell.textLabel?.text = object
        })

        dataSource?.delegate = self
        tableView.dataSource = dataSource

        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItem = editButton
    }
}

extension EditableViewController: TableViewDataSourceDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle != .delete {
            return
        }

        dataSource?.delete(indexPath: indexPath)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource?.moveFrom(sourceIndexPath, to: destinationIndexPath)
    }
}
