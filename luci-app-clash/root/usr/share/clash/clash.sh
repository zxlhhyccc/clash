#!/bin/bash
subscribe_url=$(uci get clash.config.subscribe_url 2>/dev/null)
rm -rf /etc/clash/config.bak 2> /dev/null
wget-ssl --user-agent="User-Agent: Mozilla" $subscribe_url -O 2>&1 >1 /etc/clash/config.yml
