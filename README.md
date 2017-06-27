# SKTableViewDataSource

![Travis Status](https://travis-ci.org/skladek/SKTableViewDataSource.svg?branch=master)
![Codecov Status](https://img.shields.io/codecov/c/github/skladek/SKTableViewDataSource.svg)
![Pod Version](https://img.shields.io/cocoapods/v/SKTableViewDataSource.svg)
![Platform Status](https://img.shields.io/cocoapods/p/SKTableViewDataSource.svg)
![License Status](https://img.shields.io/github/license/skladek/SKTableViewDataSource.svg)

SKTableViewDataSource provides an object to handle much of the standard UITableViewDataSource logic. It handles calculating row and section counts, retrieving cells, and provides methods for updating the underlying array powering the data source. Check out the SampleProject in the workspace to see some usage examples.

- [Installation](#installation)
- [Initialization](#initialization)
- [CellPresenter](#cellpresenter)
- [TableViewDataSourceDelegate](#tableviewdatasourcedelegate)
- [Updating The Data Array](#updating-the-data-array)

---

## Installation

### Cocoapods

Instalation is supported through Cocoapods. Add the following to your pod file for the target where you would like to use SKTableViewDataSource:

```
pod 'SKTableViewDataSource'
```

---

## Initialization

### Auto Cell Registration

The easiest way to initialize a TableViewDataSource object is to provide an array, cell class or nib, and a CellPresenter closure to handle styling the cell during `cellForRowAtIndexPath`. Cell registration will be handled by the `TableViewDataSource` object. The objects array can be a 1 or 2 dimensional array. A single dimension array will display as a single section table view. A 2 dimensional array will display with multiple sections.


```
import SKTableViewDataSource
```

```
let dataSource = TableViewDataSource(objects: array, cell: UITableViewCell.self, cellPresenter: { (cell, object) in
    cell.textLabel?.text = object
})

tableview.dataSource = dataSource
```

### Manual Cell Registration

If you require access to the cell's reuse identifier or require multiple cell types in your table view, you can choose to register the cells yourself.


```
import SKTableViewDataSource
```
```
tableView.register(YourCellClass.self, forCellReuseIdentifier: "YourReuseIdentifier")

let dataSource = TableViewDataSource(objects: array, delegate: self) {
    cell.textLabel?.text = object.rawValue
})

tableView.dataSource = dataSource
```
Note: If you choose to handle cell registration on your own, you must implement TableViewDataSourceDelegate's `cellForRowAtIndexPath` method and return a cell for each index path.

---

## CellPresenter

Each initialization method for auto cell registration has an optional `CellPresenter` closure. The closure returns two parameters: a cell and an object. This closure can be used to populate the cell with values from the object.

---

## TableViewDataSourceDelegate

`TableViewDataSource` has an optional delegate. This serves as a pass through for `UITableViewDataSource` methods. The delegate object can override any of the `TableViewDataSource` implementations by implementing the corresponding delegate method.

---

## Updating The Data Array

There are a handful of methods for manipulating the data in the array. Updating the data source will not trigger any sort of update in the table view. That must be handled by the developer.

### delete(indexPath:)
This will delete the object at the provided index path.

### insert(indexPath:)
This will insert the provided object at the provided index path.

### moveFrom(_:to:)
This will move the object at the from index path to the to index path.

### object(indexPath:)
This returns the object at the provided index path.

### setObjects(_:)
This replaces the existing objects array with the provided objects array.