+=============================================================================================================================================+
| Title: Phasmophobia Maps																													  |
| Version: 0.0.5a																															  |
| Updated: 01-09-2024																														  |
+=============================================================================================================================================+

+=============================================================================================================================================+
| Developer: Alamaxia																														  |
| Mapper: Fantismal																														  	  |
| Tester: Trythen																														 	  |
+=============================================================================================================================================+



+=============================================================================================================================================+
| Description																																  |
+=============================================================================================================================================+
	A desktop-level utility for Phasmophobia to help manage some of the more intricate mechanics such as calling out when a smudged (incensed)
	ghost can hunt, based on if it's a Demon, Spirit, or any other ghost.
	
+=============================================================================================================================================+
| Why make yet another Phasmophobia app?																									  |
+=============================================================================================================================================+
	I initially set out building this for myself and my friend, Trythen, to have an easy way to manage our smudge timers.
	We had previously been using a webapp to track smudges, but we had to tab out, hit the timer, and tab back in.
	If you're playing solo, this means you have to smudge, get to a safe spot, alt-tab out, hit the timer, alt-tab back in,
	and hope that the ghost doesn't come looking for you.  A lot of wasted time that ends with an inaccurate timer!

	We also play exclusively zero-evidence, which means we have to rely purely on ghost behaviours.  Several ghosts have tells
	which are range based.  It's easy to say that "a Myling's footsteps won't be heard until they're 12m away, but how can you best
	set yourself up for that?  Or if you think it's a Yokai, are there good hiding spots that you can safely use to check?
	This is what prompted me to integrate the maps and the circles, which helps visualize the effective reach of all the different tools.

+=============================================================================================================================================+
| Features																																	  |
+=============================================================================================================================================+
	- Smudge Timer
		- Countdown timer which starts from 3 minutes (180 seconds) when toggled
		- Audio callouts for when a smudge is running out for a Demon (60 seconds)
		- Audio callout for when a smudge is running out for a Spirit (180 seconds)
		- Audio callout for when any other ghost can hunt (90 seconds)
		
	- Map Visualizer
		- Select a map from a dropdown to load into frame
		- Pan/Zoom
		- Toggle map layers
			- Labels and Legend
			- Names of Rooms
			- Boundaries of Rooms
			- 1m Grid
			- Base-Level House
		
	- Range Visualizer
		- Standard ranges available in dropdown
		- Color Picker
		- Creates a circle which can be dragged around the map
		- Multiple circles can be created
		
	- Options
		- Mirror UI (Left-Right)
		- Volume 
		- Bypass Smudge Timer

+=============================================================================================================================================+
| How to Use																																  |
+=============================================================================================================================================+

	Smudge Timer:
		Press the Start Timer button when the ghost has been smudged
		Press the Stop Timer button when the ghost next hunt begins, or if you wish to stop the timer
			Note: If you have "Bypass Smudge Timer" enabled in the options, pressing the Stop Timer button will instead restart the timer.
			
		If you are using the included AutoHotKey script, you can press Tab in-game to toggle Start/Stop!
		
	Maps:
		Select a map from the dropdown under the Select Map header.
		Press the Load Map button.
		Map Controls:
			Pan: Middle Click
			Zoom: Mouse Wheel
			
	Range Circles:
		Select a range using the dropdown under the Create Range Circle header.
		Choose the color of the circle using the Color Picker
			Note: A default color will be loaded into theColor Picker any time a range is selected from the dropdown
		Press the Create button to create a circle you can move around!
		Left-Click near the center of a circle to drag and move it around the map!
		Press the Clear button to clear all circles from the map.
		
	Options:
		Toggle the "Bypass Smudge Timer" On/Off
		Toggle Flip UI On/Off
		Use the slider to control the volume of the callouts
			Note: The default volume is set to 50%, which is actually the full volume of the audio file.  Sliding the volume higher than 50%
				will amplify the audio file, which can begin to sound distorted.
				
	AutoHotKey Script:
		This script gives us the ability to hit tab from inside of the game to toggle the smudge timer on/off.
		
		You MUST have AutoHotKey installed to use this included script - https://www.autohotkey.com/.  

		After AutoHotKey is installed, double-click on the script to load it.  Once it's loaded, any time you press "Tab" in Phasmophobia, it
			will intercept that signal and instead send a specific command to the app.  The app uses this as a hotkey to toggle the smudge timer,
			since there's no way that Godot can listen for background input.

+=============================================================================================================================================+
| Known Issues																																  |
+=============================================================================================================================================+
	Range Circles:
		- If the middle of two range circles are too close to each other, they can become inseperable (awwwwww) and must otherwise be purged!!!!!
		- When moving one range circle, if the middle gets too close to another circle, it can push the other circle out of the way
			- This causes even more issues when you go to fix that circle which got pushed out of the way.
			
	Smudge Timer:
	- Timer does not automatically toggle to stop when the timer has reached 0.  This is because I want to have the timer continue counting
		down past 0 to help with discerning the difference between a Spirit and a Shade.

+=============================================================================================================================================+
| Copyright and Disclaimers																													  |
+=============================================================================================================================================+

	Copyright:
		Alamaxia
		
	MIT License:
		Copyright (c) 2024 - Alamaxia

		Permission is hereby granted, free of charge, to any person obtaining a copy
		of this software and associated documentation files (the "Software"), to deal
		in the Software without restriction, including without limitation the rights
		to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
		copies of the Software, and to permit persons to whom the Software is
		furnished to do so, subject to the following conditions:

		The above copyright notice and this permission notice shall be included in
		all copies or substantial portions of the Software.

		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
		IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
		FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
		AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
		LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
		OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
		THE SOFTWARE.
		
	Fair Use Disclaimer:
		This application may contain copyrighted material, the use of which may not have been specifically authorized by the copyright owner. 
		The material is made available for the purpose of teaching or research. We believe this constitutes a 'fair use' of any such copyrighted 
		material as provided for in section 107 of the US Copyright Law.

		In accordance with Title 17 U.S.C. Section 107, the material on this application is distributed without profit to those who have expressed 
		a prior interest in receiving the included information for research and educational purposes.

		If you wish to use copyrighted material from this application for purposes of your own that go beyond 'fair use,' you must obtain permission 
		from the copyright owner.