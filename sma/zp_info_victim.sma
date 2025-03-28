#include <amxmodx>
#include <zombieplague>
#include <Commas>

new g_status_sync;

public plugin_init() {
	register_plugin("Victim Info [Human/Zombie]", "1.0", "*PIRATE*xXx");
	register_event("StatusValue", "showStatus", "be", "1=2", "2!0");
	register_event("StatusValue", "hideStatus", "be", "1=1", "2=0");
	g_status_sync = CreateHudSyncObj();
}
	
public showStatus(id) {
	if (is_user_bot(id) || !is_user_connected(id))
		return;
	
	new name[32], pid = read_data(2);
	get_user_name(pid, name, 31);
	
	if (zp_get_user_zombie(pid) == 1) {
		static HealthString[16];
		AddCommas(get_user_health(pid), HealthString, 15);
		set_hudmessage(255, 15, 15, -1.0, 0.60, 1, 0.01, 3.0, 0.01, 0.01, -1);
		ShowSyncHudMsg(id, g_status_sync, "%s^n[ Health: %s ]", name, HealthString);
	}
}

public hideStatus(id) {
	ClearSyncHud(id, g_status_sync);
}