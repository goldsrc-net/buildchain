============================================================================
RCbot Waypoints by madmax2 for the Svencoop v4.8/4.7/4.6 map deadsimpleneo2
============================================================================
[Updated Readme, same rcw's as before]

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

New rcw, the whole map is waypointed.

Map Author: Nih

Map is included with sc4.8, 4.7, 4.6 & 4.5
(rcw's were never tested on sc4.5)

Recommended number of bots/players: 2 to 4
Nih recommends 4 to 8 players, so you may need more? But my lame old PC won't handle that many bots with everything thats going on in this map :( ...
--------------------------------------------------------------------------------------------
I've included 2 rcw's for this map:

deadsimpleneo2.rcw - (default) Bots lower & raise center platforms more, intense action in the center of the map.

deadsimpleneo2_alt.rcw - (alternate) Bots lower/raise platforms less than default rcw, giving players more control in center of map. Action is still high, and bots may get outside weapons a little more than default rcw. Server op's may prefer this one?
--------------------------------------------------------------------------------------------
IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.6/4.7/4.8...). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32 (or for sc4.7/4.8 & newer metamod-p v1.21p37 is recommended). Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.
--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw's in your \rcbot\waypoints\SvenCoop folder. You will need to rename the alternate rcw if you want to use that instead of the default rcw. 

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the RCbot Installation section at the bottom....
--------------------------------------------------------------------------------------------
-----------------------
Details/Notes/problems
-----------------------
ADDING BOTS: The Game Mode selection room is waypointed. Bots will randomly pick a game mode by jumping through a tube. When a bot jumps through a tube of the game mode you want to play, be ready to follow right behind him, the lasers will only be off a short time. Be patient, they will select all game modes. If you add more than one bot in this room, you may not get the game mode you want, but the second bot is usually not fast enough to activate a game mode, so it's probably ok. As an alternative, you can temporarily turn on the RCbot cheat, rcbot util noclip_mode, and fly into the tube of choice :) ... then add bots...

Remember, bots won't play the map strategically, so the best game mode for them is classic. But they can help on other modes to, and give you a fighting chance. They are probably least useful in overload mode when only one person is playing. You can use them to help fill out a server too.

Bots will grab weapons from the platforms as well as the guass gun when available. They don't get the outside 'better' weapons in the corners very often, even though each one has an objective flag on it. Too much action in the center of the map, I think?

Slight Bug: With the release of sc4.7, on some maps, rcbots sometimes are not shooting certain enemy classes. In this map, it is the enemy bodygaurd, usually with uzis. I don't think this will be a problem on older SC versions (4.6 or 4.5). The enemy bodygaurd doesn't show up until the later stages/wave, and you should be able to take them out while they are slaughtering the bots... hehe.. Cheeseh is working on a fix to resolve this issue with the next rcbot1 release, check the rcbot forums for any updates.

[Update: Bug fixed] The enemy bodyguard problem was fixed in the last rcbot dll release for sc4.7. Bots will shoot the bodyguards with the dll from rcbot_mm_sc47_3.7z, see install section for a link... Or use sc4.8 with the latest rcbot...

============================================================================================
RCbot Installation (for newer Svencoop versions (sc4.5/sc4.6/sc4.7/sc4.8 etc.))[Updated]
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
This rcbot dll fixed the enemy bodyguard shooting bug on this map.

or get it from w00tguy123's mirror here:

https://www.dropbox.com/s/0nwuud3oi6t15xz/rcbot_mm_sc47_3.7z

----------------------
For sc4.6 you need this rcbot dll (or the rcbot sc4.7 dll above may work, but I didn't test it?):
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
If you haven't done so, check out my other waypoints at the rcbot site... shameless plug... :)

Have fun,
madmax2

Rev tracking - deadsimpleneo2_wip4.rcw & deadsimpleneo2_wip4b.rcw