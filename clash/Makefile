#
# Copyright (C) 2015-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v3.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=clash
PKG_VERSION:=0.13.0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=clash is a cross-platform proxy software
	DEPENDS:=
	URL:=https://github.com/Dreamacro/clash/releases
endef


define Package/$(PKG_NAME)/description
clash is a cross-platform proxy software
endef



define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/clash
	
ifeq ($(ARCH),mipsel)
	$(INSTALL_BIN) ./files/mipsle/clash $(1)/etc/clash/
endif
ifeq ($(ARCH),mips)
	$(INSTALL_BIN) ./files/mips64/clash $(1)/etc/clash/
endif
ifeq ($(ARCH),i386)
	$(INSTALL_BIN) ./files/386/clash $(1)/etc/clash/
endif
ifeq ($(ARCH),x86_64)
	$(INSTALL_BIN) ./files/amd64/clash $(1)/etc/clash/
endif
ifeq ($(ARCH),arm)
	$(INSTALL_BIN) ./files/armv6/clash $(1)/etc/clash/
endif
ifeq ($(ARCH),aarch64)
	$(INSTALL_BIN) ./files/armv8/clash $(1)/etc/clash/
endif

	$(INSTALL_DIR) $(1)/usr/share/clash
	$(INSTALL_DATA) ./files/version/* $(1)/usr/share/clash/
	
		
	
endef


$(eval $(call BuildPackage,$(PKG_NAME)))
