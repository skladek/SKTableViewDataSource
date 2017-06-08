platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

target 'TableViewDataSource' do
	project 'TableViewDataSource.xcodeproj'
	pod 'SwiftLint', '= 0.19.0'
end

target 'TableViewDataSourceTests' do
	workspace 'TableViewDataSource.xcworkspace'
	project 'TableViewDataSource.xcodeproj'
	pod 'Nimble', '= 7.0.0'
	pod 'Quick', '= 1.1.0'
end