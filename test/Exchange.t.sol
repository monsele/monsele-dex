// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import {Exchange} from "../src/Exchange.sol";
import {ExchangeScript} from "../script/Exchange.s.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ExchangeTest is Test {

  Exchange exchange;
  function setUp() public {
     exchange = new Exchange();
  }

  function testProvideLiquidity() public {
    // vm.deal(address(this), 1 ether);
    // vm.prank(address(this));
    exchange.provideLiquidity{value: 0.01 ether}(10);

   // assertEq(exchange.balanceOf(address(this)), 1 ether);
    assertEq(exchange.getEthBalance(),0.01 ether);
    assertEq(exchange.getContractTokenBalance(), 10);
  }

//   function testRemoveLiquidity() public {
//     // vm.deal(address(this), 1 ether);
//     // vm.prank(address(this));
//     exchange.provideLiquidity{value: 1 ether}(10);

//     uint ethBalanceBefore = address(this).balance;
//     uint tokenBalanceBefore = IERC20(exchange.SeleTokenAddress()).balanceOf(address(this));

//     vm.prank(address(this));
//     (uint ethWithdrawn, uint tokensWithdrawn) = exchange.removeLiquidity(1);

//     assertEq(ethWithdrawn, 1 ether);
//     assertEq(tokensWithdrawn, 10);
//     assertEq(address(this).balance, ethBalanceBefore + 1 ether);
//     assertEq(IERC20(exchange.SeleTokenAddress()).balanceOf(address(this)), tokenBalanceBefore + 10);
//   }

//   function testSwapEthForTokens() public {
//     vm.deal(address(this), 1 ether);
//     vm.prank(address(this));
//     exchange.provideLiquidity{value: 1 ether}(10);

//     uint tokenBalanceBefore = IERC20(exchange.SeleTokenAddress()).balanceOf(address(this));

//     vm.prank(address(2));
//     exchange.SwapEthForSTKN{value: 0.1 ether}(5);

//     assertEq(IERC20(exchange.SeleTokenAddress()).balanceOf(address(2)), 5);
//     assertEq(exchange.getEthBalance(), 0.9 ether);
//     assertEq(exchange.getContractTokenBalance(), 5);
//     assertEq(IERC20(exchange.SeleTokenAddress()).balanceOf(address(this)), tokenBalanceBefore + 5);
//   }

//   function testSwapTokensForEth() public {
//     vm.deal(address(this), 1 ether);
//     vm.prank(address(this));
//     exchange.provideLiquidity{value: 1 ether}(10);

//     vm.prank(address(2));
//     IERC20(exchange.SeleTokenAddress()).approve(address(exchange), 5);

//     uint ethBalanceBefore = address(2).balance;

//     vm.prank(address(2));
//     exchange.SwapSeleTokenForEth(5, 0.05 ether);

//     assertEq(address(2).balance, ethBalanceBefore + 0.05 ether);
//     assertEq(exchange.getEthBalance(), 0.95 ether);
//     assertEq(exchange.getContractTokenBalance(), 5);
//   }

}