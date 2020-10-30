const { isDevNetwork, isKovan, isMainNet } = require('./helpers');
const Web3 = require('web3');
const { deployProxy } = require('@openzeppelin/truffle-upgrades');
// Contracts
const EternalStorage = artifacts.require('EternalStorage');
const GameOperationsC = artifacts.require('GameOperations');
const FHR = artifacts.require('FederalHarvestingRights');
const Solar = artifacts.require('SolarToken');
const ShipsAndTechnology = artifacts.require('ShipsAndTechnology');
const TreasuryC = artifacts.require('Treasury');
const GameStorage = artifacts.require('GameStorage');
const TypesLib = artifacts.require('Types');
const PlanetManager = artifacts.require('PlanetManager');
const Planet = artifacts.require('Planet');
const TestShipsAndTechnology = artifacts.require('TestShipsAndTechnology.sol');
const TestGameOperations = artifacts.require('TestGameOperations.sol');
const TestTreasury = artifacts.require('TestTreasury.sol');

// Testing Contracts

async function deployBaseProtocol(deployer, network, accounts) {
    // const Sat = isDevNetwork(network) ? TestShipsAndTechnology : ShipsAndTechnology;
    // const GameOperations = isDevNetwork(network) ? TestGameOperations : GameOperationsC;
    // const Treasury = isDevNetwork(network) ? TestTreasury : TreasuryC;
    const Sat = TestShipsAndTechnology;
    const GameOperations = TestGameOperations;
    const Treasury = TestTreasury;
    g;
    await deployer.deploy(TypesLib);
    await deployer.deploy(Treasury);
    await deployer.deploy(Solar, Treasury.address);
    await deployer.deploy(Sat, Treasury.address);
    await deployer.deploy(FHR, Treasury.address);
    await deployer.deploy(Planet);
    await Promise.all([deployer.link(TypesLib, GameStorage), deployer.link(TypesLib, GameOperations)]);

    await deployer.deploy(GameStorage);
    await deployer.deploy(GameOperations);
    await deployer.deploy(PlanetManager, Planet.address, GameOperations.address, Treasury.address);

    const [GameStorageD, TreasuryD, GameOperationsD] = await Promise.all([
        GameStorage.deployed(),
        Treasury.deployed(),
        GameOperations.deployed()
    ]);
    await GameStorageD.initialize(
        Solar.address,
        Sat.address,
        FHR.address,
        Treasury.address,
        PlanetManager.address,
        GameOperations.address
    );
    await TreasuryD.initialize(
        FHR.address,
        Solar.address,
        Sat.address,
        GameOperations.address,
        PlanetManager.address
    );
    await GameOperationsD.initialize(GameStorage.address);
    await GameOperationsD.setSeed(1927367382);
}

module.exports = async function(deployer, network, accounts) {
    await deployBaseProtocol(deployer, network, accounts);
};
