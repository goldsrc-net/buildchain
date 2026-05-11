=====================================================================================
RCbot modified/updated Waypoint (REV2) by madmax2 for the Svencoop v4.6 map Shattered
=====================================================================================
(original waypoint from rcbot_beta_full.zip from the filebase, Cheeseh's rcw.. 7878 bytes)

Credits to Cheeseh for createing RCbot & the original Shattered Waypoint, thanks man...

http://rcbot.bots-united.com/forums/index.php

Feedback can be made in this forum thread:
http://rcbot.bots-united.com/forums/index.php?s=178bd34407286689cd72571f785923eb&showtopic=34

Map Author: Remy LeBeau

Map is included with sc4.6 (& soon to be released sc4.7, I think this rcw will be compatable with sc4.7 too.) The rcw should work with sc4.5 too. 

[REV2 rcw]: Reworked a couple areas to make the waypoint compatable with sc3.0 & work better in sc4.6 (mainly elevator ladders & upper fan shaft). The rcw has been fixed/tested for those players running a LAN game on a CD install of halflife v1110 & sc3.0, using the RCbotbeta dll v1.441 from the filebase. It has also been improved for sc4.6. see details below for more info.

But it hasn't been tested with any older versions. Many of the recent edits to the rcw may cause problems for older versions of the bots/mods (sc2.1)? 

Recommended number of bots/players: 3 to 4 
(optional: you may want to add an extra bot when you reach the big fans)

IMPORTANT: Allthough the standard metamod may work with this map ok, on the latest versions of svencoop, it's probably best to use metamod-p when using RCbot with sc4.0 or newer. 

Standard Warning .. METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.6/4.7). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

If you are playing sc3.0/2.1 on a LAN with the RCbotbeta from the filebase, then the standard metamod should work fine. Or you can use RCbot without metamod too...

** I highly recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder (or create a map specific cfg in the rcbot map_configs folder). I haven't checked it at other settings yet. 

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the RCbot Installation section at the bottom....

BTW, you don't have to read all this, just install the waypoint and start shooting, yee ha, & have fun. 

============================================================================================
-----------------------
Details
-----------------------
This map has been around a long time, it's a classic. There has been some minor change to it in the latest versions of svencoop, but the layout is the same. The sc3.0/2.1 version of the map is slightly different than the sc4.6/4.5 version, the rcw will work on both but is untested on the old RCbots/mod versions (sc2.1 & older). This rcw has been edited for the new versions (sc4.6/4.7).

I originally started modifying this rcw a long time ago on sc2.1, to many changes to list them all. I recently reworked some areas to make it work better with the newest version of RCbot & sc4.6. It should work well for sc4.5 & sc4.7, hopefully.

RCbots can navigate the whole map with player help, in a couple places. They will use all but one shortcut (spawn room).

There are a couple issues/problems to be aware of. There is a shortcut through the floor in the spawn room that can be opened latter by players. I tried to get bots going through it without jams at a short ladder, 1 or 2 bots would work fine, but if a third arrived at the same time, bad jams started to occur. I tried several waypoint configs at the ladder, but nothing so far has prevented it from happening. So this shortcut path is open, bots won't use it except by accident if they fall in the hole. It wasn't saving much time for the bots anyhow.

In a room under the subway train, there are 2 metal boxes the bots don't see as breakable blocking thier path. You need to break the boxes for them to continue on, they won't do it. 

When you get to the room with the health/HEV stations (past big fans), bots will crouch there for a player to human tower/jump to ladder. The player can go up ladder to open a new shortcut that bots will then use. I made the ladder one way down for the bots, to prevent jam ups on the ladder. There are a lot of baddies up there, but you can retreat to the health/HEV stations.

At the big fan, I got the bots doing the lower jumps fairly well with a zig-zag pattern. For the upper fan jumps, I'm using a straight pattern, it doesn't work as well, but they can make it into the room at the other side & press the button there. This button opens an underwater door further on in the map. Until this button gets pressed, bots will travel between this area & the health/HEV stations room, using the long ladder both ways (lower fan room). Opening the health/HEV stations shortcut will help get more bots to the upper fan room button, faster.

I used a non-standard ladder config in a couple places, seems to work better for sc4.6. I'm not sure how it will work with other RCbot/SC versions. The best example is at the top of short ladder at the broken elevator, it's an extra ladder waypoint. In sc4.6, bots do a funny thing here, they leap from the top of the short ladder to half way up the other ladder, it works pretty good in sc4.6.

[REV2 changes for sc4.6 & sc3.0] 
Did wpt/path/flag edits in the elevator area, mostly to help bots get down short ladder there. They may still bunch up here when they all come at once, but sould sort themselves out faster. Once they spread out some, they should navigate this area easily now.

At the upper fan shaft, added a few new wpts to help bots get across the shaft faster (bots were falling off shaft a lot in sc3.0). The changes have improved the success rate of the upper fan jumps too. bots still do better here in sc4.6 than sc3.0, but both versions of bots/mods work better than with the previous rcw.

Did a few path edits & wpt/flag edits for better bot nav and prevent a bot jam, in one case.

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

For sc4.6 you need this dll:
Forum Page: http://rcbot.bots-united.com/forums/index.php?s=1b30430041c7cf10fef0247442f64eb2&showtopic=1664
Download link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC46_debug.zip

For sc4.5 you need this dll:
Forum Page: http://rcbot.bots-united.com/forums/index.php?s=d63f0dc03b1eae5639137c67f3934bf7&showtopic=1479&st=40
Download link: http://rcbot.bots-united.com/downloads/rcbot_mm_SC45_v25.zip

For sc3.0 you need this dll: 
rcbot_beta.zip (only use for sc3.0 or sc2.1, will not work for sc4.5, sc4.6, or newer)
The filebase page: http://filebase.bots-united.com/index.php?act=view&id=205
Download link: http://filebase.bots-united.com/index.php?act=download&id=205

Or you can use w00t123guy's rcbot install file, which comes with everything you need in one neat package, currently for sc4.5, I believe. I don't have a link for it, but you can try searching for w00tguy123-bot-pack-v4-.rar , you will need to replace the rcbot_mm.dll with the correct one for sc4.6, if you want the latest. If you can't find w00tguy123's original package, you can try w00tguy123-bot-pack 4[1].6 WORKING.rar, repacked for sc4.6, check the svencoop.com message forums for the url.

SC4.7 will be out soon, the rcbot_mm_SC46_debug.zip may work for it, or it may not? 

Have fun,
madmax2
