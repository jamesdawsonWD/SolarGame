// SPDX-License-Identifier: MIT

pragma solidity ^0.6.2;

interface ITreasury {
    function sendSats(
        address _to,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) external;

    function recieveSats(
        address _from,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) external;

    function mintFhr(address _to, uint256 _tokenId) external;
}
