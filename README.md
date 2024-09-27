
# VRF-contracts

## About

The VRF contract are part of edexa VRF setup which is used to create secure random numbers

## How to use


1. clone the repo

```javascript
git clone "https://github.com/nishil-edx/VRF-contracts"
```

2. use remix/hardhat to deploy consumer contract

3. use coordinator address in consumer constructor  which deployed for edexa testnet

```
0x86d47638A8287F058190A2197f085EDCEdF984DA
```

3.  you can make custom versions of consumer contracts but make sure it inherit IVRFConsumer interface

4. call RequestrandomNumbers() function with any random seed of your choice and total number of random needed . Note 100 is the max limit 

5. wait for few seconds for the oracle to call back your contract, and use viewRandom() function to check the result the random numbers will be replace by each call

