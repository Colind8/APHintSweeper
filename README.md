# APHintSweeper
APHintSweeper is a Minesweeper hint game for Archipelago created with Gamemaker.

# Project Plan
- Inaccessible unless setup by host
- Host exclusive settings requiring server password to access
- Host creates each "game type"
  - A game type represents the difficulty and rewards. The following are its customizable features:
  - name: the name of the game type
  - game width: the amount of tiles for the width
  - game height: the amount of tiles for the height
  - total bombs: the amount of bombs that will be in the field
  - timed: whether the game will be timed or not
  - time: if above enabled, the amount of seconds the player will have to clear the field
  - reward type: location/item. Whether it awards a location hint in your game, or an item hint for your game.
  - reward random weights: Weights for each type of hint
    - Filler Weight: the chance the reward will be for a filler/trap item
	- Useful Weight: the chance the reward will be for a useful item
	- Progressive Weight: the chance the reward will be for a progressive item
	- Token Weight: the chance the reward will be for a hint token (only for item reward type)
- Host must import spoiler.txt file to use the item reward type.
  - This will add all item-location pairings to the server's data storage.

- Players login with their slot's credentials and can play any of the host's custom-made game types
- If a player receives a "Hint Token", they can use it on whatever item they want to find.
  - Hint tokens are only available for as long as the game is open.
- Death link can be enabled
  - If a bomb is clicked, a death link will be sent
  - If a death link is received, all bombs will go off.
- Access to a hint list, including the ability to change hint status
- Access to a console