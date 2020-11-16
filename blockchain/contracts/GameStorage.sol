pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Random} from './Random.sol';
import {Types} from './lib/Types.sol';
import {Initializable} from '@openzeppelin/upgrades-core/contracts/Initializable.sol';
import {Constants} from './Constants.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract GameStorage is Random, Constants, Ownable {
    using SafeMath for uint256;

    function initialize(
        address _solar,
        address _sat,
        address _planets,
        address _treasury,
        address _traverse,
        address _planetManager,
        address _gameOperations,
        address _gameEvents
    ) public {
        solar = _solar;
        sat = _sat;
        planets = _planets;
        treasury = _treasury;
        traverse = _traverse;
        planetManager = _planetManager;
        gameEvents = _gameEvents;
        resetConstants();
        addOperator(_gameOperations);
    }

    function addOperator(address _operator) public onlyOwner {
        operators[_operator] = true;
    }

    modifier onlyOperator() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(operators[msg.sender], 'Only Operator');
        _;
    }

    //************** ADDRESSES *********************/
    function getSolarAddress() public view returns (address) {
        return solar;
    }

    function getPlanetManagerAddress() public view returns (address) {
        return planetManager;
    }

    function getPlanetsAddress() public view returns (address) {
        return planets;
    }

    function getSatAddress() public view returns (address) {
        return sat;
    }

    function getTreasuryAddress() public view returns (address) {
        return treasury;
    }

    function getTraverseAddress() public view returns (address) {
        return traverse;
    }

    function getGameEventsAddress() public view returns (address) {
        return gameEvents;
    }

    //************** PLANET MANAGER *********************/
    function getProxyAddressToTokenId(address _address) public view returns (uint256) {
        return proxyAddressToTokenId[_address];
    }

    function setProxyAddressToTokenId(uint256 token, address _address) public {
        proxyAddressToTokenId[_address] = token;
    }

    function getTokenIdToProxyAddress(uint256 _token) public view returns (address) {
        return tokenIdToProxyAddress[_token];
    }

    function setTokenIdToProxyAddress(uint256 token, address _address) public {
        tokenIdToProxyAddress[token] = _address;
    }

    function incrementTotalPlanets() public onlyOperator returns (uint256) {
        totalPlanets += 1;
        return totalPlanets;
    }

    function setTokenIdToYield(uint256 tokenId, uint256 yield) public {
        tokenIdToYield[tokenId] = yield;
    }

    function getTokenIdToYield(uint256 tokenId) public view returns (uint256) {
        return tokenIdToYield[tokenId];
    }

    function getTotalPlanets() public view returns (uint256) {
        return totalPlanets;
    }

    function setTotalPlanets(uint256 number) public {
        totalPlanets = number;
    }

    function getPlanetImplementation() public view returns (address) {
        return planetImplementation;
    }

    //************** TRAVERSE *********************/
    function getStartPosition() public view returns (Types.Position memory) {
        return startPosition;
    }

    function getBoundaries() public view returns (Types.Position memory) {
        return boundaries;
    }

    function setMasterFleetPosition(address fleet, Types.Position memory pos) public {
        fleetToPosition[fleet] = pos;
    }

    function getMasterFleetPosition(address fleet) public view returns (Types.Position memory) {
        return fleetToPosition[fleet];
    }

    //************** ROLLING *********************/
    function getMaxRoll() public view returns (uint256) {
        return maxRoll;
    }

    //************** GAME EVENTS *********************/
    function getUserAddressToGameEvent(address user) public view returns (uint256) {
        return userAddressToGameEvent[user];
    }

    function setUserAddressToGameEvent(address user, uint256 gameEvent) public {
        userAddressToGameEvent[user] = gameEvent;
    }

    function getGameEventIdToAddress(uint256 gameEvent) public view returns (address) {
        return gameEventIdToAddress[gameEvent];
    }

    function setGameEventIdToAddress(uint256 gameEvent, address _address) public {
        gameEventIdToAddress[gameEvent] = _address;
    }

    function getTotalGameEvents() public view returns (uint256) {
        return totalGameEvents;
    }

    function setTotalGameEvents(uint256 amount) public {
        totalGameEvents = amount;
    }

    //************** BATTLING *********************/
    function getAiFleetInfo(Types.SystemType systemType) public returns (uint256 offense, uint256 defense) {
        if (systemType == Types.SystemType.AlienFleetAggressive) {
            uint8 min = easyAiRange.low;
            uint8 max = easyAiRange.high;
            offense = randomrange(min, max);
            defense = randomrange(min, max);
        } else if (systemType == Types.SystemType.AdvancedAlienFleetAggressive) {
            uint8 min = mediumAiRange.low;
            uint8 max = mediumAiRange.high;
            offense = randomrange(min, max);
            defense = randomrange(min, max);
        } else if (systemType == Types.SystemType.AncientFleetAggressive) {
            uint8 min = insaneAiRange.low;
            uint8 max = insaneAiRange.high;
            offense = randomrange(min, max);
            defense = randomrange(min, max);
        }
    }

    function getTotalSats() public view returns (uint256) {
        return totalSats;
    }

    function getSatInfo(uint256 satType) public view returns (uint256 offense, uint256 defense) {
        offense = idToSatStats[satType].offense;
        defense = idToSatStats[satType].defense;
    }

    function batchGetSatInfo(uint256[] memory ids)
        public
        view
        returns (uint256[] memory offenses, uint256[] memory defenses)
    {
        offenses = new uint256[](ids.length);
        defenses = new uint256[](ids.length);
        for (uint256 i = 0; i < ids.length; i++) {
            (uint256 o, uint256 d) = getSatInfo(ids[i]);
            offenses[i] = o;
            defenses[i] = d;
        }
    }
}
