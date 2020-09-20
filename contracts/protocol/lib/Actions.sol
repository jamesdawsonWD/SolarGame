// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Types} from "./Types.sol";

/**
 * @title Actions
 * @author Big Beluga
 *
 * Library that defines and parses valid Actions
 */
library Actions {
    // ============ Enums ============
    // enum ActionType {
    //     Fund, // deposit tokens to your balance
    //     Withdraw, // withdraw tokens from your balance
    //     Buy, // invest tokens in a trader's equity share
    //     Close, // close investments from a trader's equity share
    //     Transfer // transfer balance between accounts
    // }
    // // ============ Structs ============
    // /*
    //  * Arguments that are passed to the protocol in an ordered list as part of a single operation.
    //  */
    // struct ActionArgs {
    //     ActionType actionType;
    //     address account;
    //     address otherAddress;
    //     uint256 amount;
    //     bytes data;
    // }
    // // ============ Action Types ============
    // /*
    //  * Deposit Args for adding tokens to an account balance from a specific address.
    //  */
    // struct FundArgs {
    //     uint256 amount;
    //     address account;
    //     address pool;
    // }
    // /*
    //  * Withdraws tokens from an account balance and send them to an address
    //  */
    // struct WithdrawArgs {
    //     uint256 amount;
    //     address account;
    //     address to;
    // }
    // /*
    //  * Transfers balance between two accounts. T
    //  */
    // struct TransferArgs {
    //     uint256 amount;
    //     address account;
    //     address to;
    // }
    // /*
    //  * Invest an amount in the trader to trade with on your behalf.
    //  */
    // struct BuyArgs {
    //     uint256 amount;
    //     address account;
    //     address trader;
    // }
    // /*
    //  * Close an investment with a trader and return the money to the senders balance.
    //  */
    // struct CloseArgs {
    //     uint256 amount;
    //     address account;
    //     address trader;
    // }
    // // ============ Parsing Functions ============
    // function parseFundArgs(ActionArgs memory args)
    //     internal
    //     pure
    //     returns (FundArgs memory)
    // {
    //     assert(args.actionType == ActionType.Fund);
    //     return
    //         FundArgs({
    //             amount: args.amount,
    //             account: args.account,
    //             from: args.otherAddress
    //         });
    // }
    // function parseWithdrawArgs(ActionArgs memory args)
    //     internal
    //     pure
    //     returns (WithdrawArgs memory)
    // {
    //     assert(args.actionType == ActionType.Withdraw);
    //     return
    //         WithdrawArgs({
    //             amount: args.amount,
    //             account: args.account,
    //             to: args.otherAddress
    //         });
    // }
    // function parseTransferArgs(ActionArgs memory args)
    //     internal
    //     pure
    //     returns (TransferArgs memory)
    // {
    //     assert(args.actionType == ActionType.Transfer);
    //     return
    //         TransferArgs({
    //             amount: args.amount,
    //             account: args.account,
    //             to: args.otherAddress
    //         });
    // }
    // function parseInvestArgs(ActionArgs memory args)
    //     internal
    //     pure
    //     returns (InvestArgs memory)
    // {
    //     assert(args.actionType == ActionType.Invest);
    //     return
    //         InvestArgs({
    //             amount: args.amount,
    //             account: args.account,
    //             trader: args.otherAddress
    //         });
    // }
    // function parseCloseArgs(ActionArgs memory args)
    //     internal
    //     pure
    //     returns (CloseArgs memory)
    // {
    //     assert(args.actionType == ActionType.Close);
    //     return
    //         CloseArgs({
    //             amount: args.amount,
    //             account: args.account,
    //             trader: args.otherAddress
    //         });
    // }
    // function parseTradeArgs(ActionArgs memory args)
    //     internal
    //     pure
    //     returns (TradeArgs memory)
    // {
    //     assert(args.actionType == ActionType.Trade);
    //     return
    //         TradeArgs({
    //             amount: args.amount,
    //             trader: args.account,
    //             tradeData: args.data
    //         });
    // }
}
