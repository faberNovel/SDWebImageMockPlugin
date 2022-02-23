#
# Be sure to run `pod lib lint SDWebImageMockPlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SDWebImageMockPlugin'
  s.version          = '0.0.1'
  s.summary          = 'A plugin to provide mock images to SDWebImage, this allowing snapshot testing'
  s.homepage         = 'https://github.com/faberNovel/SDWebImageMockPlugin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexandre Podlewski' => 'alexandre.podlewski@fabernovel.com' }
  s.source           = { :git => 'https://github.com/Alexandre Podlewski/SDWebImageMockPlugin.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/fabernovel'

  s.ios.deployment_target = '9.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Sources/SDWebImageMockPlugin/**/*'

  s.frameworks = 'UIKit'
  s.dependency 'SDWebImage', '~> 5.0'
end
