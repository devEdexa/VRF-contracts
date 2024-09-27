// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface IEdxVRFCoordinator {
    function requestRandomNumber(string memory seed, uint256 numWords) external returns (uint256);
    function fulfillRandomNumber(uint256 requestId, uint256[] memory randomNumbers) external;
}