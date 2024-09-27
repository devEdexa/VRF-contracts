// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./IEdxVRFCoordinator.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


interface IConsumer {
    function receiveRandomNumbers(uint256 requestId, uint256[] memory randomNumbers) external;
}

contract edxVRFCoordinator is IEdxVRFCoordinator {
    using Counters for Counters.Counter;
    
    Counters.Counter private _requestIdCounter;
    
    struct RandomRequest {
        string seed; // The user given random input string used for randomness
        address consumer; // The address of the consumer contract
        uint256[] randomNumbers; // Array to hold multiple random numbers
        bool fulfilled; // Status of the request
    }

    mapping(uint256 => RandomRequest) public requests;

    event RandomNumberRequested(uint256 requestId, string seed, address consumer,uint256 numWords);
    event RandomNumberFulfilled(uint256 requestId, uint256[] randomNumbers);

    function requestRandomNumber(string memory seed, uint256 numWords) external override returns (uint256) {
        require(numWords<=100,"max number of random numbers per request is 100");
        _requestIdCounter.increment();
        uint256 requestId = _requestIdCounter.current();

        requests[requestId] = RandomRequest({
            seed: seed,
            consumer: msg.sender, // Store the consumer's address
            randomNumbers: new uint256[](numWords), // Initialize the array with size numWords
            fulfilled: false //initial value 
        });

        emit RandomNumberRequested(requestId, seed, msg.sender,numWords);
        return requestId;
    }

    function fulfillRandomNumber(uint256 requestId, uint256[] memory randomNumbers) external override {
        require(requests[requestId].consumer != address(0), "Request does not exist");
        require(!requests[requestId].fulfilled, "Request already fulfilled");
        require(randomNumbers.length == requests[requestId].randomNumbers.length, "Invalid number of random values");

        requests[requestId].randomNumbers = randomNumbers; 
        requests[requestId].fulfilled = true;
        // Call the consumer's callback function to provide random number
        IConsumer(requests[requestId].consumer).receiveRandomNumbers(requestId, randomNumbers);
        emit RandomNumberFulfilled(requestId, randomNumbers);
         
    }



}