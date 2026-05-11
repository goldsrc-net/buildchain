=========================================================================
RCbot Waypoint by madmax2 for the Svencoop v4.7 map BlackMesaEPF
=========================================================================

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

New/updated rcw, the whole map is waypointed except 1 area I left for the players to do. Bots can run the whole map from beginning to end with player help.

Map Author: James Bebb a.k.a. Mutant

Map is included with sc4.7 (different map version, different rcw)

Recommended number of bots/players: 2 to 3 (2 bots minimum)

IMPORTANT: METAMOD-P is REQUIRED to run RCbot on this map (sc4.6/4.7). the standard metamod will not work properly, certain events will not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot. 

[sc4.7 Update info] This is an updated rcw for sc4.7 and newer. Most of it is the same as the sc4.6 rcw, except I had to rebuild the waypoint in the cafeteria area. The bots will now multi-path through the cafeteria. Bots do backtrack (loop) some in this area, but eventually get to the end of the hallway past the lasers. Because of the looping, I recommend a minimum of 2 bots. Also, they will often split up in the cafeteria and attack from 2 directions.

If you want to reset the breaker box for the lasers, instead of destroying it, you will need to kick the bots, they will destroy it to turn off the lasers. But I recommend you just destroy it, the bots will just get stuck to the friendly robogrunts.

The waypoint is fully tested and all other areas work the same as they did in sc4.6. This rcw is not compatable with older versions of the map, use the older rcw instead...

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

** I highly recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder (or create a map specific cfg in the rcbot map_configs folder). I haven't checked it at other settings yet. 

============================================================================================
-----------------------
Details/Notes/problems
-----------------------

First, this is a FUN little map, with a few cut scenes and fun combat sequences, nicely done. It does lag at times on my old PC (A64 3200+, winXP), and I have had a couple crashes out of a lot of games with the bots. This may be my hardware? For the most part, with everthing thats going on in this map, it's been very stable. 

Friendly NPC's sometimes get in the way and block the bots, especially in the spawn room and on the bridge there, the HEV suited scientist is the main culprit. He can completely block bots from leaving the spawn room, you may need to kill him, bots won't kill a frindly NPC.

Players will need to do a few things that bots won't do to complete the map. The first is power the one lift in the map, bots will rarely do it themselves. The second involves extending the bridge, and lastly players need to get to the end of the map to end it (bots occasionally will end the map by chance, but they aren't waypointed to do it quickly). Also, if a new area doesn't become available, it means there is an enemy still alive someplace, rarely the bots will miss one, go kill it.

As mentioned above, there is 1 area bots won't go. It is a short section of the map that a player can easily do on thier own, and is required in order to finish the map. The bots will help the player get to this area. As the sections of the map are completed & new areas open up, clues are given where to go next. bots will run up & down the main hallway, & loop back to completed areas sometimes. If you aren't sure where to go next, or what to do when most the enemies have been killed, just follow the bots to the last NEW area to open up, and watch what they do. this should give you a clue where to go explore. I could have waypointed this section of the map for the bots to do, i just chose to leave it for the player. I know the bots could do it easily.

Breakables Problem: Near the Tram area of the map, bots will be stuck on shooting the wall there. I thought it was them shooting at the enemies on the other side of the wall, they seem to see thru 2 sections of the wall. But it's not the enemies, it's the breakable's they are shooting at (the first is the vending machine, sometimes they break this one on thier own). To stop this behavior, shoot the vending machine and all the wood boxes over by the enemies on the other side of the open bridge (shoot the boxes to the right of the bridge first to get the bots moving forward, the rest can be done after all the enemies are killed, good luck). also, there is some glass above the tram to the left that they may have a small problem with, and a sign down the ladder to the right, destroy it (bots shooting at floor near vending machines). 

[sc4.6 only, doesn't apply to sc4.7] Just before this area, at the reception area, there is some bullet proof glass the bots will get hung up shooting at. Well its actually a cart behind the glass they are shooting at, destroy the cart by the HEV station and they will stop wasting ammo on the glass (rarely occurs, this has been mostly fixed by waypointing, bots will detroy the cart themselves now, most games). The cart is not destroyable in sc4.7, so no problem for bots.

----------------------------------------------
Waypoint Details (optional reading)
----------------------------------------------
Looping Problem: Due to the non-linear layout of the map and the use of multiple EOL/objective flags, bots will run around and revisit completed areas. However, the EOL flags are needed to get bots going to where they need to be to help the player. The most annoying looping is through the fish(itchy) tank/lift loop/area. The only way I could minimize it was to remove all EOL/objective flags from this loop/area. They still go there fairly quicky when it becomes available, without an EOL flag.

Lift: I removed the EOL/objective flag that powered the lift, so bots will likely spam the lift button till its been powered. Bots can use the lift fairly well on thier own, getting up the lift most of the time without crushing themselves. I spent a lot of time tweaking the lift waypoints, they will step out of the way of a decending lift better than 50% of the time, and almost allways send the lift back down for the next bot, if they don't get killed first.

The rcw works fairly good overall, I'm not aware of anyplace the bots get stuck permanantly. Some of the looping still bugs me, there may be a future update, but gota take a break from this one for a while...

Have fun,
madmax2

(rev tracking, BlackMesaEPF_wpt4c.rcw)