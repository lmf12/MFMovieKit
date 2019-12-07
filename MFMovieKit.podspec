#
# Be sure to run `pod lib lint MFMovieKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MFMovieKit'
  s.version          = '0.1.1'
  s.summary          = 'A video editing framework based on AVFoundation.'
  s.description      = 'A lightweight video editing framework that is easier to extend and use.'

  s.homepage         = 'https://github.com/lmf12/MFMovieKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lyman Li' => 'limianfeng12@gmail.com' }
  s.source           = { :git => 'https://github.com/lmf12/MFMovieKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MFMovieKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MFMovieKit' => ['MFMovieKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
