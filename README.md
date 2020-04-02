## Before you start
*	Please, note that the audio scripts have been validated in **Pro Tools Ultimate 2018.12.0 and macOS 10.13.6 and macOS 10.14.6**
*	Note that you may be asked to allow Automator or Pro Tools or any other app you may use in the accessibility menu. To do so, open Settings, Security & Privacy and click on Privacy and then in Accessibility. Click the + button an add the Automator and Pro Tools app. You will have to allow more apps (Skype, Chrome, etc.)

## How to install the scripts
* Download the script you want to install fomr the *Automator* folder.
*	Double click on it. Once it has been installed, you may delete the local copy.
*	Open System Preferences and go to Keyboard. Then click on Shorcuts and Services. Into the General tab you will find the newly created Automator script. Add the shortcut and it will be done.
* The *Script* folder contains only the raw script. You don't need to use it.

## Available scripts
### Analyze RX 6 Connect
This script will open the RX connect Audiosuite window and send the selected audio from Pro Tools to RX Audio Editor.
* Assign **ctrl+alt+C**.

### Gain selected clip
This script will open the Gain Audiosuite floating window and analyse the selected audio.
* Assign **ctrl+alt+G**.

### Strip Silence
This script will open and set up the Strip Silence in Pro tools. A floating window will prompt when you use the script. You will be able to choose between two options, one for the initial edit and the other one to separate the slates at the end of the RX process.
* Assign **ctrl+alt+U**.

### Cut, rename and clean videos
This script will rename, cut and clean the consolidated region under a video track with several videos. The video track must be over the region you want to split and rename.  First, consolidate the whole edit region with the same length that all the videos. Then, select the first video of the session and run the script. It will finish automatically. To abort, please change app or close Edit window.
* Assign **ctrl+alt+cmd+shift+R**.

### Spotting Videos
The script will spot the videos and its OST to rounded TCs. The OST track must be under the video track. The first video must be spotted correctly. Select the first video of the session and run the script. It will create a marker and spot all subsequent videos to rounded up TCs. It will finish automatically. To abort, please change app or close Edit window.
* Assign **cmd+alt+ctrl+S**.
