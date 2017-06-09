platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

target 'SKTableViewDataSource' do
	project 'SKTableViewDataSource.xcodeproj'
	pod 'SwiftLint', '= 0.19.0'
end

target 'SKTableViewDataSourceTests' do
	workspace 'SKTableViewDataSource.xcworkspace'
	project 'SKTableViewDataSource.xcodeproj'
	pod 'Nimble', '= 7.0.0'
	pod 'Quick', '= 1.1.0'
end