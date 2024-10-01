import { useState } from "react";

import Header from "./Header.jsx";
import Input from "./Input.jsx";
import Results from "./Results.jsx";

import "./Calculator.css";

export default function Calculator() {
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
    <section className="calculator">
      <Header></Header>
      <Input userInput={userInput} onChange={handleChange}></Input>
      <Results userInput={userInput}></Results>
    </section>
  );
}
