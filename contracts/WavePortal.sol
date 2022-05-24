// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;
    uint256 private seed;

    event newWave(address indexed from, uint256 timestamp, string message);

    mapping(address => uint) public numberOfWaveFromAddress;
    mapping(address => uint) public lastWavedAt;

    // What a basic wave will construct of:
    struct Wave {
      address waver; // address of the waver
      string message; // the message user sent
      uint256 timestamp; // timestamp when user waved
    }

    // A place to store all the "wave" inside the waves
    Wave[] waves;

    constructor() payable{
      console.log("What is life, slit my throat and whatch me bleed in hopes that 1 btc will come down my way");
      // Create intial seed speed
      seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
      // Checks to see if has been 30 sec or more for user
      require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");
      // update current type stamp
      lastWavedAt[msg.sender] = block.timestamp;

      totalWaves++;
      numberOfWaveFromAddress[msg.sender]++;
      waves.push(Wave(msg.sender, _message, block.timestamp));

      // Generate a new seed
      seed = (block.difficulty + block.timestamp + seed) % 100;

      // Generate a new seed
      seed = (block.timestamp + block.difficulty) % 100;
      console.log("random seed generated: ", seed);

      if(seed <= 49){
        uint256 prizeAmount = 0.0001 ether;
        require(prizeAmount <= address(this).balance, "trying to withdrawl more than there is inside contract");
        console.log('Congrazt %s has won prize', msg.sender);
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");

      }

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