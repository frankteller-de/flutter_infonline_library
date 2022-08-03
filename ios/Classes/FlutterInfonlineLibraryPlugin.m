#import "FlutterInfonlineLibraryPlugin.h"
#if __has_include(<flutter_infonline_library/flutter_infonline_library-Swift.h>)
#import <flutter_infonline_library/flutter_infonline_library-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_infonline_library-Swift.h"
#endif

@implementation FlutterInfonlineLibraryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterInfonlineLibraryPlugin registerWithRegistrar:registrar];
}
@end
