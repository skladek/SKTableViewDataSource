platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

target 'SKTableViewDataSource' do
	project 'SKTableViewDataSource.xcodeproj'
	pod 'SwiftLint', '= 0.23.1'
end

target 'SKTableViewDataSourceTests' do
	workspace 'SKTableViewDataSource.xcworkspace'
	project 'SKTableViewDataSource.xcodeproj'
	pod 'Nimble', '= 7.0.2'
	pod 'Quick', '= 1.2.0'
end