//
//  MockTableView.swift
//  SKTableViewDataSource
//
//  Created by Sean on 6/14/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation
import UIKit

class MockTableView: UITableView {
    var registerClassCaled = false
    var registerNibCalled = false

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        registerClassCaled = true
    }

    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        registerNibCalled = true
    }
}
