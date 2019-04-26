--
local NXFS = require "nixio.fs"
local SYS  = require "luci.sys"
local HTTP = require "luci.http"
local DISP = require "luci.dispatcher"
local UTIL = require "luci.util"


m = Map("clash", translate("DNS Acceleration & Forwarder"))
s = m:section(TypedSection, "clash")
s.anonymous = true

bbr = s:option(Flag, "bbr", translate("Enable BBR"))
bbr.default = 1
bbr.rmempty = false
bbr.description = translate("Bottleneck Bandwidth and Round-trip propagation time (BBR)")


dns = s:option(Flag, "dns", translate("Enable DNS"))
dns.default = 1
dns.rmempty = false
dns.description = translate("Enable DNS Cache Acceleration and anti ISP DNS pollution")

o = s:option(Value, "dnsserver", translate("DNS Server 1"))
o.default = "114.114.114.114,114.114.115.115"
o.description = translate("Multiple DNS server can saperate with ','")
o:depends("dns", 1)

o = s:option(Value, "dnsserver_d", translate("DNS Server 2"))
o.default = "208.67.222.222,208.67.220.220"
o.description = translate("Multiple DNS server can saperate with ','")
o:depends("dns", 1)

o = s:option(Value, "pdnsd")
o.title = translate("* Dns Resolver Port 1")
o.default = 5353
o.datatype = "port"
o.rmempty = false
o.description = translate("Make sure port 5353 is free or resolver cannot start")

o = s:option(Value, "dnscache")
o.title = translate("* Dns Resolver Port 2")
o.default = 5333
o.datatype = "port"
o.rmempty = false
o.description = translate("Make sure port 5333 is free or resolver cannot start")


o = s:option(Value, "dns_server")
o.title = translate("* Dns Fowarder 1")
o.default = "127.0.0.1#5353"
o.rmempty = false
o.description = translate("DNS Server port must be the same as Dns Resolver Port 1 clash nameserver: - 127.0.0.1:5353")

o = s:option(Value, "dns_server_d")
o.title = translate("* Dns Fowarder 2")
o.default = "127.0.0.1#5353"
o.rmempty = false
o.description = translate("DNS Server port must be the same as Dns Resolver Port 2 clash nameserver: - 127.0.0.1:5353")

return m
