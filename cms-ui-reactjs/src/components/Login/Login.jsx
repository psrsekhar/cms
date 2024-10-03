import { useState } from "react";

import "./Login.css";
import Header from "./Header.jsx";

export default function Login() {
  const [enteredEmail, setEnteredEmail] = useState("");
  const [enteredPassword, setEnteredPassword] = useState("");
  const [submitted, setSubmitted] = useState(false);

  function handleInputChange(identifier, value) {
    if (identifier === "email") {
      setEnteredEmail(value);
    } else {
      setEnteredPassword(value);
    }
  }

  function handleLogin() {
    setSubmitted(true);
  }

  const emailNotValid = submitted && !enteredEmail.includes("@");
  const passwordNotValid = submitted && enteredPassword.trim().length < 6;
  return (
    <section id="login" className="login-container">
      <Header></Header>
      <div id="auth-inputs">
        <div className="controls">
          <p>
            <label>Email</label>
            <input
              type="email"
              className={emailNotValid ? "invalid" : undefined}
              onChange={(event) =>
                handleInputChange("email", event.target.value)
              }
            />
          </p>
          <p>
            <label>Password</label>
            <input
              type="password"
              className={passwordNotValid ? "invalid" : undefined}
              onChange={(event) =>
                handleInputChange("password", event.target.value)
              }
            />
          </p>
        </div>
        <div className="actions">
          <button type="button" className="text-button">
            Create a new account
          </button>
          <button className="button" onClick={handleLogin}>
            Sign In
          </button>
        </div>
      </div>
    </section>
  );
}
