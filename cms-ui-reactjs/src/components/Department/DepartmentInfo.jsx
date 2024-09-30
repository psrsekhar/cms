import { useState } from "react";

import TabButton from "./TabButton/TabButton.jsx";
import { DEPARTMENTINFO } from "./data.js";

export default function DepartmentInfo() {
  const [selectedDepartment, setSelectedDepartment] = useState();
  function handleSelect(selectedButton) {
    setSelectedDepartment(selectedButton);
  }
  let tabContent = <p>Please select a department</p>;
  if (selectedDepartment) {
    tabContent = (
      <div id="tab-content">
        <h3>{DEPARTMENTINFO[selectedDepartment].title}</h3>
        <p>{DEPARTMENTINFO[selectedDepartment].description}</p>
      </div>
    );
  }

  return (
    <section id="department-info">
      <h2>Department Information</h2>
      <menu>
        <TabButton
          isSelected={selectedDepartment === "ME"}
          onSelect={() => handleSelect("ME")}
        >
          Mechanical
        </TabButton>
        <TabButton
          isSelected={selectedDepartment === "CE"}
          onSelect={() => handleSelect("CE")}
        >
          Civil
        </TabButton>
        <TabButton
          isSelected={selectedDepartment === "CSE"}
          onSelect={() => handleSelect("CSE")}
        >
          CSE
        </TabButton>
        <TabButton
          isSelected={selectedDepartment === "EEE"}
          onSelect={() => handleSelect("EEE")}
        >
          EEE
        </TabButton>
      </menu>
      {tabContent}
    </section>
  );
}
