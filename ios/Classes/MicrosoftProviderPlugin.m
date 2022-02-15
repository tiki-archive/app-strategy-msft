#import "MicrosoftProviderPlugin.h"
#if __has_include(<microsoft_provider/microsoft_provider-Swift.h>)
#import <microsoft_provider/microsoft_provider-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "microsoft_provider-Swift.h"
#endif

@implementation MicrosoftProviderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMicrosoftProviderPlugin registerWithRegistrar:registrar];
}
@end
