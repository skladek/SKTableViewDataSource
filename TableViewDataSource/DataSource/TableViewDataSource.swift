//
//  TableViewDataSource.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

@objc
public protocol TableViewDataSourceDelegate {
    @objc
    optional func numberOfSections(in tableView: UITableView) -> Int

    @objc
    optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool

    @objc
    optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool

    @objc
    optional func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell?

    @objc
    optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)

    @objc
    optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)

    @objc
    optional func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int

    @objc
    optional func sectionIndexTitles(for tableView: UITableView) -> [String]?

    @objc
    optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int

    @objc
    optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?

    @objc
    optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
}

public class TableViewDataSource<T>: NSObject, UITableViewDataSource {

    // MARK: Class Types

    /// A closure to allow the presenter logic to be injected on init.
    public typealias CellPresenter = (_ cell: UITableViewCell, _ object: T) -> Void

    // MARK: Public Variables

    /// The object that acts as the delegate to the data source.
    public weak var delegate: TableViewDataSourceDelegate?

    /// An array of titles for the footer sections.
    public var footerTitles: [String]?

    /// An array of titles for the header sections.
    public var headerTitles: [String]?

    // MARK: Internal Variables

    /// The cell reuse identifier
    let reuseId: String

    // MARK: Private variables

    fileprivate let cellPresenter: CellPresenter?

    fileprivate(set) var objects: [[T]]

    // MARK: Initializers

    /// Initializes a data source with an objects array
    ///
    /// - Parameters:
    ///   - objects: The array of objects to be displayed in the table view.
    ///   - cellReuseId: The reuse id of the cell in the table view.
    public convenience init(objects: [T]?, cellReuseId: String, cellPresenter: CellPresenter? = nil) {
        var wrappedObjects: [[T]]? = nil
        if let objects = objects {
            wrappedObjects = [objects]
        }

        self.init(objects: wrappedObjects, cellReuseId: cellReuseId, cellPresenter: cellPresenter)
    }

    /// Initializes a data source with a 2 dimensional objects array
    ///
    /// - Parameters:
    ///   - objects: The array of objects to be displayed in the table view. The table view will for groups based on the sub arrays.
    ///   - cellReuseId: The reuse id of the cell in the table view.
    public init(objects: [[T]]?, cellReuseId: String, cellPresenter: CellPresenter? = nil) {
        self.cellPresenter = cellPresenter
        self.objects = objects ?? [[T]]()
        self.reuseId = cellReuseId
    }

    // MARK: Instance Methods

    /// Deletes the object at the given index path
    ///
    /// - Parameter indexPath: The index path of the object to delete.
    public func delete(indexPath: IndexPath) {
        var section = sectionArray(indexPath)
        section.remove(at: indexPath.row)
        objects[indexPath.section] = section
    }

    /// Inserts the given object at the specified index.
    ///
    /// - Parameters:
    ///   - object: The object to be inserted into the array
    ///   - indexPath: The index path to insert the item at.
    public func insert(object: T, at indexPath: IndexPath) {
        var section = sectionArray(indexPath)
        section.insert(object, at: indexPath.row)
        objects[indexPath.section] = section
    }

    /// Moves the object at the source index path to the destination index path.
    ///
    /// - Parameters:
    ///   - sourceIndexPath: The current index path of the object.
    ///   - destinationIndexPath: The index path where the object should be after the move.
    public func moveFrom(_ sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = object(sourceIndexPath)
        delete(indexPath: sourceIndexPath)
        insert(object: movedObject, at: destinationIndexPath)
    }

    /// Returns the object at the provided index path.
    ///
    /// - Parameter indexPath: The index path of the object to retrieve.
    /// - Returns: Returns the object at the provided index path.
    public func object(_ indexPath: IndexPath) -> T {
        let section = sectionArray(indexPath)

        return section[indexPath.row]
    }

    /// Sets the data source objects from a 1 dimensional array.
    ///
    /// - Parameter objects: The array to update the data store objects with.
    public func setObjects(_ objects: [T]?) {
        var wrappedObjects: [[T]]? = nil
        if let objects = objects {
            wrappedObjects = [objects]
        }

        self.setObjects(wrappedObjects)
    }

    /// Sets the data source objects to the passed in array.
    ///
    /// - Parameter objects: The array to updat the data store objects with.
    public func setObjects(_ objects: [[T]]?) {
        self.objects = objects ?? [[T]]()
    }

    // MARK: Private Methods

    private func sectionArray(_ indexPath: IndexPath) -> [T] {
        return objects[indexPath.section]
    }

    // MARK: UITableViewDataSource Methods

    public func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = delegate?.numberOfSections?(in: tableView) {
            return sections
        }

        return objects.count
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return delegate?.sectionIndexTitles?(for: tableView)
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return delegate?.tableView?(tableView, canEditRowAt: indexPath) ?? false
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return delegate?.tableView?(tableView, canMoveRowAt: indexPath) ?? true
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = delegate?.tableView?(tableView, cellForRowAt: indexPath) {
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)

        let object = self.object(indexPath)
        cellPresenter?(cell, object)

        return cell
    }

    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        delegate?.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = delegate?.tableView?(tableView, numberOfRowsInSection: section) {
            return rows
        }

        let indexPath = IndexPath(row: 0, section: section)
        let section = sectionArray(indexPath)

        return section.count
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return delegate?.tableView?(tableView, sectionForSectionIndexTitle: title, at: index) ?? -1
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var footerTitle: String?

        if let title = delegate?.tableView?(tableView, titleForFooterInSection: section) {
            footerTitle = title
        } else if section < (footerTitles?.count ?? 0) {
            footerTitle = footerTitles?[section]
        }

        return footerTitle
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerTitle: String?

        if let title = delegate?.tableView?(tableView, titleForHeaderInSection: section) {
            headerTitle = title
        } else if section < (headerTitles?.count ?? 0) {
            headerTitle = headerTitles?[section]
        }

        return headerTitle
    }
}
