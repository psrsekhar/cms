import { Fragment } from "react";

import Header from "./components/Header/Header.jsx";
import Departments from "./components/Department/Departments.jsx";
import DepartmentInfo from "./components/Department/DepartmentInfo.jsx";
import Game from "./components/Tic-Tac-Toe/Game.jsx";
import Calculator from "./components/Investment-Calculator/Calculator.jsx";
import Login from "./components/Login/Login.jsx";

function App() {
  return (
    <Fragment>
      <Login></Login>
      <Header></Header>
      <main>
        <Departments></Departments>
        <DepartmentInfo></DepartmentInfo>
        <Game></Game>
        <Calculator></Calculator>
      </main>
    </Fragment>
  );
}

export default App;
