import Header from './components/Header/Header.jsx';
import Department from './components/Department.jsx';
import TabButton from './components/TabButton/TabButton.jsx';
import { Fragment, useState } from 'react';
import { departments } from './department.js';
import { DEPARTMENTINFO } from './data.js';

function App() {
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
    <>
      <Header></Header>
      <main>
        <section id="departments">
          <h2>Departments</h2>
          <ul>
            {departments.map((department) => (<Department key={department.title} {...department} />))}
          </ul>
        </section>
        <section id="faculty">
          <h2>Department Information</h2>
          <menu>
            <TabButton isSelected={selectedDepartment === 'ME'} onSelect={() => handleSelect('ME')}>Mechanical</TabButton>
            <TabButton isSelected={selectedDepartment === 'CE'} onSelect={() => handleSelect('CE')}>Civil</TabButton>
            <TabButton isSelected={selectedDepartment === 'CSE'} onSelect={() => handleSelect('CSE')}>CSE</TabButton>
            <TabButton isSelected={selectedDepartment === 'EEE'} onSelect={() => handleSelect('EEE')}>EEE</TabButton>
          </menu>
          {tabContent}
        </section>
      </main>
    </>
  );
}

export default App;