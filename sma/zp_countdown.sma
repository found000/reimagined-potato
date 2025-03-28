#include <amxmodx>
#include <amxmisc>
#include <zombieplague>

#define PLUGIN "[ZP] Countdown"
#define VERSION "1.0"
#define AUTHOR "Mr.Apple & BlackRaven"

new countdown
new time_s, g_MsgSync

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	g_MsgSync = CreateHudSyncObj()
}

public plugin_precache()
{
    precache_sound( "fvox/ten.wav" )
    precache_sound( "fvox/nine.wav" )
    precache_sound( "fvox/eight.wav" )
    precache_sound( "fvox/seven.wav" )
    precache_sound( "fvox/six.wav" )
    precache_sound( "fvox/five.wav" )
    precache_sound( "fvox/four.wav" )
    precache_sound( "fvox/three.wav" )
    precache_sound( "fvox/two.wav" )
    precache_sound( "fvox/one.wav" )
}

public event_round_start()
{
    set_task(4.0, "zombie_countdown")
    time_s = 10
    countdown = 9
}

public zombie_countdown()
{    
    new speak[ 10 ][] = { "fvox/one.wav", "fvox/two.wav", "fvox/three.wav", "fvox/four.wav", "fvox/five.wav", "fvox/six.wav", "fvox/seven.wav", "fvox/eight.wav", "fvox/nine.wav", "fvox/ten.wav" }

    emit_sound( 0, CHAN_VOICE, speak[ countdown ], 1.0, ATTN_NORM, 0, PITCH_NORM )
    countdown--
        
    set_hudmessage(179, 0, 0, -1.0, 0.28, 2, 0.02, 1.0, 0.01, 0.1, 10); 
    ShowSyncHudMsg(0, g_MsgSync, "Infection in %i", time_s); 
    --time_s;
        
    if(time_s >= 1)
    {
        set_task(1.0, "zombie_countdown")
    }
}  
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1049\\ f0\\ fs16 \n\\ par }
*/
