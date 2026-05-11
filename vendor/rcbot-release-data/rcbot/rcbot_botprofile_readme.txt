~RCBOT~ BOTPROFILES README
++++++++++++++++++++++++++

------------
Bot Profiles
------------

A new addition which

 Identifys bots uniquely
 Profiles updated while playing
 Stores reputation of other players to the bot
[ Stores memory info (to come at a later time :))]

---------------------
How to make a profile
---------------------
In the game, if you add a bot and there are not enough profiles, 
a profile will be randomly created.

But you can manually make your own...!

First up, you need to open botprofiles.ini and input the name of 
the file you want your new bot profile to be. Make the new file 
in botprofiles folder, and give it an "ini" extension 

i.e. if you made your profile "20" then your filename 
should be "20.ini"

Please keep the filenames as numbers or things wont work!!
And do not have a profile "0" or that will be ignored.

------------------
The Profile Layout
------------------

 What is in a profile?
 ---------------------

  [] Comments, that don't affect the bot, they are just for you to look 
     at so you know whats going on.
 
  [] The name of the bot, the name that appears on the scoreboard 
     for that bot,

  [] Bot's skill, favourite mods/maps (i.e. more chance of
     them appering on that mod/map unless you really want that profile
     to be used on your current mod & map,

  [] The bots favourite team, defined by a number, see next section,

  [] The bots spray logo. (The name of the logo),

  [] NS: gorge/fade/lerk/onos gestate probability,

  [] Top and bottom model colour

  [] Files needed for megaHAL

 How to set up a profile
 -----------------------

  A Comment
  ---------

  A comment will have the '#' sign as the first letter in the line
  and then you can write any thing after it, provided its on the same
  line as the '#' sign.

  e.g. I would write in the file:

  #this is a comment

  The bots name
  -------------

    In the profile you must write "name" followed by an "=" (equals sign) 
    and then a value in quotes.

    e.g.

    name="X"

    If you want a name such as "ImABot", it will be

    name="ImABot"

  The bots favourite mods/maps and team
  -------------------------------------

   All these values just allow the bot to choose a team, and its map/mod.

   The favmod is defined by an integer number which idenities that mod.
   See the next section of "things you might need to know" and the MOD ID.
 
   So, If you want the bot to mostly appear playing Natural-Selection then the 
   favmod will be "1" i.e. 

   To set this up, you must write "favmod" followed by an "=" and then the MOD ID.

   i.e.

   favmod="1"
 
   (For natural-selection)
 
   ---

   This is the same for favourite team except it is defined by "favteam". Read the 
   next section on getting the team numbers. 

   ---  
 
   The bots favourite map however is defined by the actual name of the map.
   e.g. "ns_hera". 

   So you should write:

   favmap="ns_hera"

  The bots skill
  --------------

  The bots skill is now defined by an integer number in the range 0 to 100
  The skill 100 is the best skill, and the skill 0 is the worst skill.

  The bots model colour
  ---------------------

  You can add one or more of these, you do not need to add these, if you don't then
  bots will choose a random colour for the item you left out.

  topcolor=200
  bottomcolor=100

  ------------------------
  Files needed for megaHAL
  ------------------------

  common files come with the bot so you can use the same file for everybot if you wish
  or the same file for some bots and some use their own individual files. Or every bot
  can have their own individual files for HAL pre-training, aux words and swapping and
  banned keywords.

  All default bot profiles come with the additional lines below:

  hal_pretrain_file="common_hal.trn"
  hal_aux_file="common_hal.aux"
  hal_ban_file="common_hal.ban"
  hal_swap_file="common_hal.swp"

  hal_pretrain_file is the file in the bot profiles folder that the bot will use to pre-
  train its megaHAL brain. The pre-train file is just a file with ordinary text which just
  look like messages as though you were talking to the bot.

  hal_aux_file is the file the bot will use to look up for which words mean the same thing.
  this is useful if you want the bots to speak differently more often. Just grab a thesaurus
  and punch some lines in the file!

  hal_ban_file is the file which the bot will look up for words that the bot will NOT use
  as keywords. If the bot keeps saying things that it shouldn't it is likely it is looking
  for keywords that it shouldn't look for, if you know what they are then slap them in this
  file

  hal_swap_file is the file which the bot will find words to swap when talking to it. e.g.
  "you" will turn out to be "I" as your are saying "you" refferring to the bot.

  If any of these lines are missing then the bot loads up its own file. It's own file
  is it's bot profile number + the words _hal.aux (for auxilliary files), _hal.ban (for
  keyword ban fles), _hal.swp (swap files), _hal.trn (train files)

  example, bot profile 12 will use the files:

  12_hal.swp
  12_hal.trn
  12_hal.aux
  12_hal.ban


  Other people's reputation with the bot
  --------------------------------------

  Each bot has an arrogance level or "reputation" level defined by an integer
  number in the range of 0 to 10.

  10 is the best reputation, 0 is the worst reputation.

  This means that if the someone has the reputation of 10 with a bot, that bot
  likes that player, and will tend not to get angry with them, but help/have
  a 'laugh' with them :)

  When a player has 0 reputation with the bot, then the bot will tend to not like
  the other player, Won't give them orders if the bot is a commander. Won't follow
  their orders much, and generally talk back at them negatively.

  Bots reputations are stored in the .rcr files in binary format so it's difficult 
  to edit them. I may release something sometime to allow the ease to update them.

  That's it for reps, remember reputations only have to do with name, not their WON ID.
  That means someone could imperonate "IRBot" by setting their name to "IRBot"
  Or improve their rep by setting their name to "Cheeseh" (Would I allow that?!!) :-)

  I find this is a more realistic approach, because typically players don't remember 
  everyones WON ID's do they?


  -------------
  Further Notes
  -------------

  Do not put spaces in between name="botname" / favteam=1 etc. 
  as it may be read improperly by the bot program.

--------------------------------------------------
Things you might need to know when editing configs
--------------------------------------------------

Read the rcbot_reference.txt, it's a bit of a mess but you should
be able to find what you are looking for.