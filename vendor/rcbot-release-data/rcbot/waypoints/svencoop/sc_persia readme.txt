===============================================================================
RCbot Waypoint (Release2) by madmax2 for the Svencoop v4.8(v4.7) map sc_persia 
===============================================================================

Credits to Cheeseh for createing RCbot

http://rcbot.bots-united.com/forums/index.php

UPDATED rcw (1-23-14), the whole map is waypointed. Bots can run the whole map from beginning to end with player help. The main reason for this update was to fix problems that appeared in sc4.8. I have also tested it in sc4.7, and it works good in sc4.7 too. see details below...

Map Author: Skacky

Map is included with sc4.8 & sc4.7/4.6/4.5 

Recommended number of bots/players: 2 to 4 (2 bots minimum, for a good time)
sc4.8: Recommend 3 bots for one player

IMPORTANT: METAMOD-P is RECOMMENDED to run RCbot on this map (sc4.6/4.7...). the standard metamod may not work properly, certain events may not occur, which may prevent you from triggering the map end/change or may cause a crash. I recommend metamod-p v1.19p32 (for sc4.7/4.8 & newer metamod-p v1.21p37 is recommended). Most all newer maps for svencoop (4.0,4.5,4.6...) require metamod-p over the standard metamod, for plugins such as RCbot.

--------------------------------------------------------------------------------------------
Waypoint Installation:
Place the rcw in your \rcbot\waypoints\SvenCoop folder. 

Normally I recommend setting "config update_ladder_time 0.2" in the bot_config.ini in your rcbot folder. There is only one rope/ladder in this map!

I assume if you are reading this, that you probably already have rcbot installed. But for anyone who doesn't, see the RCbot Installation section at the bottom....

BTW, you don't have to read all this, just install the waypoint and start shooting, yee ha, & have fun. 
============================================================================================
-----------------------
Details/Notes/problems
-----------------------
H-ladder = horizontal ladder or FENCE
First shortcut = Radio Post door (tank)
Last Shortcut = Fortress door
Gate = archway door
HT = Human Tower

Primary Reason for Release2: 
In sc4.8 bots were unable to make it across the first 2 critical jumps with any reliability. Making them unable to assist the player with opening the first shortcut door. At the H-ladder, bots were mostly falling when attempting to just get onto the H-ladder, even without enemies or other bots nearby. This made them useless in opening the last shortcut.

I modified/adjusted the rcw in sc4.8-steam for sc4.8steam, with the rcbot dll from rcbot_mm_SC48_grapple_upd2.zip. I spent a ton of time on the 3 critical problems for this sven-coop version. The funny thing is, after extensive testing, I think the rcw actually works slightly better in sc4.8-NOSTEAM! And it works much better in sc4.7 steam and NOSTEAM! But for sc4.8-steam, the map is much more playable with this rcw, than the first rcw release.

The rcw was also tested with rcbot_mm_SC48_release2.zip, rcbot_mm_sc47_3.7z, & RCBot1_SC47_release_dll.zip

Release2 Changes/Results (partial list):

Plank/HT Jump (1st critical jump): Changed the approach to the plank so bots jump to plank from the side, then hit the wall, both plank wpts (HT) were moved for this, as well as the mid-air jump wpt. In sc4.7, i would say the bots are doing the same or better than the first released rcw. In sc4.8, success may be a little bit lower. In both critical jump locations, there are periods of good success and periods of failure, it comes and goes. In sc4.7 success is much more constant... Unlike Release1 rcw, 3 bots arriving at the plank at the same time doe's not work well, 2 bots arriving nearly at the same time works good. It works the best here when the 1st bot has space from other bots to position itself on the HT wpt, then one other bot comes, not 2 more bots. But this also depends on the HT crouching bot getting in just the perfect position too, which doe's not always happen, so sometimes they still stack up in a line. breaking the pattern helps here, by boosting bots, see tips below... btw, I recommend 3 bots for sc4.8, mainly to keep a constant flow of bots to the plank/HT, it felt right when i play tested, but i never tested it with just 2 bots, so maybe that would work better?

Peg Jump to Roof/awening (2nd critical jump): Changed all peg wpts to jump wpts, changed & moved the HT wpt to a jump wpt, and moved the mid-air wpts. Added a wpt to the 2nd rope too. Basicly, reworked both critical jumping areas. In sc4.7 steam and NOSTEAM, bots can make it better than 80% of the time. In sc4.8, this can happen too, but it's more inconsistant, hot & cold. What I mean is, bots seem to learn the jumps, so the more they get a chance to attempt it, and when they succeed a couple times, they seem to get better at it and succeed more. See Tips in this section...

I should say the way the bots make this jump now. They almost always will be successful if you see them moving up the pegs rapidly, kinda skipping up them after taking a short run at them. If they catch to much on the pegs or railing there, they likey won't make it, but sometimes they will hop up them after tripping, and still make it to the roof or rope. Other failures that happen include, short jumping from or not jumping from top peg, if they crouch on any peg they will fall, and sometimes falling between the railing & first peg. I'm thinking I may be able to improve the peg jump further now, but it's ok as is and works very well in sc4.7.

H-ladder/Fence: Almost a complete rework of wpts/paths on and around the H-ladder (rope edits too). The rcw works much better for sc4.8 than the first release (even better in sc4.7). The big difference between sc4.8-steam and sc4.7 (and sc4.8-NOSTAEM), is bots don't grip the H-ladder as well & tend to fall more. Once the enemies are cleared out and the bots spread out some, most falling will stop, and they will cross it easily and fairly quickly. Initially, some bots will fall due to bot to bot collisions, and some will jump over the wall & fall for the same reason (or seeing an enemy). this will stop when bots are spread out more and arrive here one at a time. most falling is due to enemies or collisions. there is little or no falling due to collisions, once bots are firmly on the H-ladder, they can bump into each other without falling. once enemies are cleared from the area, bots can make it across nearly 100% of the time.

Other Changes: Added a number of wpts around the map to increase bot movements to cover areas, such as bots will circle around the tank when under attack.

A couple small glitches that sometimes happen... Sometimes bots will open the gate(archway) before opening the first shortcut door (tank). There is nothing more i can do about this, cause there is only one wpt in the room with that button, and it is for the door. Bots will often still open the shortcut door (tank), but it may take a while, you may have to do it yourself when this happens... Bots are sometimes slow to open the last shortcut door(fortress door) after the H-ladder, but they usually will do it. It's not a button pressing issue, they just don't go to the objective wpt there right away! It may depend on the SCmod/rcbot versions, or steam/nosteam you are using?

TIPS:
Plank/HT Jump: There is no need to stand or jump to boost bots, i've easily boosted 3 in a row by crouching in just the right spot on the end of the plank. The sweet spot is centered about 1/5th the from the end of the plank. I'll post an image link in the forum topic. To make the HT/jump yourself, get on a crouched bot and do a running jump then crouch, you don't need to wait for them to boost/stand up. also, if bots seem locked in a pattern of lining up on the plank, arriving 3 at a time, or the crouched HT bot jumps just before another bot arrives, it helps to break the patten up by boosting bots... see BOOSTING BOTS

Peg Jump to Roof/awening: the easiest way to make the jump from the top peg, is to stand on it the take a running jump straight across to the roof, DO NOT CROUCH, and forget the rope there, it is hard to jump to. In sc4.7, bots should be making the peg jump much better than 50% of the time. In sc4.8-steam, it won't be that good at first, they will need to make it a couple times, then they should get better at it. If bots don't seem to get better at the jumps here, see next part...

Suggestions for critical jumps [BOOSTING BOTS]: This is mostly for sc4.8, sc4.7 bots should have little or no problems at the 2 critical jumps. in sc4.7 they were making it across on their own (unassisted) at a regular pace and helping me open the first shortcut(tank). That said, if bots don't seem to be making it across the jumps to the roof/awening much (only 1 or 2 out of 10 tries), it seems to help to boost a few bots at the plank so they get more chances to learn it. What i do is, after the enemies are cleared from the plank/tank area, i sort of alternate boosting bots then going myself until the peg jump area is cleared of enemies. Then with 3 bots in game, i boost the odd bot, and i let 2 bots boost themselves at the plank so they learn that. after I have seen the bots make the peg jump to the roof 2 or 3 times, then i may go myself jumping from the odd bot. after i die, i repeat this, watching to be sure at least 1 or 2 bots made the peg jump first. If bots still seem to be having problems, it sometimes helps to kick the bots and add 3 new ones, but they may have to learn the jumps again. It almost seems some model/classes have more trouble with the jumps. Lighter springy bots seem to do better (ie: female assasin bot).

-----------------------
Release1 info (sc4.6):
-----------------------
The bots can do everything in this map, including ending the map. But they don't always do so immediately, the way I have it waypointed now. They will press all the buttons, eventually. I could make them press them faster, but I am giving the player a chance to do it. 

Friendly NPC's sometimes get in the way and block the bots, especially in the spawn area. I've also seen bots stuck to NPC's. So once all enemies are killed in the first area, I recommend killing all the friendly NPC's there too, bots won't kill a frindly NPC.

There were 3 problem areas to waypoint, the human tower jump from the plank/board to the first balcony, the jump from the peg/ladder to the roof/rope, and the horizontal fence/ladder. 

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

Revision tracking - sc_persia_rev4d.rcw