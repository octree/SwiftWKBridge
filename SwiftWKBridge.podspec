#
# Be sure to run `pod lib lint SwiftWKBridge.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftWKBridge'
  s.version          = '1.0.0'
  s.summary          = 'An elegant way to send message between Swift and WKWebView'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  An elegant way to send message between Swift and WKWebView.
  Usually, you don't need to write any javascript code.
  And the web developer don't need write any extra javascript code either.
                       DESC

  s.homepage         = 'https://github.com/Octree/SwiftWKBridge'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Octree' => 'fouljz@gmail.com' }
  s.source           = { :git => 'https://github.com/Octree/SwiftWKBridge.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_versions = ['5.0']

  s.source_files = 'Sources/SwiftWKBridge/**/*.swift'
  s.resources = 'Sources/SwiftWKBridge/Assets/**/*.js'
  # s.resource_bundles = {
  #   'SwiftWKBridge' => ['SwiftWKBridge/Assets/*.png']
  # }
  s.frameworks = 'WebKit'
end
