import React, { useState } from 'react';
import './LiquidityForm.css';

const LiquidityForm = () => {
  const [inputValue, setInputValue] = useState('');

  const handleSubmit = (event) => {
    event.preventDefault();
    // Handle form submission logic here
  };

  return (
    <form className="form-container" onSubmit={handleSubmit}>
      <input
        type="text"
        className="input-field"
        value={inputValue}
        onChange={(e) => setInputValue(e.target.value)}
      />
      <button className="button">Provide Liq</button>
    </form>
  );
};

export default LiquidityForm;
