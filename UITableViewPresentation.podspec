
Pod::Spec.new do |s|
  s.name             = 'UITableViewPresentation'
  s.version          = '4.0.0'
  s.summary          = 'UITableViewPresentation.'
  s.description      = <<-DESC
A presentation library for coordinating changes between your models and your tableview
                       DESC
  s.homepage         = 'https://github.com/ChristopherCarranza/UITableViewPresentation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chris Carranza' => 'chris.carranza@icloud.com' }
  s.source           = { :git => 'https://github.com/ChristopherCarranza/UITableViewPresentation.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'UITableViewPresentation/Classes/**/*'
  s.dependency 'Dwifft', '0.9.0'
  s.dependency 'TaskQueue'
end
