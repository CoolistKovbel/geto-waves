// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    event newWave(address indexed from, uint256 timestamp, string message);

    mapping(address => uint) public numberOfWaveFromAddress;

    // What a basic wave will construct of:
    struct Wave {
      address waver; // address of the waver
      string message; // the message user sent
      uint256 timestamp; // timestamp when user waved
    }

    // A place to store all the "wave" inside the waves
    Wave[] waves;

    constructor() {
      console.log("What is life, slit my throat and whatch me bleed in hopes that 1 btc will come down my way");
    }

    function wave(string memory _message) public {
      totalWaves++;

      numberOfWaveFromAddress[msg.sender]++;

      waves.push(Wave(msg.sender, _message, block.timestamp));

      emit newWave(msg.sender, block.timestamp, _message);

      console.log('%s has waved and left a %s', msg.sender, _message);
    }

    function getTotalWaves() public view returns(uint256){
      console.log("The total amount of waves are: ", totalWaves);
      return totalWaves;
    }

    // This will give use array of waves
    function getAllWaves() public view returns(Wave[] memory){
      return waves;
    }

    function userStatus(address usr) public view returns(uint) {
      uint numberOfWaves = numberOfWaveFromAddress[usr];
      console.log("%s had waved %d times", usr , numberOfWaves);
      return numberOfWaves;
    }

}