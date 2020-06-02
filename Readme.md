## CCSentryLoader Tweak 

CCSentryLoader is forked from [CCRevealLoader](https://github.com/webfrogs/CCRevealLoader) which is inspired by [RevealLoader](https://github.com/heardrwt/RevealLoader)

CCSentryLoader dynamically loads Sentry.framework (Sentry.io error handler) into iOS apps on jailbroken devices. Configuration is via the CCSentryLoader menu in Settings.app

Sentry is a nice error handling software that lets you categorize, manage and gather information on errors in development and production environments.

Generally you have to include their framework in your application at build time in-order to handle errors, however with this tweak installed this is no longer necessary. 

For more info see [sentry.io](https://sentry.io)


## Build Requirements

- Theos

## Install tweak

Execute command:

```
make package
```

**Note:** To make sure this tweak work correctly. Before install this tweak, change the command `codesign` in the `before-package` section of `Makefile`,use your develop certificate. If you dont have a certificate, you can remove the three command lines which begin with `lipo` and `codesign`.

## How to Use
Open 'Settings > CCSentryLoader > Enabled Applications' and toggle the application or applications that you want to catch errors for and configure your project key and ID.

Launch the target application and errors should appear in Sentry once they've occured. 

(You will likely need to quit and relaunch the target application)

## Be Social
Follow me on [Twitter](https://twitter.com/intent/follow?screen_name=nswebfrog) (@maxwlang) (This fork)
Follow the creator of CCRevealLoader on [Twitter](https://twitter.com/intent/follow?screen_name=nswebfrog) (@nswebfrog) (CCRevealLoader)
