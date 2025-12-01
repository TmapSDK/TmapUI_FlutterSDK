#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tmap_ui_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tmap_ui_sdk'
  s.version          = '1.0.37'
  s.summary          = 'TmapUISDK for flutter'
  s.homepage              = "https://www.tmapmobility.com/"
  s.license       = {
    :type => 'Copyright',
    :text => 'Copyright (c) TMAP mobility corp. All rights reserved.'
  }
  s.author                = 'TMAP mobility corp.'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'TmapUISDK', '1.0.37'

  s.ios.deployment_target = '13.0' # to use Combine

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.9'
end
