//
//  TableViewDataSourceSpec.swift
//  TableViewDataSource
//
//  Created by Sean Kladek on 3/30/17.
//  Copyright © 2017 skladek. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import TableViewDataSource

class TableViewDataSourceSpec: QuickSpec {

    let reuseId = "testReuseId"
    var unitUnderTest: TableViewDataSource<String>!

    override func spec() {
        context("init(objects:cellReuseId:)") {
            let objects = ["One", "Two", "Three"]

            beforeEach() {
                self.unitUnderTest = TableViewDataSource(objects: objects, cellReuseId: self.reuseId)
            }

            it("Should wrap the objects array in an array and set to objects") {
                expect(self.unitUnderTest.objects.first).to(equal(objects))
            }
        }

        context("init(objects:cellReuseId:)") {
            let objects: [[String]] = [["One", "Two", "Three"], ["Three", "Four", "Five"]]

            beforeEach() {
                self.unitUnderTest = TableViewDataSource(objects: objects, cellReuseId: self.reuseId)
            }

            it("Should set the objects array") {
                expect(self.unitUnderTest.objects.first).to(equal(objects.first))
                expect(self.unitUnderTest.objects.last).to(equal(objects.last))
            }
        }

        context("object(indexPath:)") {
            let objects = [["S0R0", "S0R1", "S0R2"], ["S1R0", "S1R1", "S1R2"]]

            beforeEach {
                self.unitUnderTest = TableViewDataSource(objects: objects, cellReuseId: self.reuseId)
            }

            it("Should return the object at the specified index path") {
                let indexPath = IndexPath(row: 1, section: 1)

                expect(self.unitUnderTest.object(indexPath)).to(equal("S1R1"))
            }
        }

        context("numberOfSections(tableView:)") {
            let objects = [["S0R0", "S0R1", "S0R2"], ["S1R0", "S1R1", "S1R2"]]

            beforeEach {
                self.unitUnderTest = TableViewDataSource(objects: objects, cellReuseId: self.reuseId)
            }

            it("Should return 2") {
                expect(self.unitUnderTest.numberOfSections(in: UITableView())).to(equal(2))
            }
        }

        context("tableView(tableView:section:)") {
            let objects = [["S0R0", "S0R1", "S0R2"], ["S1R0", "S1R1"]]

            beforeEach {
                self.unitUnderTest = TableViewDataSource(objects: objects, cellReuseId: self.reuseId)
            }

            it("Should return 2") {
                expect(self.unitUnderTest.tableView(UITableView(), numberOfRowsInSection: 1)).to(equal(2))
            }
        }
    }
}
