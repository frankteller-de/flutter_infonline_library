#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_infonline_library.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_infonline_library'
  s.version          = '0.11.16'
  s.summary          = 'Unoffical INFOnline Flutter Library'
  s.description      = <<-DESC
Unoffical INFOnline Flutter Library Android/iOS (Pseudonyme Messung SZM/ÖWA)
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Frank Teller' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'

  s.vendored_frameworks = 'Frameworks/INFOnlineLibrary.xcframework'

  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO',
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }

  s.swift_version = '5.0'
end



