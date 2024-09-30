import { useState } from "react";

import Section from "../Section.jsx";
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
    <Section title="Department Information" id="department-info">
      <menu>
        <TabButton
          isSelected={selectedDepartment === "ME"}
          onClick={() => handleSelect("ME")}
        >
          Mechanical
        </TabButton>
        <TabButton
          isSelected={selectedDepartment === "CE"}
          onClick={() => handleSelect("CE")}
        >
          Civil
        </TabButton>
        <TabButton
          isSelected={selectedDepartment === "CSE"}
          onClick={() => handleSelect("CSE")}
        >
          CSE
        </TabButton>
        <TabButton
          isSelected={selectedDepartment === "EEE"}
          onClick={() => handleSelect("EEE")}
        >
          EEE
        </TabButton>
      </menu>
      {tabContent}
    </Section>
  );
}
