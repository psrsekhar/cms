import { useState } from "react";

export default function Input() {
  const [userInput, setUserInput] = useState({
    initialInvestment: 10000,
    annualInvestment: 1200,
    expectedReturn: 6,
    duration: 10,
  });

  function handleChange(inputIdentifier, newValue) {
    setUserInput((previousUserInput) => {
      return {
        ...previousUserInput,
        [inputIdentifier]: newValue,
      };
    });
  }

  return (
    <section id="user-input">
      <div className="input-group">
        <p>
          <label>Initial Investment</label>
          <input
            type="number"
            value={userInput.initialInvestment}
            onChange={(event) =>
              handleChange("annualInvestment", event.target.value)
            }
            required
          />
        </p>
        <p>
          <label>Annual Investment</label>
          <input
            type="number"
            value={userInput.annualInvestment}
            onChange={(event) =>
              handleChange("annualInvestment", event.target.value)
            }
            required
          />
        </p>
      </div>
      <div className="input-group">
        <p>
          <label>Expected Return</label>
          <input
            type="number"
            value={userInput.expectedReturn}
            onChange={(event) =>
              handleChange("expectedReturn", event.target.value)
            }
            required
          />
        </p>
        <p>
          <label>Duration (in years)</label>
          <input
            type="number"
            min="1"
            value={userInput.duration}
            onChange={(event) => handleChange("duration", event.target.value)}
            required
          />
        </p>
      </div>
    </section>
  );
}
