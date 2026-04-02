export ARCHS = arm64 arm64e
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AhmedGram
AhmedGram_FILES = Tweak.x
AhmedGram_FRAMEWORKS = UIKit CoreGraphics
# هذا السطر يضمن إن صورتك IMG_1099 تنزل مع الأداة
AhmedGram_INSTALL_PATH = /Library/Application Support/AhmedGram/

include $(THEOS_MAKE_PATH)/tweak.mk
