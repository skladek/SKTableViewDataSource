import UIKit

/// Provides an object to act as a UITableViewDataSource.
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

    let cellClass: UITableViewCell.Type?
    let cellNib: UINib?
    var reuseId: String?

    // MARK: Private variables

    fileprivate let cellPresenter: CellPresenter?
    fileprivate(set) var objects: [[T]]

    // MARK: Initializers

    /// Initializes a data source object. Note, using this initializer requires the delegate
    /// to always return a cell through the cellForRowAtIndex method.
    ///
    /// - Parameters:
    ///   - objects: The objects to be displayed in the table view.
    ///   - delegate: The object acting as the delegate to the data source.
    public convenience init(objects: [T]?, delegate: TableViewDataSourceDelegate) {
        let wrappedObjects = TableViewDataSource.wrapObjects(objects)

        self.init(objects: wrappedObjects, cellClass: nil, cellNib: nil, cellPresenter: nil)

        self.delegate = delegate
    }

    /// Initializes a data source object. Note, using this initializer requires the delegate
    /// to always return a cell through the cellForRowAtIndex method.
    ///
    /// - Parameters:
    ///   - objects: The objects to be displayed in the table view.
    ///   - delegate: The object acting as the delegate to the data source.
    public convenience init(objects: [[T]]?, delegate: TableViewDataSourceDelegate) {
        self.init(objects: objects, cellClass: nil, cellNib: nil, cellPresenter: nil)

        self.delegate = delegate
    }

    /// Initializes a data source object.
    ///
    /// - Parameters:
    ///   - objects: The objects to be displayed in the table view.
    ///   - cell: The nib of the cell to display in the table view.
    ///   - cellPresenter: An optional closure that can be used to inject view styling and further configuration.
    public convenience init(objects: [T]?, cell: UINib, cellPresenter: CellPresenter? = nil) {
        let wrappedObjects = TableViewDataSource.wrapObjects(objects)

        self.init(objects: wrappedObjects, cell: cell, cellPresenter: cellPresenter)
    }

    /// Initializes a data source object.
    ///
    /// - Parameters:
    ///   - objects: The objects to be displayed in the table view.
    ///   - cell: The nib of the cell to display in the table view.
    ///   - cellPresenter: An optional closure that can be used to inject view styling and further configuration.
    public convenience init(objects: [[T]]?, cell: UINib, cellPresenter: CellPresenter? = nil) {
        self.init(objects: objects, cellNib: cell, cellPresenter: cellPresenter)
    }

    /// Initializes a data source object.
    ///
    /// - Parameters:
    ///   - objects: The objects to be displayed in the table view.
    ///   - cell: The class of the cell to display in the table view.
    ///   - cellPresenter: An optional closure that can be used to inject view styling and further configuration.
    public convenience init(objects: [T]?, cell: UITableViewCell.Type, cellPresenter: CellPresenter? = nil) {
        let wrappedObjects = TableViewDataSource.wrapObjects(objects)

        self.init(objects: wrappedObjects, cellClass: cell, cellPresenter: cellPresenter)
    }

    /// Initializes a data source object.
    ///
    /// - Parameters:
    ///   - objects: The objects to be displayed in the table view.
    ///   - cell: The class of the cell to display in the table view.
    ///   - cellPresenter: An optional closure that can be used to inject view styling and further configuration.
    public convenience init(objects: [[T]]?, cell: UITableViewCell.Type, cellPresenter: CellPresenter? = nil) {
        self.init(objects: objects, cellClass: cell, cellPresenter: cellPresenter)
    }

    init(objects: [[T]]?, cellClass: UITableViewCell.Type? = nil, cellNib: UINib? = nil, cellPresenter: CellPresenter? = nil) {
        self.cellClass = cellClass
        self.cellNib = cellNib
        self.cellPresenter = cellPresenter
        self.objects = objects ?? [[T]]()
    }

    // MARK: Public Methods

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

    // MARK: Internal Methods

    func registerCellIfNeeded(tableView: UITableView) -> String {
        if let reuseId = reuseId {
            return reuseId
        }

        let generatedReuseId = UUID().uuidString

        if let cellNib = cellNib {
            tableView.register(cellNib, forCellReuseIdentifier: generatedReuseId)
        } else if let cellClass = cellClass {
            tableView.register(cellClass, forCellReuseIdentifier: generatedReuseId)
        } else {
            let exception = NSException(name: .internalInconsistencyException, reason: "A cell could not be registered because a nib or class was not provided and the TableViewDataSource delegate cellForRowAtIndexPath method did not return a cell. Provide a nib, class, or cell from the delegate method.", userInfo: nil)
            exception.raise()
        }

        self.reuseId = generatedReuseId

        return generatedReuseId
    }

    // MARK: Internal Static Methods

    static func wrapObjects(_ objects: [T]?) -> [[T]] {
        var wrappedObjects: [[T]]? = nil
        if let objects = objects {
            wrappedObjects = [objects]
        }

        return wrappedObjects ?? [[T]]()
    }

    // MARK: Private Methods

    private func sectionArray(_ indexPath: IndexPath) -> [T] {
        return objects[indexPath.section]
    }

    // MARK: UITableViewDataSource Methods

    /// UITableviewDataSource implementation.
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = delegate?.numberOfSections?(in: tableView) {
            return sections
        }

        return objects.count
    }

    /// UITableviewDataSource implementation.
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return delegate?.sectionIndexTitles?(for: tableView)
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return delegate?.tableView?(tableView, canEditRowAt: indexPath) ?? false
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return delegate?.tableView?(tableView, canMoveRowAt: indexPath) ?? true
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = delegate?.tableView?(tableView, cellForRowAt: indexPath) {
            return cell
        }

        let reuseId = registerCellIfNeeded(tableView: tableView)

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)

        let object = self.object(indexPath)
        cellPresenter?(cell, object)

        return cell
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        delegate?.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        delegate?.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = delegate?.tableView?(tableView, numberOfRowsInSection: section) {
            return rows
        }

        let indexPath = IndexPath(row: 0, section: section)
        let section = sectionArray(indexPath)

        return section.count
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return delegate?.tableView?(tableView, sectionForSectionIndexTitle: title, at: index) ?? -1
    }

    /// UITableviewDataSource implementation.
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        var footerTitle: String?

        if let title = delegate?.tableView?(tableView, titleForFooterInSection: section) {
            footerTitle = title
        } else if section < (footerTitles?.count ?? 0) {
            footerTitle = footerTitles?[section]
        }

        return footerTitle
    }

    /// UITableviewDataSource implementation.
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
