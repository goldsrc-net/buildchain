============================================================================================
RCbot Updated Waypoints (Release2) by madmax2 for the Svencoop map series sc_royals
============================================================================================

RCbot Forums: http://rcbot.bots-united.com/forums/index.php

Includes Newly Updated/modified rcw's for Svencoop v4.8/4.7

Credit to Cheeseh for createing RCbot and the original rcw's for sc_royals 1, 2, & 4, from the rcbot_sc_waypoints.zip pack

The sc_royals3 rcw is new (was new for sc4.6, now newly modified).

The main purpose for the updates was problems bots were having at jumps and ladders/ropes, mostly on royals2 in sc4.8steam, but also sc4.7steam. But I did other fixes & improvements to all the rcws too. There are 2 rcws for royals2, one for Steam & one for NoSteam. Also, for sc4.8, bots can use the BARNICLE/GRAPPLE in royals2, but you may not want them to, see royals2 details below for why...

These rcws may also work for sc4.6/4.5, but have not been tested on those versions. Don't use the new royals4 rcw on sc4.6, bots will get trapped at the teleporter. The teleporter doesn't work on sc4.6 (map bug).

Feedback can be made in this forum thread:

http://rcbot.bots-united.com/forums/index.php?showtopic=1681

Map Author: LemonSoda

Map series is included in Svencoop sc4.8, 4.7, 4.6 & 4.5

Recommended number of bots/player (single player): For sc_royals1 & sc_royals3, 2 bots. For sc_royals2 & sc_royals4, 2 to 4 bots. All maps, No more than 3 bots, especially on royals1. 3 is optimum for royals2 now.

IMPORTANT: METAMOD-P is REQUIRED to run RCbot on these maps (sc4.7/4.8...). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.21p37 for sc4.7/4.8 & newer. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot. (I verified, royals 2 & 3 will not work correctly with the standard metamod, & I suspect royals 4 won't work right either)

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw's in your \rcbot\waypoints\SvenCoop folder. 

** I highly recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder, for these maps. I haven't checked them at other settings yet.

BTW, you don't have to read all this, just install the waypoints and start shooting, yee ha, & have fun. 
--------------------------------------------------------------------------------------------
For newer Svencoop versions you need one of these rcbot dll's and metamod-p (see rcbot forums or search internet for metamod-p, metamod-p v1.21p37 recommended)

For sc4.8... http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip (Latest)
Or the sc4.8 rcbot release2 from the rcbot website will work, but is not recommended for sc_royals2

For sc4.7... http://rcbot.bots-united.com/downloads/rcbot_mm_sc47_3.7z (Latest for sc4.7)
Or the rcbot feb. 2013 build will work work for this map too...

For sc4.6... http://rcbot.bots-united.com/downloads/rcbot_mm_SC46_debug.zip

For sc4.5... http://rcbot.bots-united.com/downloads/rcbot_mm_SC45_v25.zip
============================================================================================
------------------------------------------------
Details/Notes (Release2 Updates, sc4.8/4.7)
------------------------------------------------
Originally I fixed a number of things on these maps that were preventing bots from reaching the end. Due to the map changes on sc4.6 & sc4.5, the older rcw's had a number of paths through walls and floors, etc. I repaired these areas and in some cases made new routes/paths for the bots to follow. 

Bots can do most things, they will press all buttons (sometimes quickly, sometimes slowly), There is one shortcut that players will need to activate for the bots, but it's an optional shortcut (royals2). Be sure to look for shortcuts to open, bots can open most on thier own, but not always immediately.

There have been a lot of changes to the rcw's for sc4.8/4.7, mostly for performance, but also a few new things the bots do that they did not do before. For all maps, I added a number of wpts in & around the spawn area (rooftops too) to prevent the possibility of stuck bots there, even at the stairs in royals1 if barney blocks the opening there. For royals 1, 2, & 3, I reworked the lower spawn platform wpts, so bots will suicide if barney gets in there and they get stuck on him! see map details below...

-----------------------------------------------------------------------------------
Updated Map & RCW information for sc4.8/4.7 (not tested in sc4.6/4.5):
-----------------------------------------------------------------------------------
(Just the most notable changes, not eveything)

I did most testing and edited the rcw's to work best with these RCbot dll's... I recommend using ... 

For sc4.8 ... rcbot_mm_SC48_grapple_upd2.zip (Latest)
For sc4.7 ... rcbot_mm_sc47_3.7z (Latest for sc4.7)

Royals1 [Updated] (1 to 3 bots, 1 or 2 is optimum until past vent) - at end of first vent the bots will not shoot/break the boxes there, players must do this. I couldn't get the bots to do it, because they are PUSHABLE! BOTS can PUSH the boxes out of the way at the end of the vent now, but they usually are slow at it! They do best with 1 bot there, 2 bots is ok, 3 slows them down due to collisions and lack of room to move. But they will no longer be trapped here because of those darn boxes... :)

Bots will press all buttons now, just not always fast. A player & bots can activate the eye scanners (I have seen bots do this on thier own now, but it takes a while). In the room with the female assasins, in sc4.8 bots were going for the battery to much and not getting the health behind the boxes, they will ignor the battery now. After a couple doors have been opened, bots can finish the map on thier own. They will activate a map change at the end. Most all the rcw changes were in first half of the map.
-----------------------------------------------------------------------------------
Royals2 [Updated](3 bots optimum) 
-------
IMPORTANT, I have included 2 rcw's for this map, 1 for STEAM(default rcw) and 1 for NOSTEAM (NS). They have both been UPDATED and tested on sc4.8 and sc4.7. Bots can do everything well or well enough in both. For STEAM sc4.8/4.7, use the default rcw, it will work the best. For NOSTEAM sc4.8/4.7, try the alternate rcw first(sc_royals2_NS.rcw), it should work the best, but my NS version is very old, so if your's is new as of the last few years, then the default rcw may work better? The main difference between the 2 rcws is first at the blooders pool jumps & ladders, and secondly at the short ladder on the box to the last vent (next to last pyramid button past the human tower). Bots won't be able to make it through the blooders pool if you use the wrong rcw. In either case, at that ladder to the vent, bots have some trouble, but will do much better if you use the correct rcw (but, they should be able to make it up the ladder even if you use the wrong rcw).

Note, all pyramid buttons must be found & activated to proceed to the next map. Bots will press all the pyramid buttons in this map now, but usually not first time. bots can run the whole map now, from beginning to end. Bots are now waypointed to trigger the map change.

----------
* Summary of Changes to royals2:

* The STEAM rcw has a few more fixes added to it, and more wpts for movement in the well area, which is fun to see bots use the whole area there now...

* Spawn area, additional wpts/paths, and reworked lower platform so bots will suicide if they get stuck to barney there. Generally lots of wpt/path tweaks & fixes around the map too. 

* added wpts to ceiling in first room with barnacles, so bots stuck to ceiling will get free or suicide quickly. Other bots would try to heal them while stuck to the ceiling. Seems this issue was fixed in sc4.7 but came back in sc4.8(steam)?

* Bots randomly open the ammo resupply door in the hallway now.

* Changes to 2 of the 3 objective wpts on pyramid buttons, they should press them better & faster now.

* Wpt tweaks at the cavern jumps & rope for sc4.8.

* Wpt tweaks at ladder & tunnel to the barnacle gun, but bots won't likey go get the barnacle gun.

* Reworked short ladder before blooders pool, bots still hang at top, but can free themselves now in 15 to 30 seconds, and sometimes go right up it. Had to wpt the ladder differently for STEAM, bots were getting stuck at the top, or slipping back down the ladder more than in NOSTEAM. Fixed bots hanging at edge of shortcut door around the pool, too.

* Reworked parts of blooders pool area, bots can get out of water better and can make multiple attempts now. The jump from the wedge to the ladder and the ladder wpts have been changed, and are different with the 2 rcws. Once up the ladder a bot can make it the rest of the way 90% of the time, so long as another bot doe's not interfere/collide. Note, one bot coming to the blooders pool at a time works best, to avoid collisions and so as not to stir up the blooders to much. Single bots can make the jumps to the bottom of the ladder quite well now, climbing it is where they have the most trouble, but they do that fairly good too if you use the correct rcw. With the default/stm rcw, they my bounce off the bottom of the ladder some, but usually jump on it ok and climb up. They can step back and jump on it too. With the NS rcw, they tend to either slide on at the bottom and go right up, or they may stick for 10 seconds, then step back & try again. It's fun to watch, but the more the blooders are stirred up by multiple players/bots, the harder it is for the bots to make the jumps to the ladder, but they can still do it.

* Reworked the Human Tower (HT) and jump to the platform. Bots make the HT jump much better now, but sometimes fall down & spin in place looking at the mid-air jump wpt they missed. They do this now because I had to lower the jump wpt so they could make it in sc4.8stm. I added some wpt fixes for this, and they can get out of it most of the time on thier own in sc4.8stm. If you need to, the best way to break them out of it is, to jump down from the platform and stand on top of them, this will get them out of the stuck/spin. Sometimes shooting them works, too.

* Fixed a problem where a bot would get stuck in the mummy pit after all mummies were gone. I think this was new with sc4.8. It is the same problem as at the HT, bots trying to get back to a mid-air wpt they can't reach anymore. reworked the wpts in the room above the mummy pit to fix it.

* Barnacle/Grapple wpts have been added at the HT location.

* Reworked the ladder wpts into the vent to the surface, just past the upper HT platform. The 2 rcws are different at this ladder. Bots are no longer forced up the sticky ladder, this worked much better for sc4.8 & STEAM, otherwise they were jamming up bad there. It is a looser wpt config than before, so multiple bots won't be stuck there on the box, but now bots will jump back from the ladder when they hang, may run around a bit, and then will try again. The forced ladder path still works best for my old NOSTEAM install.

* I added wpts so bots could end the map, sometimes it occurs quicky, but usually it takes a while. Bots will continue to jump down hole and loop thru the map, giving the player time to trigger the map change.

------- 
BARNICLE/GRAPPLE GUN: This will only work with sc4.8 with the rcbot dll from this link (newest dll at this time), it won't work correctly with the sc4.8 Release2 dll from the RCbot website.

http://rcbot.bots-united.com/downloads/rcbot_mm_SC48_grapple_upd2.zip

With all other older RCbot dll's or Sven-Coop versions, bots will just ignor the grapple wpts with or without a barnacle gun. The exception is the RCbot Release2 dll for sc4.8, they ignor the grapple wpt when they don't have the barnacle gun, but when they have it they will try to run thru the grapple wpt and off the platform, instead of going to the Human Tower (HT) wpt at the end of the platform. So don't don't give them the barnacle gun at all when using this dll. Also, occasionally bots hesitate and look at the grapple wpt, when they reach the end of the plank board.

There are wpts to the barnacle gun, and bots could get it, but it is very unlikely because I removed the objective tag there. So if you want to see them use it, you need to get it and give it to a bot. But I recommend you don't do this on first time thru the map, because IT COULD RUIN YOUR GAME. On this map one bot can do it almost perfectly, but with other bots & enemies in the area they may miss the grapple point, get attached permanently to another bot (which is hilariously funny), or fall down and continuously firing the grapple from the wrong position. Currently bots won't reset from these situations with the grapple. I just included the grapple wpts for when cheeseh updates the bot code to fix this issue, then it will work on this map.

----------
Royals2 [Edited Original Comments, sc4.6] 

bots can make it across the floating stones jumping puzzle almost perfectly now, but only after certian stones have been broken. it seems bots get drawn off path for some reason, until these stones are gone, then they make it almost every time! They can do this puzzle without player help, but will fall a lot until some stones are gone. a player can help the bots here by knocking off stones (but you can't break them with a weapon, you must touch them). 

at the short ladder that leads to the fish (itchy's/blooders pool) pool area, bots will hang up at the top, they will usually get free on thier own after a bit of bouncing, or a bot will push them out from behind. I felt this was better than getting jammed up/stuck at the bottom of the ladder in the vent, like they were doing before. I worked this ladder a lot to get them to do this good, and had to change from conventional ladder wpts to a very unconventional setup here. The good thing is, permanent ladder jams have been fixed here and no longer occur.

at the other side, bots can make the human tower (HT) jump to the upper platform, but it will often take a lot of attempts. I think the bots are going off path (avoidance code?) a lot more in sc4.6 & the newest bot, when doing human towers. they miss the crouched bot to the side or land on their shoulder, not getting the best possible boost. but be patient, they will do it, or you can boost some bots yourself. you can use them to jump up there too, but aim for the front of the platform with a jump-crouch, this is easier for players to do. there is a barnacle gun in the map too. once up on the platform, bots can make it to the surface on thier own, after the enemies are killed off. The optimum number of bots in the platform/HT area is 2 to 3 now, any more and thier ability to make the jump to the platform seems to degrade, due to collisions.

-----------------------------------------------------------------------------------
Royals3 [Original Comments] - Map was fully re-waypointed, there were just to many map changes to fix the old rcw. I was amazed the bots could run some areas of the map with waypoints way up in the air! There were wpt/paths in walls and objects, too. bots can run the whole map now, and will activate the big switch at the end. be sure, as mentioned above, you are using metamod-p, or some of the great scripted events in this map won't trigger properly and you won't be able to end the map. 

[Updates] (2 bots optimum) - Bots will randomly end the map now, usually not fast. Mostly spawn area tweaks/fixes, such as bots stuck on barney at the platform, etc. Bots will move smoother thru the narrow passage to the caves.
-----------------------------------------------------------------------------------
Royals4 [Original Comments] - most of this rcw was working ok, except one area about half way through where the path went through a wall (pyramid entrance?) and over a collapsed floor (probably a map change). I repaired this area so bots can get through without getting stuck. also added a few waypoints for stuck bots in various places and fixed a few doorways for smoother navigation. added a new down path off pyramid/ledge to reduce some looping there. a few other tweaks here & there. bots can do the whole map on thier own, except the puzzle of course.

[Updates] (2 to 3 bots optimum, until final bosses) - Added a few wpts in spawn area and for smoother navigation, bots can get the nades for the m16 and do use them now. A new path for bots in the first area, just a fun thing to wpt. Some tweaking on the pyramid. Bots will use the HEV charger in the pyramid on occasion. Added some wpt fixes in the puzzle room, mainly for bots stuck to ceiling after being picked up by a barnacle. If they don't get free, they should suicide now. Some new wpts/paths in the final areas.

Have fun,
madmax2
