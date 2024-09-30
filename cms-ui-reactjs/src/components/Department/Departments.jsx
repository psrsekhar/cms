import Section from "../Section.jsx";
import { departments } from "./department.js";
import Department from "./Department.jsx";

export default function Departments() {
  return (
    <Section title="Departments" id="departments">
      <ul>
        {departments.map((department) => (
          <Department key={department.title} {...department} />
        ))}
      </ul>
    </Section>
  );
}
