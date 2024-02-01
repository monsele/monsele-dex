// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {Exchange} from "../src/Exchange.sol";

contract ExchangeScript is Script {
    function run() external returns (Exchange) {
        vm.startBroadcast();
        Exchange exchange = new Exchange();
        vm.stopBroadcast();
        return exchange;
    }
}
