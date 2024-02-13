#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_infonline_library.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_infonline_library'
  s.version          = '0.9.0'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Frank Hinkel' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.xcconfig         = {
    'FRAMEWORK_SEARCH_PATHS' => '"$(PROJECT_DIR)/INFOnlineLibrary/$(PLATFORM_NAME)/"',
    'OTHER_LDFLAGS' => '-framework INFOnlineLibrary'
  }
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  #s.script_phase = { :name => 'Script Run INFOnline', :script => '"INFOnlineLibrary/copy-framework.sh"', :execution_position => :before_compile, :shell_path => '/bin/sh' }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'FRAMEWORK_SEARCH_PATHS' => '"$(PROJECT_DIR)/../INFOnlineLibrary/$(PLATFORM_NAME)/"',
}
  s.swift_version = '5.0'
end
