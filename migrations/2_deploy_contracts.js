// const { isDevNetwork, isKovan, isMainNet } = require('./helpers');

// // Contracts
// const Master = artifacts.require('Master');
// const FundOperations = artifacts.require('FundOperations');
// const GameOperations = artifacts.require('GameOperations');
// const TsunoToken = artifacts.require('TsunoToken');
// const SolarToken = artifacts.require('SolarToken');
// const ShipsAndTechnology = artifacts.require('ShipsAndTechnology');

// // Testing Contracts
// const TestMaster = artifacts.require('TestMaster.sol');
// const TestTsuno = artifacts.require('TestTsuno.sol');
// const TestSolar = artifacts.require('TestSolar.sol');
// const TestShipsAndTechnology = artifacts.require('TestShipsAndTechnology.sol');

// async function deployBaseProtocol(deployer, network) {
//     const tsuno = isDevNetwork(network) ? TestTsuno : TsunoToken;
//     const solar = isDevNetwork(network) ? TestSolar : SolarToken;
//     const sat = isDevNetwork(network)
//         ? TestShipsAndTechnology
//         : ShipsAndTechnology;

//     await Promise.all([
//         deployer.deploy(FundOperations),
//         deployer.deploy(GameOperations),
//         deployer.deploy(tsuno),
//         deployer.deploy(solar),
//         deployer.deploy(sat)
//     ]);

//     let master;
//     if (isDevNetwork(network)) {
//         master = TestMaster;
//     } else if (isKovan(network) || isMainNet(network)) {
//         master = Master;
//     } else {
//         throw new Error('Cannot deploy Master');
//     }

//     await Promise.all([
//         master.link('FundOperations', FundOperations.address),
//         master.link('GameOperations', GameOperations.address)
//     ]);
//     await deployer.deploy(master, tsuno.address, solar.address, sat.address);
//     await tsuno
//         .deployed()
//         .then(instance => instance.setOperator(master.address));

//     await solar
//         .deployed()
//         .then(instance => instance.setOperator(master.address));

//     await sat.deployed().then(instance => instance.setOperator(master.address));
// }

// module.exports = async function(deployer, network) {
//     await deployBaseProtocol(deployer, network);
// };

const { isDevNetwork, isKovan, isMainNet } = require('./helpers');

// Contracts
const Master = artifacts.require('Master');
const FundOperations = artifacts.require('FundOperations');
const GameOperations = artifacts.require('GameOperations');
const FHR = artifacts.require('FederalHarvestingRights');
const SolarToken = artifacts.require('SolarToken');
const ShipsAndTechnology = artifacts.require('ShipsAndTechnology');
const TimeLock = artifacts.require('TimeLock');
// Testing Contracts
const TestMaster = artifacts.require('TestMaster.sol');
const TestFhr = artifacts.require('TestFederalHarvestingRights.sol');
const TestSolar = artifacts.require('TestSolar.sol');
const TestShipsAndTechnology = artifacts.require('TestShipsAndTechnology.sol');

async function deployBaseProtocol(deployer, network) {
    const fhr = isDevNetwork(network) ? TestFhr : FHR;
    const solar = isDevNetwork(network) ? TestSolar : SolarToken;
    const sat = isDevNetwork(network)
        ? TestShipsAndTechnology
        : ShipsAndTechnology;
    let master;
    if (isDevNetwork(network)) {
        master = TestMaster;
    } else if (isKovan(network) || isMainNet(network)) {
        master = Master;
    } else {
        throw new Error('Cannot deploy Master');
    }

    Promise.all([
        deployer.deploy(FundOperations),
        deployer.deploy(GameOperations)
    ])
        .then(() =>
            Promise.all([
                master.link('FundOperations', FundOperations.address),
                master.link('GameOperations', GameOperations.address)
            ])
        )
        .then(() =>
            Promise.all([
                deployer.deploy(fhr),
                deployer.deploy(solar),
                deployer.deploy(sat),
                deployer.deploy(TimeLock)
            ])
        )
        .then(() => deployer.deploy(master))
        .then(() =>
            Promise.all([
                Master.setSATsAddress(sat.address),
                Master.setFHRAddress(fhr.address),
                Master.setSolarAddress(solar.address),
                Master.setTimeLockAddress(TimeLock.address)
            ])
        )
        .catch(err => console.log(new Error(err)));
}

module.exports = async function(deployer, network) {
    await deployBaseProtocol(deployer, network);
};
