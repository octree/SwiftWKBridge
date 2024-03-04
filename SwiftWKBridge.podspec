Pod::Spec.new do |s|
  s.name             = 'SwiftWKBridge'
  s.version          = '1.5.2'
  s.summary          = 'An elegant way to send message between Swift and WKWebView'
  s.description      = <<-DESC
  An elegant way to send message between Swift and WKWebView.
  Usually, you don't need to write any javascript code.
  And the web developer don't need write any extra javascript code either.
                       DESC

  s.homepage         = 'https://github.com/Octree/SwiftWKBridge'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Octree' => 'fouljz@gmail.com' }
  s.source           = { :git => 'https://github.com/Octree/SwiftWKBridge.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '11'
  s.swift_version = '5.8'

  s.source_files = 'Sources/SwiftWKBridge/**/*.swift'
  s.resources = 'Sources/SwiftWKBridge/Assets/**/*.js'
  s.frameworks = 'WebKit'
end
