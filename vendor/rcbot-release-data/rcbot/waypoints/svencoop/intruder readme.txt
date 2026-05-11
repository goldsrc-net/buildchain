=========================================================================
RCbot Waypoint by madmax2 for the Svencoop v4.8/4.7/4.6/4.5 map Intruder
=========================================================================
[Updated Readme, same rcw as before]

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

New rcw, the whole map is waypointed. Bots can run the whole map from beginning to end.

Map Author: Turrican

Map is included with sc4.8, 4.7, 4.6 & 4.5 

Recommended number of bots/players: 2 or 3 (1 or 2 bots for a good time, 3 bots might be ok too)

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.6/4.7/4.8...). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32 (or for sc4.7/4.8 & newer metamod-p v1.21p37 is recommended). Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.
--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

** I highly recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder, for this map.

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the RCbot Installation section at the bottom....

BTW, you don't have to read all this, just install the waypoint and start shooting, yee ha, & have fun. 
============================================================================================
-----------------------
Details/Notes/problems
-----------------------
The rcw was made & tested on sc4.7 with the rcbot dll from the original RCBot1_SC47_release_dll.zip and the latest release rcbot_mm_sc47_3.7z. It should work ok on the other 4.x versions of SC, including sc4.8. No significant changes have been done to the map since its sc4.5 release. 

[Update] The rcw was also tested on sc4.8 with the dll from rcbot_mm_SC48_grapple_upd2.zip, as well as the release posted on the RCbot website, and both dll's work ok with this rcw.

-----------------------
Bots can play & finish the map on thier own, so you can follow the bots if you get lost. You don't want to many bots either, 2 should be enough. The map has more than one route that is randomly generated each game/round. So you may see a different part of the map the second time you play it. Bots will adjust to this, and know how to navigate the map.

There are no major problems with the bots on this map, that I know of. They may bunch up a little in a couple places (like the supply shack at the beginning, or at a ladder if more than one arrive at the same time), but will sort themselves quickly. They may bounce around a little bit at the top of ladders they are going down. Again, I highly recommend setting "config update_ladder_time 0.2" in the bot_config.ini. 0.0 may cause a bot to get stuck at the top of one of the ladders, with 0.2 they wiggle themselves free :)...

Occasionally a bot will get hung up at the bottom of that first ladder, in the first big room with the giant lift. It won't cause a bot jam cause bots will jump over it. It has allways got free and used the ladder successfully. Overall, this seemed to be the best ladder wpt config I tried there...

I used a fair number of opens later wpts and one way paths in this rcw. So occasionally bots will briefly pause at these locations while they recalculate pathways in thier little brains ;).

I did see one minor map bug. At the resupply room, just past the advance spawn, a bot or player might get stuck in the door, causing it to jam, blocking players/bots from entering or exiting the room. I've only seen it twice in dozens of games. If the bot gets killed, the doors will work properly again. Otherwise you might have to kick that bot from the game.

Other than those minor issues, the rcw works pretty good, so go have some fun with it :)...

Note: I built & tested the rcw on nosteam HL as well as steamHL. The rcw works fine on both, but may behave a bit different. My nosteam is fairly old now, and the bots seem to work best with steam and the latest rcbot dll. The testing i did in nosteam was with the original rcbot dll for sc4.7, and the bots seemed to not press buttons as well or fast, they looped back to the supply rooms more too, so they may not complete the map as fast. I'm not sure if it was nosteam, or the rcbot dll i was using with nosteam that was causing the difference. Perhaps I'll test that later? So, results may vary, depending on the versions of rcbot/SC mod/HL you are using. Just something to be aware of, if the bot performance seems different with your setup...

============================================================================================
RCbot Installation (for newer Svencoop versions (sc4.5/sc4.6/sc4.7/sc4.8 etc.))[updated]
----------------------
I'm not going to tell you how to install, but what you need to get started. Basicly you need a rcbot.dll (or rcbot_mm.dll & metamod-p). You also need rcbot_beta_full.zip from the Bots United filebase, it contains all the other supporting files needed to make rcbot work. It also contains installation instructions. See the rcbot website/forums if you need more help. 
Or you can use w00tguy123's installer, which might be easier for beginners. See the last section below for info & links to w00tguy123's installer...

----------------------
Here are some direct links:

rcbot_beta_full.zip (supporting files required to make rcbot work)
The filebase page: http://filebase.bots-united.com/index.php?act=view&id=210
Download link: http://filebase.bots-united.com/index.php?act=download&id=210

----------------------
For newer Svencoop versions you need one of these rcbot dll's and metamod-p (see rcbot forums or search internet for metamod-p, metamod-p v1.21p37 recommended)

You will need one of these dll's, depending on which version of Sven-coop you have:

For sc4.8... http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip
Or the sc4.8 rcbot release from the rcbot website will work for this map too...

For sc4.7... http://rcbot.bots-united.com/downloads/rcbot_mm_sc47_3.7z
Or the rcbot feb. 2013 build will work work for this map too...

or get it from w00tguy123's mirror here:

https://www.dropbox.com/s/0nwuud3oi6t15xz/rcbot_mm_sc47_3.7z

----------------------
For sc4.6 you need this rcbot dll, or the sc4.7 dll's above works too:
Forum Page: http://rcbot.bots-united.com/forums/index.php?s=1b30430041c7cf10fef0247442f64eb2&showtopic=1664
Download link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC46_debug.zip

For sc4.5 you need this rcbot dll:
Forum Page: http://rcbot.bots-united.com/forums/index.php?s=d63f0dc03b1eae5639137c67f3934bf7&showtopic=1479&st=40
Download link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC45_v25.zip

----------------------
Or you can use w00t123guy's rcbot install file, which comes with everything you need in one neat package, originally for sc4.5, I believe. I don't have a link for it, but you can try searching for w00tguy123-bot-pack-v4-.rar , you will need to replace the rcbot_mm.dll with the correct one for sc4.7 or 4.8, if you want the latest. If you can't find w00tguy123's original package, you can try w00tguy123-bot-pack 4[1].6 WORKING.rar, repacked for sc4.6, here:

http://www.sendspace.com/file/pzsgy3

Discussion here:

http://forums.svencoop.com/showthread.php/39937-RcBot-4-6?s=84432a16b31fbc4e91e154c3399d5be8

----------------------

Have fun,
madmax2

Rev tracking - intruder_wip2g.rcw