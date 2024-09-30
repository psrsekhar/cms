import Header from "./components/Header/Header.jsx";
import { Fragment } from "react";

import Departments from "./components/Department/Departments.jsx";
import DepartmentInfo from "./components/Department/DepartmentInfo.jsx";

function App() {
  return (
    <Fragment>
      <Header></Header>
      <main>
        <Departments></Departments>
        <DepartmentInfo></DepartmentInfo>
      </main>
    </Fragment>
  );
}

export default App;
