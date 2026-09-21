Pod::Spec.new do |s|
  s.name = 'flutter_infonline_library'
  s.version = '0.14.0'
  s.summary = 'Flutter integration for the INFOnline pseudonymous measurement SDK.'
  s.homepage = 'https://github.com/codeforce-dev/flutter_infonline_library'
  s.license = { :file => '../LICENSE' }
  s.author = { 'codeforce-dev' => 'https://github.com/codeforce-dev' }
  s.source = { :path => '.' }
  s.source_files = 'flutter_infonline_library/Sources/flutter_infonline_library/**/*.swift'
  s.dependency 'Flutter'
  s.vendored_frameworks = 'flutter_infonline_library/Frameworks/INFOnlineLibrary.xcframework'
  s.platform = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
