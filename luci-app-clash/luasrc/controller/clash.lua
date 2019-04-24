module("luci.controller.clash", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/clash") then
		return
	end

	local page

	page = entry({"admin", "services", "clash"}, cbi("clash"), _("Clash"), 60)
	page.dependent = true
	entry({"admin","services","clash","status"},call("action_status")).leaf=true

	
end


local function is_running()
	return luci.sys.call("pidof clash >/dev/null") == 0
end

local function is_web()
	return luci.sys.call("pidof clash >/dev/null") == 0
end

local function is_bbr()
	return luci.sys.call("[ `cat /proc/sys/net/ipv4/tcp_congestion_control 2>/dev/null` = bbr ] 2>/dev/null") == 0
end

local function is_pdn()
	return luci.sys.call("pgrep pdnsd >/dev/null") == 0
end

local function is_dns()
	return luci.sys.call("pgrep dnscache >/dev/null") == 0
end

function action_status()
	luci.http.prepare_content("application/json")
	luci.http.write_json({
		web = is_web(),
		clash = is_running(),
		bbr = is_bbr(),
		dnscache = is_dns(),
		pdnsd = is_pdn()
	})
end
