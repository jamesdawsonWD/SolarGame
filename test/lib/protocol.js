const TestMaster = artifacts.require('../../contracts/testing/TestMaster.sol');
const TestFhr = artifacts.require(
    '../../contracts/testing/TestFederalHarvestingRights.sol'
);
const TestSolar = artifacts.require('../../contracts/testing/TestSolar.sol');
const TestSat = artifacts.require(
    '../../contracts/testing/TestShipsAndTechnology.sol'
);
const helpers = require('./helpers.js');

const deploy = async accounts => {
    const Master = await TestMaster.new();
    const FHR = await TestFhr.new(Master.address);
    const Solar = await TestSolar.new(Master.address);
    const Sat = await TestSat.new(Master.address);

    Master.setSATsAddress(Sat.address);
    Master.setFHRAddress(FHR.address);
    Master.setSolarAddress(Solar.address);

    for (const account of accounts) {
        await Solar.testMint(account, 1000000000, { from: accounts[0] });
    }
    for (const account of accounts) {
        await helpers.setAllowance(Solar, account, Master.address, 1000000000);
    }

    return [Master, FHR, Sat, Solar];
};

module.exports = {
    deploy
};
