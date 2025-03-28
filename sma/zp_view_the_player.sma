#include <amxmodx>
#include <amxmisc>
#include <engine>

#define MAX_PLAYERS 32;

new g_Camera;
new iCamera[33];

public plugin_init() {
	register_plugin("View the Player - 3D", "1.0", "Zed");
	register_clcmd("say /cam", "camera");
	register_clcmd("say /camera", "camera");
	
	g_Camera = register_cvar("camera_3d", "1");
}

public client_putinserver(id) {
	iCamera[id] = false;
}

public plugin_modules() {
	require_module("engine");
}

public plugin_precache() {
	precache_model("models/rpgrocket.mdl");
}

public camera(id) {
	if (get_pcvar_num (g_Camera))
	{
		if ((iCamera[id] = !iCamera[id])) {
			set_view(id, CAMERA_3RDPERSON);
		} else {
			set_view(id, CAMERA_NONE);
		}
	}
	return PLUGIN_HANDLED;
}