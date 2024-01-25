// SPDX-License-Identifier: MIT

// This is considered an Exogenous, Decentralized, Anchored (pegged), Crypto Collateralized low volitility coin

// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions
pragma solidity 0.8.20;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

//////////////////
/////ERRORS/////
error Exchange__WrongLiquidityPosition();
error Exchange__AmountShouldBeGreaterThanZero();
error Exchange__AmountIsLessThanMinimumAmount();
error Exchange__InsufficientReturnReserve();

contract Exchange is ERC20Burnable {
    address public SeleTokenAddress;

    constructor() ERC20("SeleToken", "STKN") {
        SeleTokenAddress = 0x37a9A42F44e3135e2ff6d3C54B443BFa832c9D0E;
    }

    function getContractTokenBalance() public view returns (uint256) {
        return IERC20(SeleTokenAddress).balanceOf(address(this));
    }
    /**
     * @dev Adds liquidity to the exchange.
     */

    function getRequiredLiquidity(uint256 ethamount) private view returns (uint256) {
        uint256 ethReserve = getEthBalance() - ethamount;
        uint256 cryptoDevTokenAmount = (msg.value * getContractTokenBalance()) / (ethReserve);

        return cryptoDevTokenAmount;
    }

    function getEthBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function provideLiquidity(uint256 amount) external payable returns (uint256) {
        uint256 liquidityPool;
        if (getContractTokenBalance() == 0) {
            IERC20(SeleTokenAddress).transferFrom(msg.sender, address(this), amount);
            _mint(msg.sender, address(this).balance);
            return address(this).balance;
        }
        uint256 expectedtokenAmount = getRequiredLiquidity(amount);
        if (amount < expectedtokenAmount) {
            revert Exchange__WrongLiquidityPosition();
        }
        IERC20(SeleTokenAddress).transferFrom(msg.sender, address(this), amount);
        liquidityPool = (totalSupply() * msg.value) / (getEthBalance() - msg.value);
         _mint(msg.sender, liquidityPool);
        return liquidityPool;
    }
    function removeLiquidity (uint256 amount) public returns(uint256 ethValue, uint256 tokenValue){
    if (amount <= 0) {
        revert Exchange__AmountShouldBeGreaterThanZero();
    }
     ethValue = (address(this).balance * amount)/ totalSupply();
     tokenValue = (getContractTokenBalance() * amount)/ totalSupply();
     _burn(msg.sender, amount);
      payable(msg.sender).transfer(ethValue);
      IERC20(SeleTokenAddress).transfer(msg.sender, tokenValue);
    }
        /** 
    * @dev Returns the amount Eth to SeleTokes or vice versa that would be returned to the user
    * in the swap
    */
   function getTokenSwapAmount(uint256 amountToSwap,uint256 inputReserve, uint256 outputReserve) private pure returns (uint256) {
     uint256 outputAmount = (outputReserve * amountToSwap) / (inputReserve + amountToSwap);
     return outputAmount;
   }
   
    /** 
    * @dev Swaps Eth to  SeleTokens Tokens
    */
   function SwapEthForSTKN(uint256 minTokenAmount) external payable{
     uint256 tokenReserve = getContractTokenBalance();
     uint256 tokenSwapAmount = getTokenSwapAmount(
            msg.value,
            address(this).balance - msg.value,
            tokenReserve
        );
        if (tokenSwapAmount < minTokenAmount) {
         revert Exchange__AmountIsLessThanMinimumAmount();   
        }
        IERC20(SeleTokenAddress).transfer(msg.sender, tokenSwapAmount);
   }
    /** 
    * @dev Swaps SeleTokens Tokens for Eth
    */
   function SwapSeleTokenForEth(uint256 tokenSold, uint256 minEthAmount) external payable {
      uint256 contractTokenBalance= getContractTokenBalance();
      uint256 ethTradeAmount = getTokenSwapAmount(
            tokenSold,
            contractTokenBalance,
            address(this).balance
        );
        if (ethTradeAmount<=minEthAmount) {
            revert Exchange__InsufficientReturnReserve();
        }
        IERC20(SeleTokenAddress).transferFrom(msg.sender,
            address(this),
            tokenSold
        );
        payable(msg.sender).transfer(ethTradeAmount);
   }
}
