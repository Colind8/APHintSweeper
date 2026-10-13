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
There are numerous types of rewards that can affect what kind of hint you.

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