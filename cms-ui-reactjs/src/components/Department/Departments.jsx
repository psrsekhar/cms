import { departments } from "./department.js";
import Department from "./Department.jsx";

export default function Departments() {
  return (
    <section id="departments">
      <h2>Departments</h2>
      <ul>
        {departments.map((department) => (
          <Department key={department.title} {...department} />
        ))}
      </ul>
    </section>
  );
}
