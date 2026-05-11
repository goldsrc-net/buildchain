===========================================================================================
RCbot modified/updated Waypoint (REV3) by madmax2 for the Svencoop v4.8(4.7) map Shattered
===========================================================================================
(original waypoint from rcbot_beta_full.zip from the filebase, Cheeseh's rcw.. 7878 bytes)

Credits to Cheeseh for createing RCbot & the original Shattered Waypoint, thanks man...

http://rcbot.bots-united.com/forums/index.php

Feedback can be made in this forum thread:
http://rcbot.bots-united.com/forums/index.php?s=178bd34407286689cd72571f785923eb&showtopic=34

Map Author: Remy LeBeau

Map is included with sc4.8/4.7/4.6 ...

[REV3 rcw]: The main reason for this update, was bots were unable to make it through a few areas of the map with the latest bots and sc4.8. They can now play the map again, almost as well as before... The rcw was edited to work best for sc4.8 steam or nosteam. The rcw was tested in sc4.7, and it works ok, but I'm not sure if this rcw or the Rev2 rcw works better for sc4.7? See details section below for the problems & changes....

It hasn't been tested with any older versions, sc4.6 & older. Many of the recent edits to the rcw may cause problems for older versions of the bots/mods? It likely won't work well for sc3.0 or 2.1, use Rev2 for that...

Recommended number of bots/players: 3 or 4 (no more than 3 bots in first half of map, see details)
(optional: you may want to add an extra bot when you reach the big fans)

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.6/4.7...). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32 (for sc4.7/4.8 & newer metamod-p v1.21p37 is recommended). Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

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
This map has been around a long time, it's a classic. There has been some minor change to it in the latest versions of svencoop, but the layout is the same. 

I originally started modifying this rcw a long time ago on sc2.1, to many changes to list them all. I recently reworked some areas to make it work better with the newest version of RCbot & sc4.8. 

RCbots can navigate the whole map with player help, in a couple places. They will use all but one shortcut (spawn room).

I modified/adjusted the rcw in sc4.8steam for sc4.8steam, with the rcbot dll from rcbot_mm_SC48_grapple_upd2.zip. The rcw was also tested with rcbot_mm_SC48_release2.zip, rcbot_mm_sc47_3.7z, & RCBot1_SC47_release_dll.zip. It works well in sc4.7-steam too. It also works ok in sc4.8/4.7 nosteam.
------------------------------
Rev3 Changes/problems (sc4.8):
------------------------------
With sc4.8/rcbot4.8, bots seem to navigate the wpts a bit "loose", making wider swings from the wpts. This tends to cause them some problems making jumps and hitting ladders in tight areas, sometimes requiring some adjustments to the wpts. 

Reworked/adjusted the wpts at these areas:

Spawn room door (one way, exit only, to reduce looping back thru spawn room for medkits)
(bots will open the shortcut door for the spawn room, just a little slower than before)
Elevator short ladder (minor tweaks)
2nd vent (major problems, bottle neck/jams at bottom, still not perfect but works ok)
Train short ladder fixed for sc4.8, bots jump over ladder now, minor tweaks in rooms under train
Lower fan jumps reworked, works about the same as before, good & bad periods of success & failure, it's all in the timing and when they arrive at the fan...
Upper fan/room tweaks
Lower fan room ladder change

Added 2 more objective/EOL wpts/tags, one for bots to open the spawn room shortcut door, and one additional EOL to attract them to the final area faster...
-------------------------------------------
IMPORTANT (mostly for sc4.8), Please Note: 
-------------------------------------------
Much of the ladder problems in sc4.8 with the new bots are caused by two new abilities the bots have. When they drop or throw weapons near the bottom of ladders, bots sometimes block the ladders trying to pick up the weapons, especially HMG's. Yes, bots can use Heavy Machine Guns now, which is very cool. But, this too causes the bots problems at ladders. HMG bots can't jump (on to ladders), and they can't shoot from ladders, it's the same for HMG players. In this map, these issues can cause significant additional problems at the elevator ladders and the 2nd vent ladder. For the most part, the bots can navigate these 2 areas ok, but expect some temporary jams or collisions at these ladders. For this reason, I recommend no more than 3 bots until you reach the underground areas, under the train or near the fans, before adding a 4th bot, if you need it? More bots at these ladders will just make the jams more frequent & worst...

At the bottom of the 2nd vent ladder, it's likely you will see an HMG or other bot appear stuck to the ladder. The best thing to do is nothing, just wait. Collisions with bots here will likely cause another bot stuck at the bottom. Let them sort themselves out & try to go up ladder when no bots are near by. One of 3 things will likely happen, the bot will start climbing in about 30sec or less, the bot will try to abort & back out of the vent in 30 to 60sec (HMG bots sometimes throw away the HMG and exit or jump on the ladder), occasionally the bot may be stuck bad (or restuck by another bot bumping it) and may take 90sec to over 2min to get free (the more bots, the more chance this will happen, it should be rare with 3 or less bots). The jams here usually occur just after the enemies are cleared from the room, multiple bots arrive at the ladder near the same time, and when HMG's are available for bots to pick up. After bots spread out some, they can jump on to the ladder good, but sometimes still miss & stick to it.

TIPS for jams at 2nd vent ladder: First, wait it out, bots usually clear the vent in under 30 to 60sec, on their own. If over a minute, you could try shooting them, but it didn't seem to help much if other bots are blocking their exit? Crowbaring the stuck bot may help sometimes, but I would wait at least 90sec or 2 minutes, cause they usually exit or start climbing at that point, and you might just restick them to the ladder. This won't happen often or at all with just 3 bots. 

Usually non-HMG bots will get in to the 2nd vent first & kill the headcrabs, but rarely a HMG bot will make it up the ladder first, but can't pull the trigger and can block other bots/players for a while. If that happens, try to get in behind the HMG and kill the headcrabs to clear the blockage. Also, occasionally bots will get stacked up on the ladder here, usually because of an HMG bot at the top, but they usually sort out & free themselves in 60sec or less, just wait it out.

Sometimes a bot is blocking because he is trying to pick up an HMG (or other weapon) near the bottom of the ladder, but can't do it. You could pick up the HMG to get bots moving again, then throw it away someplace out of the way. Also, rarely, a bot will block the vent trying to give health to the bot stuck to the ladder, but can't reach him and won't give up. Try to squeeze in there & give health to clear the blockage.

============================================================================================
Old Issues/Problems (but still apply to sc4.8/4.7)(Spoilers Warning):

There are a couple issues/problems to be aware of. There is a shortcut through the floor in the spawn room that can be opened latter by players. I tried to get bots going through it without jams at a short ladder, 1 or 2 bots would work fine, but if a third arrived at the same time, bad jams started to occur. I tried several waypoint configs at the ladder, but nothing so far has prevented it from happening. So this shortcut path is open, bots won't use it except by accident if they fall in the hole. It wasn't saving much time for the bots anyhow.

In a room under the subway train, there are 2 metal boxes the bots don't see as breakable blocking thier path. You need to break the boxes for them to continue on, they won't do it. 

When you get to the room with the health/HEV stations (past big fans), bots will crouch there for a player to human tower/jump to ladder. The player can go up ladder to open a new shortcut that bots will then use. I made the ladder one way down for the bots, to prevent jam ups on the ladder. There are a lot of baddies up there, but you can retreat to the health/HEV stations.

At the big fan, I got the bots doing the lower jumps fairly well with a zig-zag pattern. For the upper fan jumps, I'm using a straight pattern, it doesn't work as well, but they can make it into the room at the other side & press the button there. This button opens an underwater door further on in the map. Until this button gets pressed, bots will travel between this area & the health/HEV stations room, using the long ladder both ways (lower fan room). Opening the health/HEV stations shortcut will help get more bots to the upper fan room button, faster.

I used a non-standard ladder config in a couple places, seems to work better for sc4.6. I'm not sure how it will work with other RCbot/SC versions. The best example is at the top of short ladder at the broken elevator, it's an extra ladder waypoint. In sc4.6, bots do a funny thing here, they leap from the top of the short ladder to half way up the other ladder, it works pretty good in sc4.6.

============================================================================================
RCbot Installation (for newer Svencoop versions (sc4.8, sc4.7, sc4.6, etc.))
----------------------
I'm not going to tell you how to install, but what you need to get started. Basicly you need a rcbot.dll (or rcbot_mm.dll & metamod-p). You also need rcbot_beta_full.zip from the Bots United filebase, it contains all the other supporting files needed to make rcbot work. It also contains installation instructions. See the rcbot website/forums if you need more help.
 
Or you can use w00tguy123's installer, which might be easier for beginners. 
NOTE: you will need to replace the rcbot_mm.dll with the correct one for sc4.8 or sc4.7.

----------------------
Here are some direct links:

rcbot_beta_full.zip (supporting files required to make rcbot work)
The filebase page: http://filebase.bots-united.com/index.php?act=view&id=210
Download link: http://filebase.bots-united.com/index.php?act=download&id=210

Or you can use w00t123guy's rcbot install file, which comes with everything you need in one neat package, originally for sc4.5, I believe. I don't have a link for it, but you can try searching for w00tguy123-bot-pack-v4-.rar. OR use w00tguy123's latest package, w00tguy123-bot-pack 4[1].6 WORKING.rar, which was repacked for sc4.6, here:

http://www.sendspace.com/file/pzsgy3

Discussion here:

http://forums.svencoop.com/showthread.php/39937-RcBot-4-6?s=84432a16b31fbc4e91e154c3399d5be8

----------------------
For newer Svencoop versions you need one of these rcbot dll's and metamod-p (see rcbot forums or search internet for metamod-p, metamod-p v1.21p37 recommended)

You will need one of these dll's, depending on which version of Sven-coop you have:

For sc4.8... http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip
Or the sc4.8 rcbot release2 from the rcbot website will work for this map too...

For sc4.7... http://rcbot.bots-united.com/downloads/rcbot_mm_sc47_3.7z
Or the rcbot feb. 2013 build will work work for this map too...

For sc4.6... http://rcbot.bots-united.com/downloads/rcbot_mm_SC46_debug.zip

For sc4.5... http://rcbot.bots-united.com/downloads/rcbot_mm_SC45_v25.zip

Have fun,
madmax2

Revision tracking - shatteredfix4e.rcw