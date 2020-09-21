const {
    isDevNetwork,
    isKovan,
    isMainNet
} = require('./helpers');

// Contracts
const Master = artifacts.require('Master');
const FundOperations = artifacts.require('FundOperations');
const GameOperations = artifacts.require('GameOperations');
const TsunoToken = artifacts.require('TsunoToken');

// Testing Contracts
const TestMaster = artifacts.require('TestMaster.sol');
const TestTsuno = artifacts.require('TestTsuno.sol');

module.exports = async function (deployer, network, accounts) {
    await deployBaseProtocol(deployer, network);
};

async function deployBaseProtocol(deployer, network) {
    const tsuno = isDevNetwork(network) ? TestTsuno : TsunoToken;
    await Promise.all([
        deployer.deploy(FundOperations),
        deployer.deploy(GameOperations),
        deployer.deploy(tsuno)
    ]);

    let master;
    if (isDevNetwork(network)) {
        master = TestMaster;
    } else if (isKovan(network) || isMainNet(network)) {
        master = Master;
    } else {
        throw new Error('Cannot deploy SoloMargin');
    }

    await Promise.all([
        master.link('FundOperations', FundOperations.address),
        master.link('GameOperations', GameOperations.address)
    ]);
    await deployer.deploy(master, tsuno.address);
    await tsuno
        .deployed()
        .then(instance => instance.setOperator(master.address));
}

function getDaiAddress(network) {
    if (isDevNetwork(network)) {
        return TokenB.address;
    }
    if (isMainNet(network)) {
        return '0x6b175474e89094c44da98b954eedeac495271d0f';
    }
    if (isKovan(network)) {
        return '0x5944413037920674d39049ec4844117a031eaa74';
    }
    throw new Error('Cannot find Dai');
}
