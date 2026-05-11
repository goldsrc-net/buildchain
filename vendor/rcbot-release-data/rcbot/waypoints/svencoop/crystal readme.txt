====================================================================
RCbot Waypoint by madmax2 for the Svencoop v4.8 map Crystal
====================================================================

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

New Updated rcw (Release 3), the whole map is waypointed. Bots will need player's help, and bots will help the player in this map... With this rcw and the latest RCbot 4.8 (see below), the map can now be played without using cheats :) , Thanks Cheeseh...

IMPORTANT: this rcw is for sc4.8 and the latest rcbot release, ONLY. It won't work properly with older versions of rcbot. And the latest version of rcbot will crash on older svencoop versions. It requires the rcbot dll from rcbot_mm_SC48_grapple_upd2.zip or newer, to work properly.

Link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip

Map Author: AzShadow

Map is included with sc4.8

Recommended number of bots/players: 3 or 4 (2 or 3 bots for a good time)

IMPORTANT: METAMOD-P is REQUIRED to run RCbot on this map (sc4.8). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32 or newer. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

** Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. But there are no ladders in this map...

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the RCbot Installation section at the bottom....

============================================================================================
-----------------------
Details/Notes/problems
-----------------------
The latest rcbot release, fixes the problem bots had with turrets in this map :). The rcw was built/updated with the rcbot dll from rcbot_mm_SC48_grapple_upd2.zip found in the rcbot forums. It won't work properly with older versions of svencoop, it's only for sc4.8 or newer...

Bots know where to go, can use the shortcuts, and press buttons to help the player through the map. A single player can now play & finish the map without using cheats. Bots no longer need to be replaced or teleported out of the puzzle room. The rcbot massive explosion cheat is no longer needed to destroy inactive mounted turrets. Use my first rcw release if you are playing the map with older versions of rcbot/svencoop...

Some of the changes since the first release include:

Bots no longer waist time going into that small office at beginning of map

Added pain/death wpts for the "firewall" at the ruptured panel. It's not perfect, but bots can detect the danger there now, will stop & press the button almost as well as before. Changed the button wpts here, now they are not forced thru a nocliped wpt in the panel. So once the firewall is turned off, bots no longer stick to the panel. They get thru this part of the map faster now...

bots should be better at opening the first shortcut door (rock/bolder), but a player will probably be faster?

Other path/wpt tweaks...

The big change is at the lifts & puzzle room. There is now a bidirectional path to the puzzle room, so bots can now go up the lift to the puzzle room, then return to the lifts & go down, with the players help. Both lifts are used by bots now, one to go up & one to go down. Changed the button wpts/paths in the puzzle room for better performance. 

Note, since bots are no longer forced to stay in the puzzle room, it is more difficult to get bots to press the buttons. It's a bit tricky, but not real hard to do, see next section for tips...

Added wpt to panel (puzzle room) that opens final security door, bots will use it if player doesn't do it first...

Added pain/death wpt to the lasers, bots will now go to the HT location more, very little waiting for bots there now.

------------------------------------------------------------------------
Tips & Suggestions on how to play this map with RCbots
(mostly for singleplayer, but still good to know if you have 2 players)
------------------------------------------------------------------------
------------------------------
The Lifts & Puzzle Room tips:
------------------------------
The lifts are the control point for allowing or blocking bot movement to & from the puzzle room. The first lift you come to (left), is down only. The right lift is up only. You can leave the lifts down when not playing the puzzle part of the map. Bots will try to go up the up lift, for the duration of the game, but will give up quickly and move on to other parts of the map. 

Note, you can only use the external lift buttons to retreive lifts. you can only send a lift up or down by using the button in the lift, and jumping out quickly...

There are a few advantages to using both lifts, one is bots will exit the up lift quickly, just press the lift button & jump out quickly, wait a few seconds and press the button at the bottom to bring it back down. I've added a "wait for lift" wpt at the bottom of the up lift. So now, when you are playing the puzzle part of the map, to bring bots up the lift, you can do it from the top of the lift, without having to go down to get bots. Here is how I use the lifts when playing the puzzle part...

First, I raise the down (left) lift to block bots from leaving the puzzle area, to keep them up there. Then I send 1 or 2 bots up the right lift, or ride up with them. then I lower the up lift, so it will be ready to collect more bots. Later, when i return here from the puzzle room to collect a 2nd or 3rd bot, all I need to do is bring the up lift, up, and check if there is a bot in there. If there is he will likely head for the puzzle room. You have about 10 seconds to send the lift back down safely. any bots that were approaching at the bottom will wait 10 seconds before going to the "wait for lift" wpt. So about the only time you will crush a bot at that lift is, if one enters or exits it at the bottom, just as you raise the lift. So I keep the up lift down most of the time, I raise it to check for a bot in it, then send it back down immediately after. 

Bots will occasionally collect at the down lift, trying to go down. sometimes one will fall out the back side of the lift, just check the up lift to replace it, if that even happens. You can coax them out of the down lift by banging your crowbar on the wall or floor nearby, or giving them a good wack ;) (but sometimes they will be stuborn).. But don't spend to much time at that, because eventually they will give up & return to the puzzle room on thier own...

Now for the puzzle room, without giving to much away. The trick to getting bots to going to different areas of the room is sound. RCbots can hear, and it is a very useful thing to know while playing SC with the bots. I don't want to give away the puzzle here, but by banging your crowbar a few times, at various spots in the room will cause the bot to go there & do something (be sure to step back & give the bot some space or you might block it). then you can do something too. I usually start with 1 or 2 bots. I will say, the wheels are no problem for the bots, but they have some difficulty seeing the buttons, and won't always press them. They will press them, but you will have to be a little patient, persistant, and be ready & in position yourself... Use the crowbar on the buttons, or the floor in front of the buttons when you need a bot to use a button...

Bots won't stay in the puzzle room like the last rcw, they will go back to the down lift, then return (if you left it up). Usually one bot is enough for completing the first part of the puzzle. It's no problem getting bots to use the wheels, however the buttons are another matter, they don't see them well, or are reluctant to press them. But I did notice a pattern with the bots, when they are more willing to press buttons. It was happening with the first rcw too, I just didn't see it before. Before it was the open path at the doorway at the puzzle room, now it's the blocking lift down path. Bots try to leave and go to the furthest wpt they can reach, in this case the lift, when they return to the puzzle room they seem more receptive to pressing a button, so be ready to press the other one. I have seen them go directly to the right button in the room and press it, just after returning from the lift. So it seems they need to leave the room once, go to the lift and come back, before they will press the buttons willingly. Using your crowbar to make noise, and pressing buttons rapidly may help draw thier attention to the buttons. also bringing a third bot up the lift seemed to help too, increasing the chances a bot will press a button. It's not as hard as i make it sound, you may have to go back to the lifts once or twice to fetch bots back, or a new bot, it's just a bit more running around than before. 

Once you have finished the puzzle, you may need to bang your crowbar to get the bots in there to follow you back to the lift & ride down with you. there may be one bot that doesn't want to leave or let go of the wheel, just leave him behind, he will eventually come on his own. Leave both lifts down when you are done, the last bot will jump down the lift shaft & return to play.

----------------------
Human Tower (HT) tips:
----------------------
(for single player with bots, with 2 players you don't need the bots for this part)

The HT in this map is a bit tricky & can be frustrating if you don't know how its done. The bots will do it rarely on thier own (after the player doe's something first, its fairly obvious). I'll have to spoil this a little, but its a HT into a vent. You can boost a bot up, or they can boost you. Bots can press the button at the other end of the vent the first time, most of the time. In steam, its much easier to have a bot boost you. For some reason, its easier to boost bots up into the vent in nosteam than in steam, they just tower up better in nosteam! (update: in my last playtest I had no problem boosting several bots into the vent in steam! so, i don't know, maybe i'm just getting better at it? :))

To get boosted by a bot here is tricky, but easier to do than boosting a bot, in steam. Get on top of the crouched bot, you will have to crouch/jump onto him, but then release your crouch key, facing the wall, move around until your head pops up into the vent, then quickly press your chest against the lower edge of the vent, then crouch/jump into it before the bot under you moves. This may take a little practice...

To boost a bot, look straight up, crouch, & center yourself under the vent hole, you will need to experiment a few times to find the right location, but its just slightly off center. Let a bot get on top of you then let go of the crouch key, but don't jump or move to much. if you are in exactly the right spot, they will wiggle around & move towards the wall, you will still be crouched but when the bot gets in the right spot you will pop up to a standing position. at this point it takes a few seconds, but if all goes well the bot will get into the vent on its own. basicly, the bot needs to get its head poked in the vent, in a standing position, then it will crouch into the vent on its own. When the bot has its head poked in there, if it looks like its going to back up, you can sometimes block it with a slight movement, but not to much or it will slip off the other way. It's very tricky in steam, i found it much easier in nosteam...

Once you find the sweat spot, the bots can do it fairly well, and it gets easier to do with practice... I don't have the bots forced up the HT, so they will give up, leave and return to try again. A forced path was causing stuck bots & suicides, i didn't want that... with 3 or 4 bots they will keep returning here on a regular basis, until the task has been done at the other end of the vent.

============================================================================================
RCbot Installation (for newest Svencoop version only, sc4.8) 

This rcw REQUIRES sc4.8 & the latest rcbot dll...

----------------------
I'm not going to tell you how to install, but what you need to get started. Basicly you need a rcbot.dll (or rcbot_mm.dll & metamod-p). You also need rcbot_beta_full.zip from the Bots United filebase, it contains all the other supporting files needed to make rcbot work. It also contains installation instructions. See the rcbot website/forums if you need more help. 
Or you can use w00tguy123's installer, which might be easier for beginners. 

----------------------
Here are some direct links:

rcbot_beta_full.zip (supporting files required to make rcbot work)
The filebase page: http://filebase.bots-united.com/index.php?act=view&id=210
Download link: http://filebase.bots-united.com/index.php?act=download&id=210

Or you can use w00t123guy's rcbot install file, which comes with everything you need in one neat package, originally for sc4.5, I believe. I don't have a link for it, but you can try searching for w00tguy123-bot-pack-v4-.rar , but you will need to replace the rcbot_mm.dll with the correct one for sc4.8. If you can't find w00tguy123's original package, you can try w00tguy123-bot-pack 4[1].6 WORKING.rar, repacked for sc4.6, here:

http://www.sendspace.com/file/pzsgy3

Discussion here:

http://forums.svencoop.com/showthread.php/39937-RcBot-4-6?s=84432a16b31fbc4e91e154c3399d5be8

----------------------
For Svencoop version 4.8 you need this rcbot dll and metamod-p (see rcbot forums or search internet for metamod-p):

http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip

You can find the latest disscusion on this rcbot version in this thread:

http://rcbot.bots-united.com/forums/index.php?s=a0e54e8fadba8a381bf4726e8c1c9175&showtopic=1815&st=20

And here:

http://forums.svencoop.com/showthread.php/41029-RCbot-amp-SC4-7-4-8-issues?s=84432a16b31fbc4e91e154c3399d5be8

----------------------

Have fun,
madmax2

Rev tracking - crystal_wip4d.rcw
