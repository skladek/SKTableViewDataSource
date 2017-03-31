//
//  TableViewDataSource.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

class TableViewDataSource<T>: NSObject, UITableViewDataSource {
    let reuseId: String

    let objects: [[T]]

    convenience init(objects: [T], cellReuseId: String) {
        self.init(objects: [objects], cellReuseId: cellReuseId)
    }

    init(objects: [[T]], cellReuseId: String) {
        self.objects = objects
        self.reuseId = cellReuseId
    }

    // MARK: Instance Methods

    func object(_ indexPath: IndexPath) -> T {
        let section = sectionArray(indexPath)

        return section[indexPath.row]
    }

    // MARK: Private Methods

    private func sectionArray(_ indexPath: IndexPath) -> [T] {
        return objects[indexPath.section]
    }

    // MARK: UITableViewDataSource Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        return objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let indexPath = IndexPath(row: 0, section: section)
        let section = sectionArray(indexPath)

        return section.count
    }
}
