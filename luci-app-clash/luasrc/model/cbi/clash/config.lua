
--
local NXFS = require "nixio.fs"
local SYS  = require "luci.sys"
local HTTP = require "luci.http"
local DISP = require "luci.dispatcher"
local UTIL = require "luci.util"


m = Map("clash", translate("Server Configuration"))
s = m:section(TypedSection, "clash")
s.anonymous = true
s.addremove=false


local conf = "/etc/clash/config.yml"
sev = s:option(TextValue, "conf")
sev.readonly=true
sev.description = translate("Changes to config file must be made from source")
sev.rows = 29
sev.wrap = "off"
sev.cfgvalue = function(self, section)
	return NXFS.readfile(conf) or ""
end
sev.write = function(self, section, value)
end

return m