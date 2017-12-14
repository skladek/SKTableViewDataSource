Pod::Spec.new do |spec|
  spec.name = 'SKTableViewDataSource'
  spec.version = '2.1.0'
  spec.license = 'MIT'
  spec.summary = 'An easy to configure data source for UITableView.'
  spec.homepage = 'https://github.com/skladek/SKTableViewDataSource'
  spec.authors = { 'Sean Kladek' => 'skladek@gmail.com' }
  spec.source = { :git => 'https://github.com/skladek/SKTableViewDataSource.git', :tag => spec.version }
  spec.ios.deployment_target = '9.0'
  spec.source_files = 'Source/*.swift'
end
