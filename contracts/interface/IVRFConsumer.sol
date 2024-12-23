// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IVRFConsumer {
    function receiveRandomNumbers(uint256 requestId, uint256[] memory randomNumbers) external;
    function requestRandomNumber(string memory seed, uint256 numWords) external ;
    function ViewRandom() external  view returns (uint256[] memory) ;
}