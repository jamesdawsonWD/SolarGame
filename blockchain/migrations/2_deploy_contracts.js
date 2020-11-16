const { isDevNetwork, isKovan, isMainNet } = require('./helpers');
const Web3 = require('web3');
const { deployProxy } = require('@openzeppelin/truffle-upgrades');
// Contracts
const EternalStorage = artifacts.require('EternalStorage');
const GameOperationsC = artifacts.require('GameOperations');
const PlanetsToken = artifacts.require('Planets');
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
const GameEvents = artifacts.require('GameEvents.sol');
const GE_DiscoverPlanet = artifacts.require('GE_DiscoverPlanet');
const Traverse = artifacts.require('Traverse.sol');

async function deployBaseProtocol(deployer, network, accounts) {
    // const Sat = isDevNetwork(network) ? TestShipsAndTechnology : ShipsAndTechnology;
    // const GameOperations = isDevNetwork(network) ? TestGameOperations : GameOperationsC;
    // const Treasury = isDevNetwork(network) ? TestTreasury : TreasuryC;
    const Sat = TestShipsAndTechnology;
    const GameOperations = TestGameOperations;
    const Treasury = TestTreasury;

    await deployer.deploy(GE_DiscoverPlanet);
    await deployer.deploy(TypesLib);
    await deployer.deploy(Treasury);
    await deployer.deploy(Solar, Treasury.address);
    await deployer.deploy(Sat, Treasury.address);
    await deployer.deploy(PlanetsToken, Treasury.address);
    await deployer.deploy(Planet);
    await deployer.deploy(Traverse);
    await deployer.deploy(GameEvents);

    await Promise.all([deployer.link(TypesLib, GameStorage), deployer.link(TypesLib, GameOperations)]);

    await deployer.deploy(GameStorage);
    await deployer.deploy(PlanetManager);

    const [GameStorageD, TreasuryD, GameEventsD, TraverseD, PlanetManagerD] = await Promise.all([
        GameStorage.deployed(),
        Treasury.deployed(),
        GameEvents.deployed(),
        Traverse.deployed(),
        PlanetManager.deployed()
    ]);
    await GameStorageD.initialize(
        Solar.address,
        Sat.address,
        PlanetsToken.address,
        Treasury.address,
        Traverse.address,
        PlanetManager.address,
        GameOperations.address,
        GameEvents.address
    );
    await TreasuryD.initialize(
        PlanetsToken.address,
        Solar.address,
        Sat.address,
        GameOperations.address,
        PlanetManager.address
    );

    await PlanetManagerD.initialize(GameStorage.address);
    await TraverseD.initialize(GameStorage.address);
    await GameEventsD.initialize(GameStorage.address);
    await GameEventsD.add(GE_DiscoverPlanet.address);
}

module.exports = async function(deployer, network, accounts) {
    await deployBaseProtocol(deployer, network, accounts);
};
