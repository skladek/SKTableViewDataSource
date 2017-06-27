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
