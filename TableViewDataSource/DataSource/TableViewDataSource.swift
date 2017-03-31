//
//  TableViewDataSource.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import UIKit

class TableViewDataSource<T>: NSObject, UITableViewDataSource {
    let reuseId = "SingleSectionCellReuseId"

    let singleSectionArray: [T]

    init(objects: [T]) {
        self.singleSectionArray = objects
    }

    func object(_ indexPath: IndexPath) -> T {
        return singleSectionArray[indexPath.row]
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleSectionArray.count
    }
}
