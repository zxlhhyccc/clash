#!/bin/sh

enable=$(uci get clash.config.enable 2>/dev/null)

rm -f /tmp/luci-indexcache

if [ $enable -eq 1 ]; then
	if ! pidof clash>/dev/null; then
	   /etc/init.d/clash start >/dev/null 2>&1
  fi
fi

if [ $enable -eq 0 ]; then
	if  pidof clash>/dev/null; then
	   /etc/init.d/clash stop 
  fi
fi

