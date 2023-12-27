# Farmtronics Scripts

Scripts for Stardev Valley - Farmtronics mod that automates watering plants. 

## Installation

* Copy files with .ms extension from project to /usr/lib directory (create if doesn't exist)
* You can find the directory mentioned above in "C:\Users\\\<User Name>\AppData\Roaming\StardewValley\Saves\\\<Save>\strout.farmtronics\usrdisks\\\<Some Numbers>\\"
* Start the game on your save and open console by right-clicking Bot or by TV FarmtronicsHomeComputer option.
* You should be in "/usr" directory. Type dir in the console and click ENTER. Right below command you should see "/usr :" and list of files and directories.
* Open "startup.ms" by executing commands: 
  * load "startup" 
  * edit
* On top of file add line 'import "wateringBot"'
* Click ESC and in console execute command "save"

![alt text](https://github.com/TwentyFifthNight/MiniScript-Farmtronics/blob/main/img/img1.png?raw=true)

![alt text](https://github.com/TwentyFifthNight/MiniScript-Farmtronics/blob/main/img/img2.png?raw=true)

![alt text](https://github.com/TwentyFifthNight/MiniScript-Farmtronics/blob/main/img/img3.png?raw=true)

## Additional configuration

You can set Bot position after work and water source position in "wateringBot.ms" file in "lib" directory. Values for both positions are on top of file. Remember that water source position should be position next to the water. Direction in which water is from set position should be set in "directionToWater" variable.

![alt text](https://github.com/TwentyFifthNight/MiniScript-Farmtronics/blob/main/img/img4.png?raw=true)

![alt text](https://github.com/TwentyFifthNight/MiniScript-Farmtronics/blob/main/img/img5.png?raw=true)

## Additional information

* If the bot encounters Player or Animal on it's path, it will wait until the path is clear.
* There is no way for bot to go through fence or gate, so fields and water source shouldn't be fenced off.
* Bot can pass through scarecrows and trellis crops.
* Remember that the bot works only when you are on the farm.

## Acknowledgments

* [A* algorithm](https://www.geeksforgeeks.org/a-search-algorithm/)
