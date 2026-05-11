============================================================================================
RCbot Modified Waypoint (rev3) by madmax2 for the Svencoop v4.8 (4.7 4.6 & 4.5) map Infested
============================================================================================

Credit for most of this rcw belongs to the original waypointer, who I believe was w00tguy123. The original rcw came from his package (w00tguy123-bot-pack-v4-.rar). 

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

Includes Updated/modified rcw for Svencoop v4.8, 4.7, 4.6, 4.5

Map Author: cold_blood3d (Matt McLean)

This rcw is for the first map in the series, both maps are quite fun to play. So be sure to play the second map too...

Map is included with sc4.8, 4.7, sc4.6, & sc4.5

Recommended number of bots/players: 2 to 4

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.6/4.7...). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32 (for sc4.7/4.8 & newer metamod-p v1.21p37 is recommended). Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

** Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. 

Latest rcbot dll's...

For sc4.8... http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip
Or the sc4.8 rcbot release2 from the rcbot website will work for this map too...

For sc4.7... http://rcbot.bots-united.com/downloads/rcbot_mm_sc47_3.7z
Or the rcbot feb. 2013 build will work work for this map too...

For sc4.6... http://rcbot.bots-united.com/downloads/rcbot_mm_SC46_debug.zip

For sc4.5... http://rcbot.bots-united.com/downloads/rcbot_mm_SC45_v25.zip

============================================================================================
-----------------------
Details/Notes/problems
-----------------------
This version of the rcw was modified & tested on sc4.8 steam (with rcbot_mm_SC48_grapple_upd2.zip) & sc4.7 nosteam (with rcbot_mm_sc47_3.7z). It should work ok with sc4.6/4.5 with the correct rcbot dlls above. There are no human tower or jumping puzzles in the map that can sometimes cause problems with different rcbot versions. Infested & infested2 are good combat maps...
-----------------------
Rev3 Changes:
-----------------------
The main purpose for this update was, the bots were frozen, would not move, with the newest rcbots in sc4.8. It was also occuring in sc4.7 with the latest rcbots, but bots worked properly with the feb 2013 build of rcbot for sc4.7. I found there were 2 defend flags on 2 objective wpts. This was causing bots to go into defend mode from anywhere on the map, appearing to be frozen. After removing one defend flag, they began to move, but would randomly freeze up at intervals. Removing all the defend flags from the rcw fixed the issue for sc4.8 & 4.7.

I also did a number of other adjustments to the rcw, such as tweaks for smoother navigation in a few places. The other major changes are...

added pain/death wpt to the laser door, bots rarely suicide on them now, and find the panels to disable the lasers...

added new wpts/paths on 2nd floor at big momma room, so bots use 2nd floor more and can shoot down on big momma too...

at helipad, added new wpts/paths, and connected to wpts & new unreachable wpts near snipers. now bots can shoot back at snipers, sometimes. I moved bots closer to the edge, the snipers seem to be at or near the bots maximum visable range. So they still have a hard time seeing them, or getting into range before they get sniped, killing a couple snipers will help bots get into range. I've seen them use sniperrifle, mp5, the RPG, and even the uzi's to shoot back, with my modified weapons ini. also, added a jump tag to the HEV charger here, i havn't seen a bot stuck to the charger since... 

Map Problem: Not sure why I didn't notice this before, but the elevator in this map intermitantly gets stuck at the top, and won't return to the bottom. If the library/vent part has not been completed then respawning players & bots won't be able to use the lift to get to the library. It won't happen every game round, but I did see it happen on both sc4.7 nosteam & sc4.8 steam several times while working on this rcw. I don't think it is a rcw problem. If it happens, all you can do is start over, or turn on cheats to noclip past this part of the map. Break the vent covers with the crowbar to activate a forward spawn, then either add new bots or teleport the bots to the new spawn or library (enemies will kill them & they will respawn on other side of vent).

-----------------------
Previous Changes:
-----------------------
I fixed the elevator so bots can use it on their own without player help. They will press the elevator button and ride up the elevator, so be sure to get in or they will leave you behind. 

Bots run down side of truck tunnel instead of middle, see below for truck info. In the second half of the map, just past the library bots will get the RPG. Bots will now attack the heli-pad area from 2 directions (both routes to it). A few door & stairs tweaks for better navigation, etc.

Issues:
Bots currently will use all thier ammo trying to shoot out the vent covers in the library. The player must do it with a crowbar. Be sure to get in the vent before the bots or they will block access to the vent cover at the other end, or you will have to remove them & re-add them.

I changed the waypoints at the truck spawn room and along the truck path. 2nd & 3rd bots often get crushed in the back of the truck at the corner. This happened with the original rcw too.

[Update/fix - rev2]
I fixed the truck spawn so bots don't all jump in the truck. Most of the 2nd & 3rd bots in the truck get crushed at the curve. One bot makes the truck ride all the way just fine, & to many bots in the truck makes less room for players and may crush the player too.

This rcw reduces the chances that all the bots will just jump in the back of the truck and actually gives the player some control over the bots at the truck! With my first rcw all the bots would quickly jump in the truck & there was no way to prevent it, except remove or not adding extra bots.

Optional read - Crude method for controlling number of bots in truck, otherwise just play it and a bot may or may not follow you into truck:

Bots will now be much slower and may appear reluctant to get into the truck. Usually one will get in on its own in the first 30 seconds, but if not, you can coax them in. By simply getting into the truck, bots may follow, they follow the player sometimes. You can bang on the truck or walls with the crowbar, inside or outside of the truck, to get them to come to you, bots are attracted to the sound. But once in the truck you won't get them to jump back out with the crowbar banging, because of the way it's waypointed now.

Ideally, one bot in the truck works the best (all the way in against the truck wall, so it won't jump out when the truck moves). To reduce the odds that more bots will get into the truck, immediatly open the tunnel door or bang on the walls outside the truck. If the bot in the truck isn't all the way in, you can bang on the front grill of the truck, and the bot will move forward. Bots outside will also come to the front of the truck.

You can also open the tunnel door then add bots, this will keep bots in the truck to a minimum or zero. With this rcw bots will jump out more, once it starts moving, but the first bot usually stays in it, if it's all the way in the truck. btw, bots don't open the tunnel door at the start of the map...

Have Fun,
madmax2

(tracking - infested_fix4f.rcw )