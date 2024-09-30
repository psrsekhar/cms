import Player from "./Player";
import "./Game.css";

export default function Game() {
  return (
    <header id="game" className="game-background game-header">
      <img src="game-logo.png" alt="Hand drawn Tic-Tac-Toe game board" />
      <div id="game-container">
        <h2>Tic-Tac-Toe</h2>
        <ol id="players">
          <Player initialName="Player 1" symbol="X"></Player>
          <Player initialName="Player 2" symbol="O"></Player>
        </ol>
      </div>
    </header>
  );
}
