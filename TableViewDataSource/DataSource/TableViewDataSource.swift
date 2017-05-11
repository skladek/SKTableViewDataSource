//
//  TableViewDataSource.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

@objc
protocol TableViewDataSourceDelegate {
    @objc
    optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?

    @objc
    optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
}

class TableViewDataSource<T>: NSObject, UITableViewDataSource {

    // MARK: Public Variables

    var delegate: TableViewDataSourceDelegate?

    var footerTitles: [String]?

    var headerTitles: [String]?

    /// The objects array backing the table view.
    var objects: [[T]]

    // MARK: Private Variables

    /// The reuse id of the cell in the table view.
    private let reuseId: String

    /// Initializes a data source with an objects array
    ///
    /// - Parameters:
    ///   - objects: The array of objects to be displayed in the table view.
    ///   - cellReuseId: The reuse id of the cell in the table view.
    convenience init(objects: [T], cellReuseId: String) {
        self.init(objects: [objects], cellReuseId: cellReuseId)
    }


    /// Initializes a data source with a 2 dimensional objects array
    ///
    /// - Parameters:
    ///   - objects: The array of objects to be displayed in the table view. The table view will for groups based on the sub arrays.
    ///   - cellReuseId: The reuse id of the cell in the table view.
    init(objects: [[T]], cellReuseId: String) {
        self.objects = objects
        self.reuseId = cellReuseId
    }

    // MARK: Instance Methods


    /// Returns the object at the provided index path.
    ///
    /// - Parameter indexPath: The index path of the object to retrieve.
    /// - Returns: Returns the object at the provided index path.
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

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var footerTitle: String?

        if let title = delegate?.tableView?(tableView, titleForFooterInSection: section) {
            footerTitle = title
        } else if section < (footerTitles?.count ?? 0) {
            footerTitle = footerTitles?[section]
        }

        return footerTitle
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerTitle: String?

        if let title = delegate?.tableView?(tableView, titleForHeaderInSection: section) {
            headerTitle = title
        } else if section < (headerTitles?.count ?? 0) {
            headerTitle = headerTitles?[section]
        }

        return headerTitle
    }
}
