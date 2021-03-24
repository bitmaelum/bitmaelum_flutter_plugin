#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint bitmaelum.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
    s.name             = 'bitmaelum'
    s.version          = '0.0.1'
    s.summary          = 'library for use BitMaelum.'
    s.description      = <<-DESC
  library for use BitMaelum.
                         DESC
    s.homepage         = 'https://github.com/bitmaelum/bitmaelum_flutter_plugin'
    s.license          = { :file => '../LICENSE' }
    s.author           = { 'BitMaelum Authors' }
    s.source           = { :path => '.' }
    s.source_files     = 'Classes/**/*'
    s.dependency 'FlutterMacOS'
    s.platform = :osx, '10.11'
    s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
    s.swift_version = '5.0'
    #s.vendored_libraries  = 'libbitmaelum_bridge.dylib'
    s.resources = ['libbitmaelum_bridge.dylib']
    s.xcconfig = { 'LD_RUNPATH_SEARCH_PATHS' => '@loader_path/../Frameworks/bitmaelum.framework/Resources' }
  
  end
  