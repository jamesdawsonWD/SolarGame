const { isDevNetwork, isKovan, isMainNet } = require('./helpers');
const Web3 = require('web3');
const { deployProxy } = require('@openzeppelin/truffle-upgrades');
// Contracts
const EternalStorage = artifacts.require('EternalStorage');
const GameOperationsC = artifacts.require('GameOperations');
const FHR = artifacts.require('FederalHarvestingRights');
const SolarToken = artifacts.require('SolarToken');
const ShipsAndTechnology = artifacts.require('ShipsAndTechnology');
const Treasury = artifacts.require('Treasury');
const GameStorage = artifacts.require('GameStorage');
const TypesLib = artifacts.require('Types');
const Constants = artifacts.require('Constants');
const TestFhr = artifacts.require('TestFederalHarvestingRights.sol');
const TestSolar = artifacts.require('TestSolar.sol');
const TestShipsAndTechnology = artifacts.require('TestShipsAndTechnology.sol');
const TestGameOperations = artifacts.require('TestGameOperations.sol');
// Testing Contracts

async function deployBaseProtocol(deployer, network, accounts) {
    const Solar = isDevNetwork(network) ? TestSolar : SolarToken;
    const Sat = isDevNetwork(network) ? TestShipsAndTechnology : ShipsAndTechnology;
    const GameOperations = isDevNetwork(network) ? TestGameOperations : GameOperationsC;

    await deployer.deploy(EternalStorage);
    const esD = await EternalStorage.deployed();

    await deployer.deploy(TypesLib);
    await deployer.deploy(Constants, EternalStorage.address);
    await deployer.deploy(Solar, EternalStorage.address);
    await deployer.deploy(Treasury, EternalStorage.address);
    await deployer.deploy(Sat, EternalStorage.address, Treasury.address);
    await deployer.deploy(FHR, EternalStorage.address);

    await Promise.all([
        deployer.link(TypesLib, GameStorage),
        deployer.link(TypesLib, GameOperations)
    ]);

    await deployer.deploy(GameStorage, EternalStorage.address);
    await deployer.deploy(GameOperations, GameStorage.address);

    await Promise.all([
        esD.setBool(Web3.utils.soliditySha3('contract.exists', GameOperations.address), true),
        esD.setBool(web3.utils.soliditySha3('contract.exists', Treasury.address), true),
        esD.setBool(web3.utils.soliditySha3('contract.exists', FHR.address), true),
        esD.setBool(web3.utils.soliditySha3('contract.exists', Sat.address), true),
        esD.setBool(web3.utils.soliditySha3('contract.exists', Solar.address), true),
        esD.setAddress(
            Web3.utils.soliditySha3(`contract.address.gameoperations`),
            GameOperations.address
        ),
        esD.setAddress(Web3.utils.soliditySha3(`contract.address.treasury`), Treasury.address),
        esD.setAddress(Web3.utils.soliditySha3(`contract.address.fhr`), FHR.address),
        esD.setAddress(Web3.utils.soliditySha3(`contract.address.sat`), Sat.address),
        esD.setAddress(Web3.utils.soliditySha3(`contract.address.solar`), Solar.address),
        esD.setBool(Web3.utils.soliditySha3('fhr.access', Treasury.address), true),
        esD.setBool(
            Web3.utils.soliditySha3('fhr.access', isDevNetwork(network) ? accounts[0] : ''),
            true
        )
    ]);

    const [GameStorageD, TreasuryD, GameOperationsD] = await Promise.all([
        GameStorage.deployed(),
        Treasury.deployed(),
        GameOperations.deployed()
    ]);
    await GameStorageD.initialize(esD.address);
    await TreasuryD.initialize(esD.address);
    await GameOperationsD.initialize(GameStorage.address);
    await GameOperationsD.setSeed(1927367382);
}

module.exports = async function(deployer, network, accounts) {
    await deployBaseProtocol(deployer, network, accounts);
};
