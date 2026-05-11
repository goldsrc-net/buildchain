==========================================================================================
RCbot Updated sc_activist2 Waypoint(rev2), by madmax2, for Svencoop v4.7, 4.6(4.5) & 3.0
==========================================================================================

Credit to Cheeseh for createing RCbot... :)

Credit to the original waypointer too... the original rcw, was from w00tguy's waypoint motherload pack, thanks w00tguy... :)

http://rcbot.bots-united.com/forums/index.php

Map Author: Frel

Maps are included with sc4.7 & sc4.6/4.5 
It's also included in the svencoop30content pack @ http://www.svencoop.com/ (but it's a different bsp from the 4.x versions)

Recommended number of bots/players: 2 to 3 (1 to 2 bots recommended, for a good time. More than 2 bots will cause longer delays at the lift, 2 bots works best there). I played thru the whole map, with 2 bots, on sc4.7 & sc3.0, and the rcw works well with both.

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.5/4.6/4.7). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32. Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

For sc3.0, you can use the standard rcbot dll v1.441 (rcbot_beta.zip), no metamod required... The rcw was tested in sc3.0 too, and works good...

[rev2] I made a minor change at the power generator buttons, to help bots press them a little better, thats the only difference... * There is new info (*) below, in the lift sections *

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw's in your \rcbot\waypoints\SvenCoop folder. 

Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. 

I assume if you are reading this, that you probably allready have rcbot installed. But for anyone who doesn't, see the sc_activist1 readme.txt for install information....
============================================================================================
-----------------------
Details/Notes/problems
-----------------------
The rcw was tested on sc4.6 & sc4.7 with both dll's, from rcbot_mm_SC46_debug.zip and RCBot1_SC47_release_dll.zip. For sc 3.0, I used the rcbotbeta dll from the filebase. Unlike sc_activist(1), there are no class/enemy/shooting problems in sc4.7. So this map if fully playable in sc4.7, as well as the other versions. (untested in sc4.5, but it should work)

There is a spawn area problem in this map, where bots or players can get stuck in two corner spawns & have to suicide. It only happens on the newer sc4.x versions. I haven't seen it in sc3.0, which is a different bsp. I added jump wpts to the corners, and it helps bots avoid this problem sometimes, but not always. But when stuck, the jump wpts helps them suicide much quicker, within about 10 seconds.

I tried hard to resolve the problem at the lift, but bots will not press the lift buttons at the first lift. It's not fixable with waypointing methods in these versions of rcbot & SC. The only thing I could do was reduce lift jams caused by the bots, improve thier ability to get out from under the lift, and make it easier to help bots up the lift. Also, I fixed it so bots recognize that the lift is not available at the beginning of the map round, and they won't try to run thru the closed security door to the lift.

All objectives in this rcw are flagged for the bots now. Bots can do all objectives in this map, but not so fast that players won't get the chance to do them too. Given enough time, bots will end the map, but because of the lift issue, they cannot complete the map without a human player to help them up the lift.

----------
Lift Tips
----------
2 bots work well (sc4.x), you can wait for both bots, or if one bot is in center of lift looking up, thats a good time to go with one bot, press the lift button and jump on. If 2 bots are there, they may be bouncing around a bit more, watch thier pattern & wait a few seconds until they settle down towards the center-back of the lift shaft, then press the button & jump on. Try to stand on the front middle of the lift, to block any bot that trys to get off. 

* Note: It is much easier to get one bot to stay on the lift as it rises, especially in sc3.0. Again, when one bot is in center of lift looking up, that is the best time to send the lift up.

Once at the top, after bots are clear off the lift, send the lift back to the bottom. If a bot jumped off the lift, or one is at the bottom of the lift shaft, don't worry about it, just send the lift back down, and continue on with one bot. By the time you die & respawn, any bots at the lift should be on the lift waiting for you (that is if you remember to send the lift down). The lift buttons in sc4.x take a few seconds to reset after the lift has moved. By the time a bot gets to the ladder, you will be able to send the lift down. This is not an issue in sc3.0, no button reset delay in 3.0.

If you decide to back track to the lift to bring bots up for more help, you can do that from the top lift button, it's not nessesary to ride the lift with them, usually one bot will stay on it.

If you forgot to lower the lift, & one or 2 bots are under it, just lower it on them, and they will crouch and sort themselves out quickly. This is the reason I recommend no more than 2 bots, 3 bots under the lift take significantly longer to get clear of the lift, though they can do it.

-------------
Lift details
-------------
The bots work a little better at the lift with the newer versions (4.x) of sven, with this rcw, than on sc3.0. In sc3.0, it's a little bit harder to keep them on the lift. I tried to balance it out with the different versions, but my primary goal was to make it easier to get the bots up the lift in the new sven versions, if the button issue could not be fixed. The lift moves slower in sc3.0, so that could be part of the reason too.

The wpts in this area were completely changed, and probably ended up more complicated than they need to be, but that was because I was trying to get them to press buttons. In the newer versions of SC, the lift was jamming a lot with the original rcw, because the up path was against the back of the lift shaft wall. Bots running against the wall caused bad jams. Now the up path is in 2 places, one from the lift button, and one from the bottom/center of the lift, to the top/center of the lift. This virtually eliminated lift jams.

The other problem here, was bots getting stuck under the lift for long periods of time. The lift in the new sc4.x is non-killing/crushing. If bots stay standing under it, it can never be used by the player. So to speed up the bots getting out from under the lift, in all versions, and to keep them on the lift to go up it, was a balance compromise. The last change here, was to crouch tag the bottom lift wpt, this & another crouch wpt, makes them crouch more when under the lift. When the lift drops down to crouch level, all bots under the lift will get out and lift will completely lower. Any bot that remains under the lift trying to go up the up path will suicide quickly. This also prevents more bots from getting under the lift, because of the seperate up path from the lift button. The lift path from the center of the lift, is needed to help keep them on the lift to go up it. There is also a "stay close to" tag on the red lift wpt which helps pull them from under the lift. Lets just say I spent a ton of time on this area, enough said about that....

* New SC3.0 Note: 
In the last few test games, I noticed stuck bots sometimes causeing the lift to jam at the bottom. I did double checked this, and it's only in sc3.0. It's not caused by the crouch wpt on the lift, with a normal wpt it happens just as much, so I left it with a crouch wpt, since it seems better for sc4.x. You can try hitting them with crowbar & pressing the lift button again. Most of the time the bot gets free on its own or when another bot bumps into it, or it suicides...

--------------------------
Other rcw details/changes (SPOILER WARNING: read after playing at least once, or if you get stuck)
--------------------------
Reworked the first ladder wpts, near 2nd lift. Bots get up it nearly flawlessly now. Now the only time they get hung up at the bottom, is when 2 or more bots arrive at the same time. But they usually get free quickly when this happens, which is hardly ever with 2 bots. I have found that sometimes non-standard wpt configs at some ladders work better than the text book way of a ladder wpt at both top & bottom of ladder. This one only has a ladder wpt at the top, which also has a jump tag on it! I also reworked the bottom approach wpts/paths, etc. They may not shoot all the panels here immediately, to open the next door, but they will if the player doesn't do it first...

Reworked the wpts in the broken lift. Bots rarely press the broken lift button now, which I kinda don't like, cause it was funny watching them try to use it. But, this was unavoidable in the new sc4.x. They were too focused on pressing it, even after I removed the lift button wpt! So, I also reworked the jumps up the boxes, and added some wpts for any stuck bots behind the boxes, so bots go up these fairly well in all SC versions now. Also I changed the wpts/pathing on top of this lift & used jump/crouch instead of ladder wpts into the vent.

Added a red lift/button wpt to the glass door/shortcut around the broken lift. Bots open it quickly now, in sc4.x, most of the time. There are a couple slight map bugs at this door. After going thru the vent, and enemies run into the open, if the door is still closed, bots can see the enemies & try to attack them thru the door. If enemies are up against the door they can be damaged/killed too. Also, bots can & will cheat here, by pressing the door button thru the wall, & opening the door. So it kinda offsets the door bug some, which is okay, i guess. [Update] I changed the wpts/paths outside this door, moving bots farther from the door, and it happens far less now, but still occurs on occasion. This may not even happen in sc3.0, it seems to be sc4.x only? Though the button can be pressed thru the wall in 3.0 too.

All objectives have been EOL/objective flagged, so bots can do all of them now. I Nocliped objective wpts into several of the problem buttons, for better button pressing.

Moved wpt/path further away from HEV/Health chargers, bots were getting stuck on them too much in sc3.0 and 4.x to a lesser degree. They may still use them occasionally, but hopefully not much. This has minimized the problem.

Added a few wpts for stuck bots, and many path edits throughout the map.

Have fun,
madmax2

Rev tracking - sc_activist2_fix2b.rcw