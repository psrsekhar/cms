export default function Input() {
  return (
    <section id="user-input">
      <div className="input-group">
        <p>
          <label>Initial Investment</label>
          <input type="number" required />
        </p>
        <p>
          <label>Annual Investment</label>
          <input type="number" required />
        </p>
      </div>
      <div className="input-group">
        <p>
          <label>Expected Return</label>
          <input type="number" required />
        </p>
        <p>
          <label>Duration (in years)</label>
          <input type="number" min="1" required />
        </p>
      </div>
    </section>
  );
}
