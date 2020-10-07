const { isDevNetwork, isKovan, isMainNet } = require('./helpers');
const Web3 = require('web3');
const { deployProxy } = require('@openzeppelin/truffle-upgrades');
// Contracts
const EternalStorage = artifacts.require('EternalStorage');
const GameOperations = artifacts.require('GameOperations');
const FHR = artifacts.require('FederalHarvestingRights');
const SolarToken = artifacts.require('SolarToken');
const ShipsAndTechnology = artifacts.require('ShipsAndTechnology');
const Treasury = artifacts.require('Treasury');
const GameStorage = artifacts.require('GameStorage');
const TypesLib = artifacts.require('Types');
const Constants = artifacts.require('Constants');
// Testing Contracts
const TestFhr = artifacts.require('TestFederalHarvestingRights.sol');
const TestSolar = artifacts.require('TestSolar.sol');
const TestShipsAndTechnology = artifacts.require('TestShipsAndTechnology.sol');

async function deployBaseProtocol(deployer, network) {
    const fhr = isDevNetwork(network) ? TestFhr : FHR;
    const solar = isDevNetwork(network) ? TestSolar : SolarToken;
    const sat = isDevNetwork(network)
        ? TestShipsAndTechnology
        : ShipsAndTechnology;

    await Promise.all([
        deployer.deploy(EternalStorage),
        deployer.deploy(TypesLib)
    ]);
    await deployer.deploy(Constants, EternalStorage.address);
    await deployer.deploy(Treasury, EternalStorage.address);
    await deployer.deploy(fhr, EternalStorage.address);
    await deployer.deploy(solar, EternalStorage.address);
    await deployer.deploy(sat, EternalStorage.address, Treasury.address);

    await Promise.all([
        deployer.link(TypesLib, GameStorage),
        deployer.link(TypesLib, GameOperations)
    ]);

    // deployProxy(GameOperations, [GameStorage.address], {
    //     deployer
    // }),
    // await deployProxy(GameStorage, [EternalStorage.address], {
    //     deployer
    // });
    await deployer.deploy(GameStorage, EternalStorage.address);
    await deployer.deploy(GameOperations, GameStorage.address);

    const esD = await EternalStorage.deployed();
    await Promise.all([
        esD.setBool(
            Web3.utils.soliditySha3('contract.exists' + GameOperations.address),
            true
        ),
        esD.setBool(
            Web3.utils.soliditySha3(`contract.exists${Treasury.address}`),
            true
        ),
        esD.setBool(
            Web3.utils.soliditySha3(`contract.exists${fhr.address}`),
            true
        ),
        esD.setBool(
            Web3.utils.soliditySha3(`contract.exists${sat.address}`),
            true
        ),
        esD.setBool(
            Web3.utils.soliditySha3(`contract.exists${solar.address}`),
            true
        ),
        esD.setAddress(
            Web3.utils.soliditySha3(`contract.address.gameoperations`),
            GameOperations.address
        ),
        esD.setAddress(
            Web3.utils.soliditySha3(`contract.address.treasury`),
            Treasury.address
        ),
        esD.setAddress(
            Web3.utils.soliditySha3(`contract.address.fhr`),
            fhr.address
        ),
        esD.setAddress(
            Web3.utils.soliditySha3(`contract.address.sat`),
            sat.address
        ),
        esD.setAddress(
            Web3.utils.soliditySha3(`contract.address.solar`),
            solar.address
        ),
        esD.setAddress(
            Web3.utils.soliditySha3(`fhr.access${Treasury.address}`),
            solar.address
        )
    ]);
}

module.exports = async function(deployer, network) {
    await deployBaseProtocol(deployer, network);
};
