# Chess in the Console #
This console game is jointly developed with [Rehan Alam][rehan-alam]. The development process took in total two days.

[rehan-alam]: https://github.com/ralam

### See a Demo Video ###
This is the chess game played by two AIs. It shows how AIs move the cursor, and capture pieces when chances are present. [Full Fight Here][ai-fight]

[ai-fight]: https://www.youtube.com/watch?v=NMLvO75pSBw

### Sample Screenshot ###
![chess]

[chess]: ./images/chess.png

### Development Schedule ###
Day1:
+ Inheritance hierarchy and cordinates-based control.<br/>

Day2:
+ Integrate keypress.rb keystroke detection library into the game.
+ Wrote computer AI that can construct sequence of keystroke moves.

### How to Run ###
+ You need the latest versions of Ruby to run this game.
+ Download the repository and navigate into the directory using command line.
+ Once you are there, run the command <code>$ bundle install</code>.
+ After that's done, run <code>$ ruby lib/chess.rb</code> (You will be asked if you want to load a saved game. Choose n for now. If you want to save a copy of the game, you can do that during the game play using the ESC key).

### Development Highlights ###

+ Serialization: This game uses YAML serialization to preserve a game state. The saved game states are added to the repository and can be later revived on game load.
+ Keystroke Detection: The keypress.rb library translates keyboard actions into bare string representation. The game then take the string and feed it into a case statement to determine appropriate actions.
+ AI that moves the cursor: The AI has an internal queue of commands. When a desirable move is determined, the AI calculate the necessary keystroke steps and push them onto the queue. The AI then shift all commands in sequential order to perform the action.

### Future Development Considerations ###
+ Use nodes to emulate the forsight behavior of normal human players. Each node should have a valid "advantage score" measure. The AI then choose the the node that has the highest advantage scores.
+ Switch to web-based interface. This chess game has Ruby as hard dependencies. It would be nice if it can be translated into a web-based chess interface.
