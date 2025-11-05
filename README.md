# Myg Chess Game

This is a chess game for Pharo based on Bloc, Toplo and Myg.

## Getting the code

This code has been tested in Pharo 12. You can get it by installing the following baseline code:

```smalltalk
Metacello new
	repository: 'github://ETS-Ronan/Chess:main/src';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```

## Using it

You can open the chess game using the following expression:

```smalltalk
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```

This opens a graphical chess board where you can play by clicking on the pieces.

## Relevant Design Points

This repository contains:
 - a chess model: the board/squares, the pieces, their movements, how they threat each other
 - a UI using Bloc and Toplo: a board is rendered as bloc UI elements. Each square is a UI element that contains a selection, an optional piece. Pieces are rendered using a text element and a special chess font (https://github.com/joshwalters/open-chess-font/tree/master).
 - Textual game importers for the PGN and FEN standards (see https://ia902908.us.archive.org/26/items/pgn-standard-1994-03-12/PGN_standard_1994-03-12.txt and https://www.chessprogramming.org/Forsyth-Edwards_Notation#Samples)

## Code Structure

| Package | Description |
|----------|--------------|
| `Myg-Chess-Core` | Contains all chess logic (board, pieces, game flow, and strategies). |
| `Myg-Chess-Importers` | Handles data loading utilities (e.g., FEN import). |
| `Myg-Chess-Tests` | Unit tests for board and piece behaviors. |

## Katas

### Restrict legal moves (Ronan)

**Goal:** Practice code understanding, refactorings and debugging

In chess, when we are not in danger we can move any piece we want in general, as soon as we follow the rules. However, when the king gets threatened, we must protect it! The only legal moves in that scenario are the ones that save the king (or otherwise we lose). What are moves that protect the king? The ones that capture the attacker, block the attack, or move the king out of danger. Another way to see it is: A move protects the king if it moves it out of check.

#### Difficulties Encountered and Solutions

A difficulty I had was simulating moves without actually changing the real board.  
To handle this, I added the method `MyChessBoard>>simulateMove:to:` that makes a temporary move, tests if the king is still in check, and then cancels this temporary move.

I also had trouble fixing a bug that made the king unable to capture a piece to get out of check, even when it was safe.  
I fixed it by updating `MyKing>>targetSquaresLegal:` so the king can capture an enemy piece if the destination square isn’t in danger.

Getting that simulateMove method to work without breaking the rest of the code was also difficult.  
I ended up changing `MyPiece>>moveTo:` so it always uses `simulateMove:` whenever a move is made.

#### Testing Approach

Testing was done using **SUnit**, Pharo’s built-in testing framework.

- Each major class (board, pieces, king) has its own dedicated test class.
- Manual testing was also performed by launching the game to verify complex scenarios.
- I used TDD to develop the method `MyChessBoard>>simulateMove:to:`, since it was the most complex part of my kata and included most of the logic needed for checking if a move keeps the king safe.

#### Design Decisions

The code is like this because the goal of the kata was to restrict legal moves when the king is in check.
To do that, I chose to make the game simulate moves first before actually doing them, to see if the king would still be in danger.  
That’s why I added the `simulateMove:to:` method on the board and made `moveTo:` use it before moving any piece (in case moving a piece checkmated the king).

I tested `simulateMove:to:` more than the other parts because it was the main logic behind checking if a move keeps the king safe, and it was also the most complex part of the kata to get right.

I put my priorities on keeping the project stable while adding the new rule.
I focused on changing as little code as possible, so everything that already worked would keep working.

My main goal in this kata was to refactor the code to add a way to block illegal moves when the king is in check.  
I didn’t use a design pattern because I wanted to keep the changes small and simple.
That’s why I just added the `simulateMove:to:` method and made the game call it before moving any piece.
It was the cleanest way to make the new rule work without breaking the rest of the project.
