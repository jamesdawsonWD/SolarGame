// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

interface ITsuno {
    function transfer(address dst, uint256 wad) external returns (bool);

    function balanceOf(address guy) external view returns (uint256);
}
