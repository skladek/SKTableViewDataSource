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

            it("Should set the reuse id") {
                expect(self.unitUnderTest.reuseId).to(equal(self.reuseId))
            }

            it("Should wrap the objects array in an array and set to objects") {
                expect(self.unitUnderTest.objects).toNot(beNil())
            }
        }
    }
}
