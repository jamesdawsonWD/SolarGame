const EternalStorageC = artifacts.require('../../contracts/EternalStorage.sol');
const TypesLib = artifacts.require('../../contracts/lib/Types.sol');
const TestFhr = artifacts.require(
    '../../contracts/testing/TestFederalHarvestingRights.sol'
);
const TestSolar = artifacts.require('../../contracts/testing/TestSolar.sol');
const TestSat = artifacts.require(
    '../../contracts/testing/TestShipsAndTechnology.sol'
);
const TreasuryC = artifacts.require('../../contracts/Treasury.sol');
const helpers = require('./helpers.js');
const GameStorageC = artifacts.require('../../contracts/GameStorage.sol');
const GameOperationsC = artifacts.require('../../contracts/GameOperations.sol');
const ConstantsC = artifacts.require('../../contracts/Constants.sol');
const {
    WEAK_FLEET,
    AVERAGE_FLEET,
    STRONG_FLEET
} = require('./testValuesCommon.js');
const deploy = async accounts => {
    const EternalStorage = await EternalStorageC.new();

    const [FHR, Solar, Constants] = await Promise.all([
        TestFhr.new(EternalStorage.address),
        TestSolar.new(EternalStorage.address),
        ConstantsC.new(EternalStorage.address)
    ]);

    const Treasury = await TreasuryC.new(EternalStorage.address);
    const Sat = await TestSat.new(EternalStorage.address, Treasury.address);

    const GameStorage = await GameStorageC.new();
    const GameOperations = await GameOperationsC.new(GameStorageC.address);

    await Promise.all([
        EternalStorage.setBool(
            web3.utils.soliditySha3(
                'contract.exists' + GameOperationsC.address
            ),
            true
        ),
        EternalStorage.setBool(
            web3.utils.soliditySha3(`contract.exists${Treasury.address}`),
            true
        ),
        EternalStorage.setBool(
            web3.utils.soliditySha3(`contract.exists${FHR.address}`),
            true
        ),
        EternalStorage.setBool(
            web3.utils.soliditySha3(`contract.exists${Sat.address}`),
            true
        ),
        EternalStorage.setBool(
            web3.utils.soliditySha3(`contract.exists${Solar.address}`),
            true
        ),
        EternalStorage.setAddress(
            web3.utils.soliditySha3(`contract.address.gameoperations`),
            GameOperations.address
        ),
        EternalStorage.setAddress(
            web3.utils.soliditySha3(`contract.address.treasury`),
            Treasury.address
        ),
        EternalStorage.setAddress(
            web3.utils.soliditySha3(`contract.address.fhr`),
            FHR.address
        ),
        EternalStorage.setAddress(
            web3.utils.soliditySha3(`contract.address.sats`),
            Sat.address
        ),
        EternalStorage.setAddress(
            web3.utils.soliditySha3(`contract.address.solar`),
            Solar.address
        ),
        EternalStorage.setBool(
            web3.utils.soliditySha3('fhr.access', Treasury.address),
            true
        ),
        EternalStorage.setAddress(
            web3.utils.soliditySha3(`solar.access${Solar.address}`),
            Solar.address
        )
    ]);

    await GameStorage.initialize(EternalStorage.address);
    await Treasury.initialize(EternalStorage.address);
    await GameOperations.initialize(GameStorage.address);

    for (const account of accounts) {
        await Solar.testMint(account, 1000000000, { from: accounts[0] });
    }

    for (const [key, value] of Object.entries(WEAK_FLEET)) {
        await Treasury.sendSats(accounts[1], [key], [value]);
    }
    for (const [key, value] of Object.entries(AVERAGE_FLEET)) {
        await Treasury.sendSats(accounts[2], [key], [value]);
    }
    for (const [key, value] of Object.entries(STRONG_FLEET)) {
        await Treasury.sendSats(accounts[3], [key], [value]);
    }
    await Promise.all([
        Sat.setApprovalForAll(Treasury.address, true, {
            from: accounts[1]
        }),
        Sat.setApprovalForAll(Treasury.address, true, {
            from: accounts[2]
        }),
        Sat.setApprovalForAll(Treasury.address, true, {
            from: accounts[3]
        })
    ]);
    for (const account of accounts) {
        await helpers.setAllowance(
            Solar,
            account,
            Treasury.address,
            1000000000
        );
    }

    return {
        GameOperations,
        GameStorage,
        EternalStorage,
        FHR,
        Sat,
        Solar,
        Treasury
    };

    // deployProxy(GameOperations, [GameStorage.address], {
    //     deployer
    // }),
    // await deployProxy(GameStorage, [EternalStorage.address], {
    //     deployer
    // });
};

module.exports = {
    deploy
};
