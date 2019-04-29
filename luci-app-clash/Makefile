# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=LuCI Support for clash
LUCI_DEPENDS:=+clash +kmod-ipt-offload +pdnsd-alt +kmod-tcp-bbr @!LINUX_3_18 @!LINUX_4_9
PKG_VERSION:=0.13.0

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
