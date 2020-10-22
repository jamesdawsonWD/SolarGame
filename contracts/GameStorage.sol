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
    mapping(address => bool) operators;

    function initialize(
        address _solar,
        address _sat,
        address _fhr,
        address _treasury,
        address _planetManager,
        address _gameOperations
    ) public {
        solar = _solar;
        sat = _sat;
        fhr = _fhr;
        treasury = _treasury;
        planetManager = _planetManager;
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

    function getSolarAddress() public view returns (address) {
        return solar;
    }

    function getPlanetManagerAddress() public view returns (address) {
        return planetManager;
    }

    function getFhrAddress() public view returns (address) {
        return fhr;
    }

    function getSatAddress() public view returns (address) {
        return sat;
    }

    function getTreasuryAddress() public view returns (address) {
        return treasury;
    }

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

    function getStartPosition() public view returns (Types.Position memory) {
        return startPosition;
    }

    function getBoundaries() public view returns (Types.Position memory) {
        return boundaries;
    }

    function getMaxRoll() public view returns (uint256) {
        return maxRoll;
    }

    function incrementTotalFhr() public onlyOperator returns (uint256) {
        totalFhr += 1;
        return totalFhr;
    }

    function getTotalFhr() public view returns (uint256) {
        return totalFhr;
    }

    function getStarSystemYieldRange(Types.SystemType systemType) public returns (uint256 low, uint256 high) {
        if (systemType == Types.SystemType.LowYieldSystem) {
            low = lowYieldRange.low;
            high = lowYieldRange.high;
        } else if (systemType == Types.SystemType.MediumYieldSystem) {
            low = mediumYieldRange.low;
            high = mediumYieldRange.high;
        } else if (systemType == Types.SystemType.HighYieldSystem) {
            low = highYieldRange.low;
            high = highYieldRange.low;
        } else if (systemType == Types.SystemType.InsaneYieldSystem) {
            low = insaneYieldRange.low;
            high = insaneYieldRange.high;
        }
    }

    function setTokenIdToYield(uint256 tokenId, uint256 yield) public {
        tokenIdToYield[tokenId] = yield;
    }

    function getTokenIdToYield(uint256 tokenId) public view returns (uint256) {
        return tokenIdToYield[tokenId];
    }

    function setStarSystemType(Types.Position memory pos, Types.SystemType systemType) public {
        positionToSystemType[pos.quadrant][pos.district][pos.sector][pos.star] = systemType;
    }

    function getStarSystemType(Types.Position memory pos) public view returns (Types.SystemType) {
        return positionToSystemType[pos.quadrant][pos.district][pos.sector][pos.star];
    }

    function setMasterFleetPosition(address fleet, Types.Position memory pos) public {
        fleetToPosition[fleet] = pos;
    }

    function getMasterFleetPosition(address fleet) public view returns (Types.Position memory) {
        return fleetToPosition[fleet];
    }

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
