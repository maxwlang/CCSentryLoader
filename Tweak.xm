#include <dlfcn.h>
#include <Sentry/Sentry.h>

%ctor {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/me.virulent.ios.tweaks.sentryloader.plist"] ;
    NSString *libraryPath = @"/Library/Application Support/CCSentryLoader/Sentry.framework/Sentry";

    NSString *enableKeyPath = [NSString stringWithFormat:@"CCSentryEnabled-%@", [[NSBundle mainBundle] bundleIdentifier]];
    // NSString *dsnKeyPath = [NSString stringWithFormat:@"CCSentryDSN-%@", [[NSBundle mainBundle] bundleIdentifier]];
    NSLog(@"CCSentryLoader before loaded %@,enableKeyPath = %@,prefs = %@", libraryPath,enableKeyPath,prefs);
    if ([[prefs objectForKey:enableKeyPath] boolValue]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
            void *haldel = dlopen([libraryPath UTF8String], RTLD_NOW);
        if (haldel == NULL) {
            char *error = dlerror();
            NSLog(@"dlopen error: %s", error);
        } else {
            NSLog(@"dlopen load framework success.");

            @try {
                [SentrySDK startWithOptions:@{
                    @"dsn": @"https://148c651abde94058aa23f091a90d2d02@o233196.ingest.sentry.io/5260933", // [[prefs objectForKey:dsnKeyPath] stringValue],
                    @"debug": @(YES)
                }];
                NSLog(@"SentrySDK initialized.");
            }
            @finally {
                NSLog(@"SentrySDK initialization failure");
            }

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