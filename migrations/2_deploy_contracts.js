const { isDevNetwork, isKovan, isMainNet } = require('./helpers');

// Contracts
const Master = artifacts.require('Master');
const FundOperations = artifacts.require('FundOperations');
const GameOperations = artifacts.require('GameOperations');
const TsunoToken = artifacts.require('TsunoToken');

// Testing Contracts
const TestMaster = artifacts.require('TestMaster.sol');
const TestTsuno = artifacts.require('TestTsuno.sol');

async function deployBaseProtocol(deployer, network, accounts) {
    const tsuno = isDevNetwork(network) ? TestTsuno : TsunoToken;
    await deployer.deploy(tsuno, accounts);
    await Promise.all([
        deployer.deploy(FundOperations),
        deployer.deploy(GameOperations)
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
    tsuno.deployed().then(instance => instance.setOperator(master.address));
}
module.exports = async function(deployer, network, accounts) {
    await deployBaseProtocol(deployer, network, accounts);
};
