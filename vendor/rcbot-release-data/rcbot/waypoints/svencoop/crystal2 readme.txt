===================================================================
RCbot Waypoint by madmax2 for the Svencoop v4.8 map Crystal2
====================================================================

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

New Updated rcw (Release 2), the whole map is waypointed. Bots will need player's help, and bots will help the player in this map... With this rcw and the latest RCbot 4.8 (see below), the map can now be played without using cheats :) , Thanks Cheeseh...

IMPORTANT: this rcw is for sc4.8 and the latest rcbot release, ONLY. It won't work properly with older versions of rcbot. And the latest version of rcbot will crash on older svencoop versions. It requires the rcbot dll from rcbot_mm_SC48_grapple_upd2.zip or newer, to work properly.

Link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip

Map Author: AzShadow

Map is included with sc4.8

Recommended number of bots/players: 4 or 5 (start with 3 bots, add another bot if you need it). see tips below...

IMPORTANT: METAMOD-P is REQUIRED to run RCbot on this map (sc4.8). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32 or newer. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

** Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. But there are no ladders in this map...

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the crystal readme.txt for install info...

============================================================================================
-----------------------
Details/Notes/problems
-----------------------
The rcw was built/updated with the rcbot dll from rcbot_mm_SC48_grapple_upd2.zip found in the rcbot forums. It won't work properly with older versions of svencoop, it's only for sc4.8 or newer...

Bots know where to go, can use the shortcuts, and press buttons to help the player through the map. A single player can now play & finish the map without using cheats. Bots no longer need to be replaced or teleported. Use my first rcw release if you are playing the map with older versions of rcbot/svencoop...

I do recommend the map areas be played in a specific order, see the next section for that...

Bots can now use the barnicle gun and can grapple, it's great to see and quite funny sometimes :) thanks Cheeseh. During testing, I saw more than once, a bot do a complete 360 degree loop under the 2nd platform to a prefect landing, heh heh... I also saw them go under it but not quite make it over the top, lol...

Most all of the map is waypointed, but I don't have bots going to all areas, such as the optional secret areas. The secret areas are waypointed so bots can do things like press buttons, and get out... You will have to teleport bots into the secret areas if you want to play them. I have tested and completed the secret areas with the bots, they will work. See the readme's from the first rcw's release for info on teleporting bots & cheats. They are not needed for the main parts of the map any more...

The first grapple & jumping part of the puzzle section has been fully waypointed, but I currently have it disabled until I can work out some issues with it. So this part works the same as the first release. Bots won't go to the puzzle area of the map until a player has grappled thru the first part. The player must open the first shortcut there too, for the bots to reach the first platform. Then it is possible for bots to complete the rest of the 2nd area without player help, but it is unlikely this will happen during normal game play. 

In the 2nd part, bots can go both ways now to the 2nd platform. They will ride the rock mover most of the time, and occasionally grapple across and hold the wheel. With this rcw, i probably spent most of the time wpting this wheel. so bots would hold it long enough for players/bots to use the movers, but not get stuck to it, or multiple bots collect at the wheel & jam up. It's balanced so about 1 out of 5 to 10 bots (steam) will grapple to the wheel & hold it for a short while. beware, they often release the wheel, but usually re-engage it at least once. It varies how persistant they will be, sometimes a bot will stay a long time at the wheel, other times a short time. It's a balance i was trying to get, so they would eventually let go of the wheel on thier own, and the player wouldn't have to replace them. Once the 2nd part is completed, the last bot may stay at the wheel for a while, but should release it and move on by the time the player reach's or completes the 4th part.

Bots can now grapple thru the 3rd part of the puzzle, but i have them only doing one side. So the player must do the other side and press the button there at the same time as a bot. it works well, bots usually don't miss the button or the platform, but may only press the button once before moving on to the jumps. What works best for me, is start pressing the your button rapidly as soon as you see a bot grapple across, until they press the button or you here them fall. They are good at pressing that button, so it usually works with the 1st or 2nd bot if you do it right ;)... (bots can now do the jumps to the teleport, & open the shortcut to the 4th part, no more teleporting or replacing bots in this 3rd part)

did other misc tweaks in the puzzle area (mainly to reduce bots falling from movers), the hub area, and one tweak in the combat area for a rarely stuck bot... Increased the desire for bots to go to the puzzle area, once it has been triggered by a player, by making 2 more objective wpts visible to them...

------------------------------------------------------------------------
Tips & Suggestions on how to play this map with RCbots
(mostly for singleplayer, but still good to know if you have 2 players)
------------------------------------------------------------------------

Basicly play the map the same as with the first rcw release, just without using cheats in the main parts of the map. You will still need to teleport bots if you want to play the secret areas...

Summary of how to play map with this rcw:

I'll try not to give away any specific spoilers here, but there are a few things to know that will make the map more playable with the bots. First, I recommend playing the three main areas in a specific order, because of the way I had to waypoint it. The three main areas are:

1. Combat/Hornet gun area (go left) - Left teleport just after caves, go here first

2. Jumping Puzzle/Barnicle gun area (go right) - Right teleport after caves, go here after completing Combat area

3. Final Battle area - Straight ahead behind secured door, go here after getting both crystals, after the combat & puzzle areas

The idea was, combat, jumping puzzle, then combat again... Basicly, the puzzle area is unavailable to the bots until a player goes there. The objective waypoints in the puzzle area are behind an opens later waypoint, that the player will trigger the first time they complete the first part of the puzzle area. If the player does the puzzle area first, it may upset the balance of the rcw?

Bots will, mostly go to these areas in that order, but sometimes wander into the puzzle area early, they will suicide in a short amount of time if that happens (it happens more in nosteam)...

I don't think i'll repeat all the info included with the first release, see those readme's if you need more help...

I would add, start with 3 bots, once you have completed the first combat area, and have opened the first shortcut to the puzzle area, I recommend you add a 4th bot at that point. You still may have to wait a short ammount of time before bots start coming to the puzzle area? It varies, depending on where they are at when you open the shortcut, but an extra bot will help reduce wait times, and will be useful for the final area too... I think 4 bots is overkill for the first part of the map. If you have 2 players, i'd recommend trying just 2 bots for the whole map, add a 3rd if you think you need to?...

The original readme's have more details on the various parts of the map, look at those first, before the spoilers.txt if you need more tips. You can just ignore the parts about using cheats or teleporting bots, it's not needed with this rcw and the latest rcbots, to complete the main parts of the map. The teleport cheat is only needed to play the secret areas...

Have fun,
madmax2

Rev tracking - crystal2_wip4d.rcw
