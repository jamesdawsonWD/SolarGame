const TestMaster = artifacts.require('../../contracts/testing/TestMaster.sol');
const TestTsuno = artifacts.require('../../contracts/testing/TestTsuno.sol');
const helpers = require('./helpers.js');

const deploy = async accounts => {
    const Tsuno = await TestTsuno.new();
    // ETH = await TokenB.new();

    for (const account of accounts) {
        await Tsuno.testMint(account, 1000000000, { from: accounts[0] });
    }

    console.log(Tsuno.address);
    const Master = await TestMaster.new(Tsuno.address);

    Tsuno.setOperator(Master.address);
    for (const account of accounts) {
        await helpers.setAllowance(Tsuno, account, Master.address, 1000000000);
    }

    return [Master, Tsuno];
};

module.exports = {
    deploy
};
