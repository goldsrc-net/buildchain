======================================================================================
RCbot sc_activist(1) Waypoint(rev2), by madmax2, for Svencoop v4.6(4.5) (4.7) & 3.0
======================================================================================

This rcw will work on sc3.0, 4.5, and 4.6. Bots currently are not shooting at some enemies in sc4.7 on this map. Once Cheeseh updates the bot, this rcw should work in sc4.7 too, hopefully. Although I may need to add a map cfg file for the bot? Will have to wait & see... It has been tested in sc4.7 to verify bots run the map the same as sc4.6...

New Note: You can play the map in sc4.7 with the bots, they just currently won't shoot the security guards, mostly at the beginning of the map. However, they are a distraction for the security guards, so that will help you some. Also, they will shoot other enemies in the map, and do everything else, just like in the other versions of SC.

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

[See Rev2 Updates in Details section, for new rcw fixes.....]

Completely new rcw, the whole map is waypointed. I re-waypointed the map because the rcw included with all of the waypoint packs I found, seemed to be corrupt, bots were freezing up & not running the map in any svencoop versions listed above! Or perhaps it was made on an older version of rcbot, 1.3 maybe? Anyways, this rcw will work with any rcbot version 1.4 beta or newer...

Map Author: Frel

Map is included with sc4.7 & sc4.6/4.5 
It's also included in the svencoop30content pack @ http://www.svencoop.com/

Recommended number of bots/players: 2 to 3 (2 bots recommended, for a good time. Also, more than 2 bots will cause problems at some doors, because of the slow, poor, door triggers)

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.5/4.6/4.7). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

For sc3.0, you can use the standard rcbot dll v1.441 (rcbot_beta.zip), no metamod required...

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw's in your \rcbot\waypoints\SvenCoop folder. 

Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. But there isn't any ladders in this map!

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the RCbot Installation section at the bottom....

BTW, you don't have to read all this, just install the waypoint and start shooting, yee ha, & have fun. 
============================================================================================
-----------------------
Details/Notes/problems
-----------------------

The rcw was mostly tested on sc4.6 with both dll's, from rcbot_mm_SC46_debug.zip and RCBot1_SC47_release_dll.zip. For sc 3.0, I used the rcbotbeta dll from the filebase. It was also checked on sc4.7, to be sure bots could press all the buttons, etc.

-------------------
Rev2 RCW Updates:
-------------------
New path at 2nd level in cafeteria, bots can chase the dog's up there now, or run from them, heh heh...

HEV/Health Stations - significantly reduced bots getting stuck on chargers. Went back to a 4 wpt setup there and using crouch & crouch/jump wpts seemed to of helped a lot. May still happen occasionally, but seems much easier to knock em free with a crowbar now, when crouched...

Bots no longer hang up on the Biohazard Computer room door.

Biohazard/HEV room - Reduced the crazy button spamming here, but I decided to leave the path thru the airlock, so bots still go to the computer console button. So, usually with 2 bots, one will get semi-trapped in the airlock on its way back from the computer console. It's less than the previous rcw, and the player can let it out easily. The reason i left it this way, is so the player has a better chance to experience the dogs in the cafeteria. Otherwise the player would have to press the button and would have to get by the sentry turret to get to the cafeteria action. The downside is, after the area is cleared of enemies, and especially with sc3.0 rechargable containment bots, one of the bots often wants to go thru the airlock, leaving less help with the containment bots. Allthough, probably 1 player + 1 bot is good enough to deal with the containment bots, in either sven version.

-------------------
But, if you prefer more help with the containment bots, and don't mind pressing the computer console button yourself, here is how to change that on a listenserver/client PC... 

You will need to delete one of the 2 wpts in the airlock. Bots will no longer use the airlock, but will continue to come here for HEV/health (bots really want the HEV power), then they will go towards the cafeteria/containment bots without delay. They will suicide on the ventalation fan until the player press's the computer button.

To delete the correct airlock wpt, stand just inside the first airlock door (between the 2 airlock buttons). Activate the console (~ key), and type the following two commands:

rcbot waypoint delete {enter}
rcbot waypoint save {enter}

thats it, you are done...

If you want to see the wpt you are deleting, type, rcbot waypoint on {enter}, first. But its not nessesary... Just be sure you have a backup rcw, in case something goes wrong...

---------------------------------------------------------------------------------------
Previous RCW Fixes:

Bots can use the elevator/lift much better/faster than the previously uploaded wip rcw. I had to add a jump wpt in front of the lift to fool bots to jump into it, because when I changed the button wpt config to a red lift/button wpt, bots want to go to the button instead of the lift, all of the time, for some unknown reason? They will jump around erraticly now, but they will bring the lift up & get in it faster now. Also, in sc3.0 only, bots were sometimes sticking to the walls here, the jump wpt helps them get free or suicide faster. At the bottom of the lift, again for sc3.0 only, I added jump wpts. In sc3.0, after a while, the lift starts crushing bots/players, it becomes sticky. The jump wpts saves most of the bots from certain death here... It's not a problem in sc4.6...

I tweaked the paths in the supply room at the bottom of the lift, so bots pick up weopons & ammo better.

I fixed the wpts at the first door in the biohazard/HEV room, so bots can exit it now w/o to much trouble.

I did a number of other changes in this area too. Bots can & will go though the airlock & press the button on the computer console. They can & will also go through the ventilation to do battle with the Containment Robots. 

A few misc tweaks here & there too....

-------------------
Fixes "To do" for next update [Rev2 - both are done]:

Bots sometimes get stuck on HEV charger, wack them with a crowbar, or drain the charger for now... or another bot will come & drain the charger and the stuck bot will let go...[rev2 - mostly fixed...]

Bots go button happy in the biohazard/HEV room because of the way I waypointed it. They also have a lot of trouble getting all the way through the airlock here, but they can do it. and if 2 bots get trapped in the airlock, they will press the door button thru the wall & get out! I know what I need to do to fix/reduce this behaviour. But, Bots won't get to the computer console nearly as much, or use the airlock as much, which is probably better. I'm testing to find a better balance for different sven versions. With this rcw, rcbots in sc3.0 don't get to the computer console nearly as much as they do in sc4.6, but it's still playable. [rev2 - reduced button spamming, much better]

============================================================================================
RCbot Installation (for newer Svencoop versions (sc4.5, sc4.6, sc4.7, etc.))
----------------------
I'm not going to tell you how to install, but what you need to get started. Basicly you need a rcbot.dll (or rcbot_mm.dll & metamod-p). You also need rcbot_beta_full.zip from the Bots United filebase, it contains all the other supporting files needed to make rcbot work. It also contains installation instructions. See the rcbot website/forums if you need more help.

----------------------
Here are some direct links:

rcbot_beta_full.zip (supporting files required to make rcbot work)
The filebase page: http://filebase.bots-united.com/index.php?act=view&id=210
Download link: http://filebase.bots-united.com/index.php?act=download&id=210

----------------------
For newer Svencoop versions you need one of these rcbot dll's and metamod-p (see rcbot forums or search internet for metamod-p)

For sc4.7 you need this rcbot dll:
http://rcbot.bots-united.com/downloads/RCBot1_SC47_release_dll.zip

For sc4.6 you need this rcbot dll, or the sc4.7 dll above works too:
Forum Page: http://rcbot.bots-united.com/forums/index.php?s=1b30430041c7cf10fef0247442f64eb2&showtopic=1664
Download link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC46_debug.zip

For sc4.5 you need this rcbot dll:
Forum Page: http://rcbot.bots-united.com/forums/index.php?s=d63f0dc03b1eae5639137c67f3934bf7&showtopic=1479&st=40
Download link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC45_v25.zip

Or you can use w00t123guy's rcbot install file, which comes with everything you need in one neat package, currently for sc4.5, I believe. I don't have a link for it, but you can try searching for w00tguy123-bot-pack-v4-.rar , you will need to replace the rcbot_mm.dll with the correct one for sc4.6, if you want the latest. If you can't find w00tguy123's original package, you can try w00tguy123-bot-pack 4[1].6 WORKING.rar, repacked for sc4.6, check the svencoop.com message forums for the url.

----------------------
For sc3.0 you need this rcbot dll (v1.441): 

rcbot_beta.zip (only use for sc3.0 or sc2.1, will not work for sc4.5, sc4.6, or newer)
The filebase page: http://filebase.bots-united.com/index.php?act=view&id=205
Download link: http://filebase.bots-united.com/index.php?act=download&id=205

Also, For sc3.0 I tested LordSkitch's modified rcbot.dll and it works good too. It can be downloaded from new links at the bottom of this forum page:

http://rcbot.bots-united.com/forums/index.php?s=3ad93e78bf66b025f66c10d9ebdeb726&showtopic=1011&st=40

Or directly here:
http://rcbot.bots-united.com/downloads/rcbot_new/rcbot_8_17_08.zip

Or here:
http://www.fileden.com/files/2012/7/14/3325928/rcbot%20files/rcbot_8_17_08.zip
----------------------

Have fun,
madmax2

Rev tracking - sc_activist_wip3d.rcw