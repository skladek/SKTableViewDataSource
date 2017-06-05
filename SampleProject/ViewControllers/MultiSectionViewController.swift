//
//  MultiSectionViewController.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import TableViewDataSource
import UIKit

class MultiSectionViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var dataSource: TableViewDataSource<String>?

    override func viewDidLoad() {
        super.viewDidLoad()

        let reuseId = "MultiSectionViewControllerReuseId"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)

        let array = [["Alaska", "Alabama", "Arkansas", "American Samoa", "Arizona"], ["California", "Colorado", "Connecticut"], ["District of Columbia", "Delaware"], ["Florida"], ["Georgia", "Guam"], ["Hawaii"], ["Iowa", "Idaho", "Illinois", "Indiana"], ["Kansas", "Kentucky"], ["Louisiana"], ["Massachusetts", "Maryland", "Maine", "Michigan", "Minnesota", "Missouri", "Mississippi", "Montana"], ["North Carolina", "North Dakota", "Nebraska", "New Hampshire", "New Jersey", "New Mexico", "Nevada", "New York"], ["Ohio", "Oklahoma", "Oregon"], ["Pennsylvania", "Puerto Rico"], ["Rhode Island"], ["South Carolina", "South Dakota"], ["Tennessee", "Texas"], ["Utah"], ["Virginia", "Virgin Islands", "Vermont"], ["Washington", "Wisconsin", "West Virginia", "Wyoming"]]

        var headerTitles = [String]()

        for sectionArray in array {
            guard let firstWord = sectionArray.first else {
                continue
            }

            let firstLetter = firstWord.substring(to: firstWord.index(firstWord.startIndex, offsetBy: 1))
            headerTitles.append(firstLetter)
        }

        dataSource = TableViewDataSource(objects: array, cellReuseId: reuseId, cellPresenter: { (cell, object) in
            cell.textLabel?.text = object
        })

        dataSource?.headerTitles = headerTitles
        tableView.dataSource = dataSource
    }
}
