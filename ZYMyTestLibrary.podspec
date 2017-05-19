#
# Be sure to run `pod lib lint ZYMyTestLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZYMyTestLibrary'
  s.version          = '1.0.7'
  s.summary          = 'A delightful infinit carouseView for ios'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
播图，无限轮播图，基于scorllview及三个uiimageview，timer定时。
add xib and sbd
                       DESC

  s.homepage         = 'https://github.com/Lzy8/ZYMyTestLibarary'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lzy' => '752182124@qq.com' }
  s.source           = { :git => 'https://github.com/Lzy8/ZYMyTestLibarary.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZYMyTestLibrary/Classes/**/*'
  s.resource = 'ZYMyTestLibarary/ZYTest.bundle'
  s.resource_bundles = {
    'ZYMyTestLibrary' => ['ZYMyTestLibrary/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
