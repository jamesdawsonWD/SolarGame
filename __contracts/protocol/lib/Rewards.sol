// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

/**
 * @title Exchange
 * @author Big Beluga
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library Rewards {
    // ============ Constants ============

    bytes32 constant FILE = 'Reward';
    uint256 constant BONUS_MULTIPLIER = 10;
    uint256 constant BONUS_PERCENT = 40;
    uint256 constant BONUS_CAP_PERCENT = 200;
    uint256 constant DAY_REWARD = (364 * 100) / BONUS_PERCENT;
    uint256 constant CAP_DAYS = (DAY_REWARD * BONUS_CAP_PERCENT) / 100;
    uint256 constant SUN_PER_TSUNO = 10**uint256(18);
    uint256 constant TSUNO_BONUS_PERCENT = 10;
    uint256 constant TSUNO_CAP = 150 * 1e6;
    uint256 constant HOLD_CAP_IN_SUN = TSUNO_CAP * SUN_PER_TSUNO;
    uint256 constant HOLD_REWARD = (HOLD_CAP_IN_SUN * 100) / TSUNO_BONUS_PERCENT;

    // ============ Library Functions ============

    function calculateReward(uint256 stakedTsuno, uint256 stakedDays) internal returns (uint256) {
        uint256 cappedExtraDays = 0;

        /* Must be more than 1 day for Longer-Pays-Better */
        if (stakedDays > 1) {
            cappedExtraDays = stakedDays <= CAP_DAYS ? stakedDays - 1 : CAP_DAYS;
        }

        uint256 cappedStakedTsuno = stakedDays <= TSUNO_CAP ? stakedTsuno : TSUNO_CAP;

        uint256 combinedAmount = cappedExtraDays * HOLD_REWARD + cappedStakedTsuno * DAY_REWARD;
        combinedAmount = (stakedTsuno * combinedAmount) / (DAY_REWARD * HOLD_REWARD);

        return combinedAmount;
    }
}
