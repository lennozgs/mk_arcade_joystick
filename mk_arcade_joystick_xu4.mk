################################################################################
#
# MK_ARCADE_JOYSTICK_XU4
#
################################################################################
MK_ARCADE_JOYSTICK_XU4_VERSION = v0.1.7
MK_ARCADE_JOYSTICK_XU4_SITE = $(CONFIG_DIR)/../package/mk_arcade_joystick_xu4
MK_ARCADE_JOYSTICK_XU4_SITE_METHOD = local
MK_ARCADE_JOYSTICK_XU4_DEPENDENCIES = linux

MK_BUILD_DIR = $(BUILD_DIR)/mk_arcade_joystick_xu4-$(MK_ARCADE_JOYSTICK_XU4_VERSION)

define MK_ARCADE_JOYSTICK_XU4_MAKE_HOOK
	cp $(@D)/Makefile.cross $(@D)/Makefile
endef
MK_ARCADE_JOYSTICK_XU4_PRE_BUILD_HOOKS += MK_ARCADE_JOYSTICK_XU4_MAKE_HOOK

define MK_ARCADE_JOYSTICK_XU4_BUILD_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
endef

define MK_ARCADE_JOYSTICK_XU4_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR) modules_install
endef

$(eval $(generic-package))
