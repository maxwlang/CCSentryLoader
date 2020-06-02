#include <dlfcn.h>

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/me.virulent.ios.tweaks.sentryloader.plist"] ;
    NSString *libraryPath = @"/Library/Application Support/CCSentryLoader/Sentry.framework/Sentry";

    NSString *keyPath = [NSString stringWithFormat:@"CCSentryEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]];
    NSLog(@"CCSentryLoader before loaded %@,keyPath = %@,prefs = %@", libraryPath,keyPath,prefs);
    if ([[prefs objectForKey:keyPath] boolValue]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
            void *haldel = dlopen([libraryPath UTF8String], RTLD_NOW);
        if (haldel == NULL) {
            char *error = dlerror();
            NSLog(@"dlopen error: %s", error);
        } else {
            NSLog(@"dlopen load framework success.");
			[[NSNotificationCenter defaultCenter] postNotificationName:@"CCSentryLoaderRequestStart" object:nil];
        }

        NSLog(@"CCSentryLoader loaded %@", libraryPath);
        } else {
            NSLog(@"CCSentryLoader file not exists %@", libraryPath);
        }
    }
    else {
        NSLog(@"CCSentryLoader not enabled %@", libraryPath);
    }

    NSLog(@"CCSentryLoader after loaded %@", libraryPath);


    [pool drain];
}