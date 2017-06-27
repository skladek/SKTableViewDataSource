import Foundation

/// Exposes all of the UITableViewDataSource methods to allow overriding default implementations.
@objc
public protocol TableViewDataSourceDelegate {
    /// Asks the data source to return the number of sections in the table view.
    ///
    /// - Parameter tableView: An object representing the table view requesting this information.
    /// - Returns: The number of sections in tableView. The default value is 1.
    @objc
    optional func numberOfSections(in tableView: UITableView) -> Int

    /// Asks the data source to verify that the given row is editable.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: true if the row indicated by indexPath is editable; otherwise, false.The default value is false.
    @objc
    optional func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool

    /// Asks the data source whether a given row can be moved to another location in the table view.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: true if the row can be moved; otherwise false. The default value is true.
    @objc
    optional func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool

    /// Asks the data source for a cell to insert in a particular location of the table view.
    ///
    /// - Parameters:
    ///   - tableView: A table-view object requesting the cell.
    ///   - indexPath: An index path locating a row in tableView.
    /// - Returns: An object inheriting from UITableViewCell that the table view can use for the specified row.
    @objc
    optional func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell?

    /// Asks the data source to commit the insertion or deletion of a specified row in the receiver.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object requesting the insertion or deletion.
    ///   - editingStyle: The cell editing style corresponding to a insertion or deletion requested for the row
    ///        specified by indexPath. Possible editing styles are insert or delete.
    ///   - indexPath: An index path locating the row in tableView.
    @objc
    optional func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)

    /// Tells the data source to move a row at a specific location in the table view to another location.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object requesting this action.
    ///   - sourceIndexPath: An index path locating the row to be moved in tableView.
    ///   - destinationIndexPath: An index path locating the row in tableView that is the destination of the move.
    @objc
    optional func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)

    /// Tells the data source to return the number of rows in a given section of a table view.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object requesting this action.
    ///   - section: An index number identifying a section in tableView.
    /// - Returns: The number of rows in section.
    @objc
    optional func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int

    /// Asks the data source to return the titles for the sections for a table view.
    ///
    /// - Parameter tableView: The table-view object requesting this action.
    /// - Returns: An array of strings that serve as the title of sections in the table view and appear in the index list on the
    ///        right side of the table view. The table view must be in the plain style (UITableViewStylePlain). For example, for an
    ///        alphabetized list, you could return an array containing strings “A” through “Z”.
    @objc
    optional func sectionIndexTitles(for tableView: UITableView) -> [String]?

    /// Asks the data source to return the index of the section having the given title and section title index.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object requesting this information.
    ///   - title: The title as displayed in the section index of tableView.
    ///   - index: An index number identifying a section title in the array returned by sectionIndexTitles(for:).
    /// - Returns: An index number identifying a section.
    @objc
    optional func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int

    /// Asks the data source for the title of the footer of the specified section of the table view.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object asking for the title.
    ///   - section: An index number identifying a section of tableView .
    /// - Returns: A string to use as the title of the section footer. If you return nil, the section will have no title.
    @objc
    optional func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?

    /// Asks the data source for the title of the header of the specified section of the table view.
    ///
    /// - Parameters:
    ///   - tableView: The table-view object asking for the title.
    ///   - section: An index number identifying a section of tableView .
    /// - Returns: A string to use as the title of the section header. If you return nil, the section will have no title.
    @objc
    optional func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
}
