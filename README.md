# APHintSweeper
APHintSweeper is a Minesweeper hint game for Archipelago created with Gamemaker.

# Initial Setup
To play APHintSweeper, the host or admin must setup the game by completing the following steps:

1. Open the game and connect to the Archipelago with any slot.
2. A button will appear that says "Open Admin Panel"
3. Enter in the Server Password and then click "Login"
4. Complete the initial setup by creating custom difficulties and rewards
5. (optional) import spoiler.txt file to enable item hints
6. Save and exit the admin panel. The host can disconnect from here and APHintSweeper can now be used by all.

The admin panel can be opened at any time to change any of the settings. 

## Importing Spoiler.txt
A few notes related to importing your spoiler.txt file:
- It will make as many calls to the server as there are slots, so it could take several seconds to complete.
- This will create a lot of keys in DataStorage (see using /datastore in server console).
- It will make a key for every player, split every 600 items. So if a player has 1300 items, it will make three different keys for that one player.
- After importing once, there is no reason to import again. The option is there just in case.
- Doing this will enable gettings hints for your own items rather than just your locations.

# How to Play
1. Open the game and connect to the Archipelago. (optionally, you can enable Death Link)
2. Click "Play" after connecting.
3. Choose a difficulty. Hover over it to see stats and rewards.
4. After winning, you will be given your reward. See below for explaination on each reward type.
5. Back at the main menu screen, you can click "Hints" to view our new hint, or you can play again.
6. If you won a hint token, you can click "Spend Hint Tokens" to use it. (note: Hint Tokens will be lost if you disconnect)

# Rewards
There are numerous types of rewards that can affect what kind of hint you. NOTE: Currently only Hint Tokens and none are implemented.

## Hint Type
You can get a location hint or an item hint.
- Location Hint: Gives you a hint of a location in your game. (like !hint_location)
- Item Hint: Gives you a hint of an item from your game. (like !hint)

## Hint Rarity
The level of hint you get can be affected by chance. (Configured by the admin/host)
- None (no reward at all)
- Filler/Trap Hint (typically useless, temporary, or bad)
- Useful Hint (typically a useful item)
- Progression Hint (an item that gives access to at least one location)
- Hint Token (A special currency that is explained below)

## Hint Tokens
Hint Tokens are like the Hint Point system in the text client. If you get a hint token, you can spend it to request a hint to whatever item/location you specify, just like with the !hint or !hint_location commands.

Note: Hint Tokens are not saved when you disconnect. You should spend them the moment you receive them.

# Death Link
Death Link can be toggled before connecting. No host customizability as of now.
- A Death Link is sent when you click a mine and lose. (optional amnesty set by host will be implemented eventually)
- When a Death Link is received, you instantly lose.

# Acknowledgements
- Inspired by [polyborea's APMinesweeper](https://codeberg.org/polyborea/APMinesweeper) and [EmilyV's APSodoku](https://github.com/APSudoku/APSudoku)

---

Note: Everything below this is hypothetical and subject to change.

# Project Plan
- ~~Inaccessible unless setup by host~~
- ~~Host exclusive settings requiring server password to access~~
- Host creates each "game type"
  - A game type represents the difficulty and rewards. The following are its customizable features:
  - ~~name: the name of the game type~~
  - ~~game width: the amount of tiles for the width~~
  - ~~game height: the amount of tiles for the height~~
  - ~~total bombs: the amount of bombs that will be in the field~~
  - ~~timed: whether the game will be timed or not~~
  - ~~time: if above enabled, the amount of seconds the player will have to clear the field~~
  - ~~reward type: location/item. Whether it awards a location hint in your game, or an item hint for your game.~~
  - reward random weights: Weights for each type of hint
    - Filler Weight: the chance the reward will be for a filler/trap item
    - Useful Weight: the chance the reward will be for a useful item
    - Progressive Weight: the chance the reward will be for a progressive item
    - Token Weight: the chance the reward will be for a hint token (only for item reward type)
- ~~Host must import spoiler.txt file to use the item reward type.~~
  - ~~This will add all item-location pairings to the server's data storage.~~

- ~~Players login with their slot's credentials and can play any of the host's custom-made game types~~
- ~~If a player receives a "Hint Token", they can use it on whatever item they want to find.~~
  - ~~Hint tokens are only available for as long as the game is open.~~
- ~~Death link can be enabled~~
  - ~~If a bomb is clicked, a death link will be sent~~
  - ~~If a death link is received, all bombs will go off.~~
- Access to a hint list, including the ability to change hint status
- Access to a console

# Additional information
- A console is accessible to view and send messages
- A hint table is accessible to view all your hints