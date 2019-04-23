#!/bin/sh

enable=$(uci get clash.config.enable 2>/dev/null)

if [ $enable -eq 1 ]; then
	if ! pidof clash>/dev/null; then
	   /etc/init.d/clash start
  fi
fi

if [ $enable -eq 0 ]; then
	if  pidof clash>/dev/null; then
	   /etc/init.d/clash stop
  fi
fi

