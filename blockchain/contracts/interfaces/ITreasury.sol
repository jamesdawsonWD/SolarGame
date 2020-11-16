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

    function mintPlanet(address _to, uint256 _tokenId) external;

    function recievePlanet(address _from, uint256 _tokenId) external;

    function sendPlanet(address _to, uint256 _tokenId) external;

    function mintSolar(address _to, uint256 _amount) external;

    function sendSolar(address _to, uint256 _amount) external;

    function sendSolarReward(
        address _to,
        uint256 _amount,
        uint256 _reward
    ) external;

    function recieveSolar(address _from, uint256 _amount) external;

    function transferFhr(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;
}
