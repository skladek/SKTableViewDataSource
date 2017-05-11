# TableViewDataSource

![Travis Status](https://travis-ci.org/skladek/TableViewDataSource.svg?branch=master)

Provides a reusable object to handle the boiler plate logic for the UITableViewDataSource.

## Setup

1. Clone the repository

        $ git clone https://github.com/skladek/TableViewDataSource.git
        
2. Run `carthage update` in the project root folder.
3. Open TableViewDataSource.xcodeproj
4. Run the TableViewDataSource target

## Project Integration

1. Copy the TableViewDataSource to your project.
2. Initialize a TableViewDataSource object with an array and cell reuse id
3. Set your tableview.dataSource to the TableViewDataSource object
