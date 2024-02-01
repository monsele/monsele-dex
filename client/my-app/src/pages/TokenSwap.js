import React, { useState } from 'react';
import '../App.css';

const Swap = () => {
  // ... existing state and functions
  const [tokenFrom, setTokenFrom] = useState('');
  const [tokenTo, setTokenTo] = useState('');
  const [amountFrom, setAmountFrom] = useState('');
  const [amountTo, setAmountTo] = useState('');

  // Functions to handle swap logic, connect to smart contract, etc.
  const handleSwap = async () => {
    // Implement swap logic here, using a Web3 library to interact with your smart contract
  };
  return (
    <div className="swap-container">
      <div className="token-select">
        <label htmlFor="tokenFrom">From:</label>
        <select id="tokenFrom" value={tokenFrom} onChange={(e) => setTokenFrom(e.target.value)}>
          {/* Populate options with available tokens */}
          <option value= "1">ETH</option>
          <option value= "2">STKN</option>
        </select>
      </div>
      <div className="token-select">
        <label htmlFor="tokenTo">To:</label>
        <select id="tokenTo" value={tokenTo} onChange={(e) => setTokenTo(e.target.value)}>
          {/* Populate options with available tokens */}
          <option value= "1">ETH</option>
          <option value= "2">STKN</option>
        </select>
      </div>
      <div className="amount-input">
        <label htmlFor="amountFrom">Amount From:</label>
        <input type="number" id="amountFrom" value={amountFrom} onChange={(e) => setAmountFrom(e.target.value)} />
      </div>
      <div className="amount-output">
        <label htmlFor="amountTo">Amount To:</label>
        <input type="number" id="amountTo" value={amountTo} readOnly />
      </div>
      <button className="button" onClick={handleSwap}>Swap</button>
    </div>
  );
};

export default Swap;
