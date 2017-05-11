//
//  MockTableViewDataSourceDelegate.swift
//  TableViewDataSource
//
//  Created by Sean on 5/11/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import Foundation
import UIKit

@testable import TableViewDataSource

class MockTableViewDataSourceDelegate {
    var commitEditingStyleCalled = false
    var moveRowAtCalled = false
    var shouldReturnCell = false
    var shouldReturnFooter = false
    var shouldReturnHeader = false

    let tableViewCell = UITableViewCell(style: .default, reuseIdentifier: "testCellFromMock")
}

extension MockTableViewDataSourceDelegate: TableViewDataSourceDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
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

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return shouldReturnFooter == true ? "testFooterFromMock" : nil
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return shouldReturnHeader == true ? "testHeaderFromMock" : nil
    }
}
