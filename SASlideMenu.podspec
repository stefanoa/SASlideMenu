#
# Be sure to run `pod spec lint SASlideMenu.podspec' to ensure this is a
# valid spec.
#
# Remove all comments before submitting the spec. Optional attributes are commented.
#
# For details see: https://github.com/CocoaPods/CocoaPods/wiki/The-podspec-format
#
Pod::Spec.new do |s|
  s.name         = 'SASlideMenu'
  s.version      = '1.0.0'
  s.license      = 'MIT'
  s.summary      = 'A simple library to create sliding menus that can be used in storyboards and support static cells.'
  s.homepage     = 'https://github.com/stefanoa/SASlideMenu'
  s.author       = { 'Stefano Antonelli' => 'CHANGEME@EXAMPLE.COM' }

  s.source       = { :git => 'https://github.com/stefanoa/SASlideMenu.git', :tag => 'v1.0.0' }

  s.description  =  'A simple library to create sliding menus that can be used in storyboards and support static cells.
                    Sliding menus are used in a number of  popular applications like Facebook, Path 2.0, GMail, Glassboard and many others.'

  s.platform     = :ios, '5.1'
  s.source_files = 'SASlideMenu/SASlideMenu'

  s.requires_arc = true
end
