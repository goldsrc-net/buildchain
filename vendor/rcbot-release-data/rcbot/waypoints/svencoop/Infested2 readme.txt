==================================================================
RCbot Waypoint by madmax2 for the Svencoop v4.6 map Infested2
==================================================================

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

New rcw, the whole map is waypointed. Bots can run the whole map from beginning to end with player help.

Map Author: cold_blood3d (Matt McLean)

This rcw is for the 2nd map in the series, both maps are quite fun to play. So be sure to play the first map too...

Map is included with sc4.6 (& soon to be released sc4.7, I think this rcw will be compatable with sc4.7 too.)

Recommended number of bots/players: 2 to 3

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.6/4.7). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

Note: A rcw for the first infested map is included in w00tguy123-bot-pack-v4-.rar, as well as the old/incomplete rcw for infested2 that this rcw replaces. This pack includes more than just waypoints, so be careful you don't overwrite something you don't want to...
--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

** Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. 

But for Infested2 I highly recommend setting "config update_ladder_time 0.0" for the long ladder in this map. I think bots are going down ladder faster at 0.0 setting, which is critical at this point in map. Instead of changing this setting in the bot_config.ini, you can change it in the console while playing OR you can create a map specific cfg in the rcbot\map_configs\SvenCoop folder, for this map only. I included an infested2.cfg file for this purpose.

============================================================================================
-----------------------
Details/Notes/problems
-----------------------

The rcw isn't completely new, but it may as well be. I used about 15 of the 20 waypoints from the infested2 rcw (554 bytes) in the rcbot_sc_waypoints.zip pack, not sure who made it. It was incomplete and ended near top of first elevator. This rcw currently has about 128 waypoints (2900 bytes) and is complete, and fixes bots riding up the elevator. Bots can use the elevator now on their own without player help. They will press the elevator button and ride up the elevator, so be sure to get in or they will leave you behind. 

I did leave a few things for the player to do. The bots could press more buttons, but I left a few for the player, so they can catch up and be in the right place for some events. 

At the beginning of the map, bots will waste ammo on shooting at the fish in the aquarium, it must be bullet proof glass (that must of cost a lot of $$$, LOL), but it's not crowbar proof (who designed this aquarium anyways, Hommer Simpson?). Break the glass and kill all the fish, then the bots will quit wasting ammo & time here. Later in the map there is a couple things the player must do that bots won't do. The second thing involves taking an object some place and using that object, although there may be another way to accomplish the same result that I haven't tested yet.

The biggest bot & waypoint problem is the long ladder, it's very long. I haven't yet figured out a way to get the bots down the ladder quickly, which is important at this point in the map. They can get on the ladder & will go down it, but slowly. Also they often climb to the top of the ladder before decending it. Removing the upper ladder waypoints won't help & doesn't prevent this. Those waypoints were added latter to get them to go down faster, once up there! So once you get to this ladder, don't wait for the bots, just go down it and kill as many enemies as you can as fast as you can. There may only be enough time to die & make a second trip down the ladder. There will be some, but not a lot of help from the bots. You could try adding a couple more bots at this point in the map, but they might get in you're way on the ladder? Eventually, I will take another look at this ladder, and will post an update if I can improve the bots performance here? But, I'm not sure if it's possible with waypointing tweaks?

Have Fun,
madmax2
