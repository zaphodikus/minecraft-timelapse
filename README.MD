# README
A general minecraft related dumping ground.
## AutoHotKey AHK scripts
 * mc_timelapse.ahk : a basic timelapse script using autohotkey
 * mc_delete_build.ahk : use WorldEdit to delete a minecraft scene, with a reverse timelapse
 * test_logging.ahk : test script to create my basic logging class
 
 # mc_timelapse.ahk
 A bit of explanation as to what is going on in this script. I used version 1.3 . AHK is a bizaire scripting language, for example these is an AHK version 2 out, but it's a rewrite and vastly different enough to have no support. So 1.3 is supported by a brilliant community, but is a hard languge to just pick up. I'll cover some AHK gotchas later.
 
 This is not the first AHK script I have written, it's a copy of my first script which does the same timelapse +screenshot thing in the Emyprion Galactic Survival game. [My EGS Game config Files on github.](https://github.com/zaphodikus/EGS-gameconfig)

I'm using standard minecraft commands in this script, as well as [WorldEdit Commands](https://minecraft-worldedit.fandom.com/wiki/Worldedit_Commands) , I found you need to use [multiple docs](https://worldedit.enginehub.org/en/latest/commands/) to understand them enough. 
```
      ...
      SendInput, /
      ; allow for panel to open
      Sleep 200
```      
This script does 2 things per command, t presses / to open console, with a delay, and then you need to delay after some commands too. Also dont type too fast.
```
SetKeyDelay, 30
```
I start out by ensurign the player and game settings is in the correct mode, some of these are harder to do than you imagine. Weather effects take 8 seconds to stop, so the script assumes you have already stopped them and merely tries to help, or assumes you will try again later. 

Another tip is to turn off clouds entirely for these. If you are usign optifine (which I coudl not get loaded wtih Forge), make clouds height very high, since their clouds are very pretty, you might want them still.

Finally the script takes screenshots using the in-game screenshot engine, it has to wait for each console to close. note, this is a long time. ```Sleep 5000``` mainly because the time and sun position actually takes a while to update in game.

# mc_delete_build.ahk
This is a refinement of the timelapse script earlier, it runs the time backwards instead, because it records us building a house backwards. And I wanted the run to look like it's moving normally in the backwards footage. In fact we are breaking the house or deleting it from the top downwards, and then just stitching the screenshots together in a video editor and reversing the clip. The final output looks like [this on youtube](https://youtu.be/MaagTF2Jms4)

Classes in AHK are tricky, I add a point XYZ class and a logger class which simplified debugging a tonne. We use worldedit to create a 2 block high slice of the world at the top of the building, and just delete it usign the /replace command. We move the block down 1 block and repeat. This needs to be a 2 blocks deep slice to handle loop where the graphics are not yet caught up, as well as if a command get munched. If command get munched and garbled often, try increasing the typing delay value a bit, and also try increase the console opener delay
```
	...
   SetKeyDelay, 30 ; larger values simulate real typing speeds

   global con_open_delay
	con_open_delay :=140 ; larger values give the / key more time to open the console
   ...

```
# test_logging.ahk
It's just easier to build classes or pieces of code in isolation first.

# AHK gothas
It's a cool language, but some things will trip up the beginner, like:
* Always use ```:=``` *never use ```=``` ,* it's annoying, but this code does absolutely nothing, without warning you that it has had no effect whatsoever. ```var1 = new MyClass()``` . You have to use ```:=``` at this point. 

* One way to help is to add a directive ```#Warn``` . Other parameters to #Warn change the warnings a bit, but the basit ```#Warn``` is a big help. 
* AHK identifiers are not case sensitive at all. It also has no qualms about assignments that make no sense either.
```
class Logger
{
   __new(filename)
   {
      this.filename := filename
   }
}
...
logger := new Logger("log.txt")  ; <= Ha Ha Ha
```
logger is now equal to logger, which is now actually uninitialized, and is still not case sensitive. All identifier types are in one namespace.

* double quotes, you want to use them for strings, but when you do, they get addd to the string itself annoyingly, so you ahve to tell the parset, that the string comming up is a quoted string lik using ```%``` . Annoyingly you have to use ```, %``` quite often, and although the comma is optional, it makes readability worse, but makes your code do waht is should more often than not.