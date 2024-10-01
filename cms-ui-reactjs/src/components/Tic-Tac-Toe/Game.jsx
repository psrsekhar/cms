import { useState } from "react";

import Player from "./Player.jsx";
import Board from "./Board.jsx";
import Log from "./Log.jsx";

import "./Game.css";

function deriveActivePlayer(gameTurns) {
  let currentPlayer = "X";
  if (gameTurns.length > 0 && gameTurns[0].player === "X") {
    currentPlayer = "O";
  }
}
export default function Game() {
  const [gameTurns, setGameTurns] = useState([]);
  //const [activePlayer, setActivePlayer] = useState("X");

  const activePlayer = deriveActivePlayer(gameTurns);

  function handleSelectSquare(rowIndex, colIndex) {
    /**
    setActivePlayer((currentActivePlayer) =>
      currentActivePlayer === "X" ? "O" : "X"
    );
    */
    setGameTurns((previousTurns) => {
      let currentPlayer = deriveActivePlayer(previousTurns);
      const updatedTurns = [
        { square: { row: rowIndex, col: colIndex }, player: currentPlayer },
        ...previousTurns,
      ];
      return updatedTurns;
    });
  }
  return (
    <header id="game" className="game-background game-header">
      <img src="game-logo.png" alt="Hand drawn Tic-Tac-Toe game board" />
      <div id="game-container">
        <h2>Tic-Tac-Toe</h2>
        <ol id="players" className="highlight-player">
          <Player
            initialName="Player 1"
            symbol="X"
            isActive={activePlayer === "X"}
          ></Player>
          <Player
            initialName="Player 2"
            symbol="O"
            isActive={activePlayer === "O"}
          ></Player>
        </ol>
        <Board onSelectSquare={handleSelectSquare} turns={gameTurns}></Board>
      </div>
      <Log turns={gameTurns} />
    </header>
  );
}
