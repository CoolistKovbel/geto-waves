// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    mapping(address => uint) public numberOfWaveFromAddress;

    constructor() {
      console.log("What is life, slit my throat and whatch me bleed in hopes that 1 btc will come down my way");
    }

    function wave() public {
      totalWaves++;

      numberOfWaveFromAddress[msg.sender]++;

      console.log('%s has waved', msg.sender);
    }

    function getTotalWaves() public view returns(uint256){
      console.log("The total amount of waves are: ", totalWaves);
      return totalWaves;
    }

    function userStatus(address usr) public view returns(uint) {
      uint numberOfWaves = numberOfWaveFromAddress[usr];
      console.log("%s had waved %d times", usr , numberOfWaves);
      return numberOfWaves;
    }

}