import { useState } from "react";

import Header from "./Header.jsx";
import Input from "./Input.jsx";
import Results from "./Results.jsx";

import "./Calculator.css";

export default function Calculator() {
  const [userInput, setUserInput] = useState({
    initialInvestment: 15000,
    annualInvestment: 1200,
    expectedReturn: 6,
    duration: 10,
  });

  const inputIsValid = userInput.duration >= 1;

  function handleChange(inputIdentifier, newValue) {
    setUserInput((previousUserInput) => {
      return {
        ...previousUserInput,
        [inputIdentifier]: +newValue,
      };
    });
  }

  return (
    <section className="calculator">
      <Header></Header>
      {!inputIsValid && (
        <p className="validation-message">
          Please enter a duration greater than zero.
        </p>
      )}
      <Input userInput={userInput} onChange={handleChange}></Input>
      {inputIsValid && <Results userInput={userInput}></Results>}
    </section>
  );
}
