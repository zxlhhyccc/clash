--
local NXFS = require "nixio.fs"
local SYS  = require "luci.sys"
local HTTP = require "luci.http"
local DISP = require "luci.dispatcher"
local UTIL = require "luci.util"


local button = ""

if luci.sys.call("pidof clash >/dev/null") == 0 then
button = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" class=\"btn \" style=\"background-color:black;color:white\" value=\" " .. translate(" OPEN CONTROL INTERFACE ") .. " \" onclick=\"window.open('http://'+window.location.hostname+'/clash')\"/>"
m = Map("clash", translate("Clash"),"%s  %s" %{translate(""), translate("<b><font size=\"2\" color=\"green\">CLASH IS RUNNING</font></b>")} .. button)

else
m = Map("clash", translate("Clash"), "%s  %s" %{translate(""), translate("<b><font color=\"red\">CLASH NOT RUNNING</font></b>")})


end


s = m:section(TypedSection, "clash")
s.anonymous = true


s:tab("basic",  translate("General Settings"))



o = s:taboption("basic", Flag, "enable")
o.title = translate("Enable")
o.default = 0
o.rmempty = false
o.description = translate("After clash start running, wait a moment for servers to resolve,enjoy")


bbr = s:taboption("basic", Flag, "bbr", translate("Enable BBR"))
bbr.default = 1
bbr.rmempty = false
bbr.description = translate("Bottleneck Bandwidth and Round-trip propagation time (BBR)")

dns = s:taboption("basic", Flag, "dns", translate("DNS Acceleration"))
dns.default = 1
dns.rmempty = false
dns.description = translate("Enable DNS Cache Acceleration and anti ISP DNS pollution")

o = s:taboption("basic", Value, "dnsserver", translate("Upstream DNS Server 1"))
o.default = "114.114.114.114,114.114.115.115"
o.description = translate("Muitiple DNS server can saperate with ','")
o:depends("dns", 1)

o = s:taboption("basic", Value, "dnsserver_d", translate("Upstream DNS Server 2"))
o.default = "208.67.222.222, 208.67.220.220"
o.description = translate("Muitiple DNS server can saperate with ','")
o:depends("dns", 1)

o = s:taboption("basic", Value, "proxy_port")
o.title = translate("* Clash Redir Port")
o.default = 8236
o.datatype = "port"
o.rmempty = false
o.description = translate("Port must be the same as in your clash config file , redir-port: 8236")

o = s:taboption("basic", Value, "pdnsd")
o.title = translate("*Dns Resolver Port 1")
o.default = 5353
o.datatype = "port"
o.rmempty = false
o.description = translate("Make sure port 5353 is free or resolver cannot start")

o = s:taboption("basic", Value, "dnscache")
o.title = translate("*Dns Resolver Port 2")
o.default = 5333
o.datatype = "port"
o.rmempty = false
o.description = translate("Make sure port 5333 is free or resolver cannot start")


o = s:taboption("basic", Value, "dns_server")
o.title = translate("* Local Dns Fowarder 1")
o.default = "127.0.0.1#5353"
o.rmempty = false
o.description = translate("DNS Server port must be the same as Dns Resolver Port 1 clash nameserver: - 127.0.0.1:5353")

o = s:taboption("basic", Value, "dns_server_d")
o.title = translate("* Local Dns Fowarder 2")
o.default = "127.0.0.1#5353"
o.rmempty = false
o.description = translate("DNS Server port must be the same as Dns Resolver Port 2 clash nameserver: - 127.0.0.1:5353")


o = s:taboption("basic", Value, "subscribe_url")
o.title = translate("Subcription Url")
o.description = translate("You can manually place config file in  /etc/clash/config.yml")
o.rmempty = true

o = s:taboption("basic", Button,"update")
o.title = translate("Update Subcription")
o.inputtitle = translate("Update Configuration")
o.inputstyle = "reload"
o.write = function()
  os.execute("mv /etc/clash/config.yml /etc/clash/config.bak")
  SYS.call("bash /usr/share/clash/clash.sh >>/tmp/clash.log 2>&1")
  HTTP.redirect(DISP.build_url("admin", "services", "clash"))
end


s:tab("address",  translate("Server Configuration"))
local conf = "/etc/clash/config.yml"
o = s:taboption("address", TextValue, "conf")
o.readonly=true
o.description = translate("Changes to config file must be made from source")
o.rows = 29
o.wrap = "off"
o.cfgvalue = function(self, section)
	return NXFS.readfile(conf) or ""
end
o.write = function(self, section, value)
end


s:tab("log",  translate("Server logs"))

local clog = "/tmp/clash.log"
o = s:taboption("log", TextValue, "clog")
o.readonly=true
o.description = translate("")
o.rows = 29
o.wrap = "off"
o.cfgvalue = function(self, section)
	return NXFS.readfile(clog) or ""
end
o.write = function(self, section, value)
	NXFS.writefile(clog, value:gsub("\r\n", "\n"))
end
local apply = luci.http.formvalue("cbi.apply")
if apply then
	os.execute("chmod +x /etc/init.d/clash >/dev/null 2>&1 &")
       os.execute("/etc/init.d/clash restart >/dev/null 2>&1 &")
end


return m

