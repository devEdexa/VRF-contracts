// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IEdxVRFCoordinator.sol";
import "./IVRFConsumer.sol";
contract Consumer is IVRFConsumer{
    IEdxVRFCoordinator public vrfCoordinator;

    // Event to notify when random numbers are received
    event RandomNumbersReceived(uint256 requestId, uint256[] randomNumbers);

    
    uint256[] internal  random;

    constructor(address coordinatorAddress) {
        vrfCoordinator = IEdxVRFCoordinator(coordinatorAddress);
    }

    function requestRandomNumber(string memory seed, uint256 numWords) external override  {
         vrfCoordinator.requestRandomNumber(seed, numWords); //request random through coordinator contract
    }

    function receiveRandomNumbers(uint256 requestId, uint256[] memory randomNumbers) external override {
        // Ensure that only the coordinator can call this function
         require(msg.sender == address(vrfCoordinator), "Only VRF Coordinator can call this");
        // Replace the current random numbers with the new ones
        random = randomNumbers;
        emit RandomNumbersReceived(requestId, randomNumbers);
    }

     function ViewRandom() public  view returns (uint256[] memory) {
        return random; 
    }

}