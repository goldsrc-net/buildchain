====================================================================================
RCbot Updated sc_activist3 Waypoint, by madmax2, for Svencoop v4.7, 4.6(4.5) & 3.0 
====================================================================================

Credit to Cheeseh for createing RCbot... :)

Credit to the original waypointer too... the original rcw, was from w00tguy's waypoint motherload pack, thanks w00tguy... :)

http://rcbot.bots-united.com/forums/index.php

Map Author: Frel

Maps are included with sc4.7 & sc4.6/4.5 
It's also included in the svencoop30content pack @ http://www.svencoop.com/ (but it's a different bsp from the 4.x versions)

Recommended number of bots/players: 2 to 3 (2 bots recommended, for a good time. More than 2 bots will cause problems at some of the slow door triggers, and with the last spawn room door). I played thru the whole map, with 2 bots, on sc4.7 & sc3.0, and the rcw works well with both.

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.5/4.6/4.7). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

For sc3.0, you can use the standard rcbot dll v1.441 (rcbot_beta.zip), no metamod required... The rcw was tested in sc3.0 too, and works good...

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. 

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the sc_activist1 readme.txt for install information....

============================================================================================
---------------------------------------------------------------------
Details/Notes/problems ***IMPORTANT>>> READ THIS SECTION***
---------------------------------------------------------------------
The rcw was tested on sc4.6 & sc4.7 with both dll's, from rcbot_mm_SC46_debug.zip and RCBot1_SC47_release_dll.zip. For sc 3.0, I used the rcbotbeta dll from the filebase. Unlike sc_activist(1), there are no class/enemy/shooting problems in sc4.7. So this map is fully playable in sc4.7, as well as the other versions. (untested in sc4.5, but it should work)

Thankfully, the shooting security guards problem of the first map in sc4.7, is not a problem in this map. Bots will shoot security guards in this map...

Bots can do most all objectives in this map. I did have them doing all of them, but decided it was better to disable activation of the ending sequence by the bots, partly because of the spawn bug in this map.

*** Bots/players will sometimes spawn in the last spawn room of the map, before they are suppose to. If that happens, the map is waypointed so the bots won't activate the ending events. If the bots seem to of disappeared, just kick the bots and add new ones, and make sure they respawned at the beginning (near lift). If this happens to you, the player, you should suicide and restart at the beginning, to play the map properly, and not miss some really fun stuff in this map. You should of gone to the large flooded coolant room at least once, and this room should be drained, before forward spawning. Hopefully, this bug will be fixed in the sc4.8 update?

------------------------------------------
RCW Changes/updates from the original rcw (SPOILER WARNING: read after playing at least once, or if you get stuck)
------------------------------------------
At first lift, added lift button wpts & tweaks, so bots get down it much faster now. Also added a fix to reduce the lift killing bots in sc3.0. Bots still get stuck to it sometimes at the bottom in 3.0.

At the busted up biohazard/HEV room, added wpts & path edits to prevent stuck bots on the broken door, and for smoother navigation thru the broken airlock. Yes, bots now use the airlock to get to the computer console button, to open the security door. They will continue to come to the HEV/Health stations here for a short while after the security door is opened, but will stop doing it.

Reduced fall damage at the ladder. Bots can get down the ladder now without taking fall damage, most of the time...

Bots will press the drain button before jumping into the storage tank. Bots swim thru the drain pipe perfectly now, without getting stuck at the corner and drowning! That took a long while to tweak & fix!

At the flooded coolant room, added swimming paths on the surface of the water so bots don't drown so much. They swim both on the surface & underwater now. They find & press the buttons here a little better now. They are very fast at it in sc3.0, once the sharks are all killed. In sc4.x, they have more difficulty reaching them, diving down to the buttons, even though they have stay close to tags on the button wpts? They can do it, it just takes them longer and more attempts. Once the room drains, bots will find the exit quickly in sc4.x. In sc3.0 they may hang up a short while, looking up at a mid air surface wpt they want to reach. They will give up and will find the exit...

At the last spawn room, added a new door button wpt, bots open the door faster now, but it's not as good as I would have liked. It works better in sc4.x than sc3.0. In sc3.0 they get stuck against the door sometimes, and they need player help to get free. I tried a number of different things, but nothing was obviously better? Perhaps in a future map or rcw update it can be improved? It's ok as is, they can do it on thier own, but a player opening the door & exiting, should help them too.

In the control room where otis is, the door & computer consoles have been waypointed so bots can use them, and I have verified they can get into the room, press the buttons, and exit the room. But, I have disabled this area, so bots won't do it with this rcw right now. This is partly because of the spawn bug, and partly because I think it might be better to leave this for the player to do, it starts a fun event that the player can watch from the safety of this room, then jump into the action. To re-enable this area, 2 paths need to be added back in, a long path direct to the door wpt, and a long path to the wpt just in front of the door. Bots were having problems with the door button and are reluctant to enter, so there is a complicated non-standard wpt config here to get them thru the door. To be extra safe, when I disabled this area, I also removed the EOL/objective tags from the control room buttons. They will definately use those buttons, if tagged. They will also use them to a much less degree if not EOL/obj tagged, but at least one EOL likely needs to be someplace in the room to draw them in there to see the buttons...

In sc4.x, the bots will use the exit tunnel much more than sc3.0. Bots are focused on battling the enemies here, rather than the exit. I tried to wpt the exit so bots in sc4.x won't just exit & end the game right away, but they will eventually end the game (in sc3.0, bots likely won't end the game). If you want them guaranteed to end the game much quicker in either version, remove the long path from the wpt directly under the ceiling turret to the wpt just outside the exit door. This will prevent bots from re-entering the battle once they go into the exit tunnel, forcing them to the end of the map.

And a few misc slow door, and wpt/path tweaks around the map...

Have fun,
madmax2

Rev tracking - sc_activist3_fix2e.rcw