// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IEDXVRFCoordinator {
    function requestRandomNumber(string memory seed, uint256 numWords) external returns (uint256);
    function fulfillRandomNumber(uint256 requestId, uint256[] memory randomNumbers) external;
}