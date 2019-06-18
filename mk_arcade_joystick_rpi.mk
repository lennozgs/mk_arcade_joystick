################################################################################
#
# MK_ARCADE_JOYSTICK_RPI
#
################################################################################
MK_ARCADE_JOYSTICK_RPI_VERSION = v0.1.7
#MK_ARCADE_JOYSTICK_RPI_SITE = $(@D)/../../../package/mk_arcade_joystick_rpi
MK_ARCADE_JOYSTICK_RPI_SITE = $(CONFIG_DIR)/../package/mk_arcade_joystick_rpi
MK_ARCADE_JOYSTICK_RPI_SITE_METHOD = local
MK_ARCADE_JOYSTICK_RPI_DEPENDENCIES = linux

MK_BUILD_DIR = $(BUILD_DIR)/mk_arcade_joystick_rpi-$(MK_ARCADE_JOYSTICK_RPI_VERSION)

# Needed beacause can't pass cflags to cc
define MK_ARCADE_JOYSTICK_RPI_RPI2_HOOK
	$(SED) "s/#define PERI_BASE        0x20000000/#define PERI_BASE        0x3F000000/g" $(@D)/mk_arcade_joystick_rpi.c
endef

ifeq ($(BR2_cortex_a7),y)
MK_ARCADE_JOYSTICK_RPI_PRE_CONFIGURE_HOOKS += MK_ARCADE_JOYSTICK_RPI_RPI2_HOOK
endif
ifeq ($(BR2_cortex_a53),y)
MK_ARCADE_JOYSTICK_RPI_PRE_CONFIGURE_HOOKS += MK_ARCADE_JOYSTICK_RPI_RPI2_HOOK
endif

define MK_ARCADE_JOYSTICK_RPI_MAKE_HOOK
	cp $(@D)/Makefile.cross $(@D)/Makefile
endef
MK_ARCADE_JOYSTICK_RPI_PRE_BUILD_HOOKS += MK_ARCADE_JOYSTICK_RPI_MAKE_HOOK

ifeq ($(BR2_PACKAGE_UBOOT_XU4),y)
define MK_ARCADE_JOYSTICK_RPI_BUILD_CMDS
	$(SED) "s/#define XU4              0/#define XU4              1/g" $(MK_BUILD_DIR)/mk_arcade_joystick_rpi.c
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
endef
else
define MK_ARCADE_JOYSTICK_RPI_BUILD_CMDS
    $(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR)
endef
endif

define MK_ARCADE_JOYSTICK_RPI_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) $(LINUX_MAKE_FLAGS) KERNELDIR=$(LINUX_DIR) modules_install
endef

$(eval $(generic-package))
