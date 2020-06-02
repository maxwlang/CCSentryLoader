ARCHS = arm64 arm64e
TARGET = iphone:latest:8.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CCSentryLoader
CCSentryLoader_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
	@echo "Downlading Sentry framework..."
	wget https://github.com/getsentry/sentry-cocoa/releases/latest/download/Sentry.framework.zip
	unzip Sentry.framework.zip
	rm Sentry.framework.zip
	mkdir -p ./layout/Library/Application\ Support/CCSentryLoader/
	cp -r  ./Carthage/Build/iOS/Sentry.framework/ ./layout/Library/Application\ Support/CCSentryLoader/
	# lipo -remove i386 ./layout/Library/Application\ Support/CCSentryLoader/Sentry.framework/Sentry -o ./layout/Library/Application\ Support/CCSentryLoader/Sentry.framework/Sentry
	# lipo -remove x86_64 ./layout/Library/Application\ Support/CCSentryLoader/Sentry.framework/Sentry -o ./layout/Library/Application\ Support/CCSentryLoader/Sentry.framework/Sentry
	rm -r Carthage
	#codesign -f -s "iPhone Developer: ChengFang  Chen (4YVJ336CK2)" ./layout/Library/Application\ Support/CCSentryLoader/Sentry.framework

after-install::
	install.exec "killall -9 SpringBoard"
