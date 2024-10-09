FINALPACKAGE=1

# INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64
# THEOS_PACKAGE_SCHEME=roothide
TARGET = iphone:clang:latest:15.0
include $(THEOS)/makefiles/common.mk

TARGET_CC = xcrun -sdk iphoneos clang
TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

TWEAK_NAME = autoflex
FLEX_FILES := $(shell find src -type f -name "*.m" -o -name "*.mm" -o -name "*.c")

autoflex_FILES = Tweak.x $(FLEX_FILES)
autoflex_CFLAGS = -Isrc -fobjc-arc -Wno-deprecated-declarations -Wno-strict-prototypes -Wno-unsupported-availability-guard -Wno-unused-but-set-variable

autoflex_FRAMEWORKS = UIKit CoreGraphics QuartzCore ImageIO WebKit Security SceneKit AVFoundation UserNotifications
autoflex_LDFLAGS += -lz -lsqlite3

include $(THEOS_MAKE_PATH)/tweak.mk
