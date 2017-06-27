import Foundation
import UIKit

@testable import SKTableViewDataSource

class MockTableViewDataSourceDelegate {
    var canEditRowAtCalled = false
    var canMoveRowAtCalled = false
    var commitEditingStyleCalled = false
    var moveRowAtCalled = false
    var shouldReturnCell = false
    var shouldReturnFooter = false
    var shouldReturnHeader = false

    let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "testCellFromMock")
}

extension MockTableViewDataSourceDelegate: TableViewDataSourceDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["testSectionIndexTitle"]
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        canEditRowAtCalled = true
        return true
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        canMoveRowAtCalled = true
        return false
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        return shouldReturnCell == true ? tableViewCell : nil
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        commitEditingStyleCalled = true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        moveRowAtCalled = true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return shouldReturnFooter == true ? "testFooterFromMock" : nil
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return shouldReturnHeader == true ? "testHeaderFromMock" : nil
    }
}
