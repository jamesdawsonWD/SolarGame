pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import {Types} from './lib/Types.sol';

contract BaseStorage {
    mapping(uint256 => address) internal gameEventIdToAddress;
    mapping(address => uint256) internal userAddressToGameEvent;
    mapping(uint256 => address) internal stakedTokenToOwner;
    mapping(address => uint256) internal proxyAddressToTokenId;
    mapping(uint256 => address) internal tokenIdToProxyAddress;
    mapping(uint256 => uint256) internal tokenIdToYield;
    mapping(address => Types.Position) internal fleetToPosition;
    mapping(uint256 => Types.SatStats) internal idToSatStats;
    mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => Types.SystemType))))
        internal positionToSystemType;

    address internal solar;
    address internal planetManager;
    address internal planets;
    address internal sat;
    address internal treasury;
    address internal gameEvents;
    address internal traverse;

    Types.Position startPosition;
    Types.Position boundaries;

    // PlanetManager
    address public planetImplementation;
    mapping(address => bool) operators;
    mapping(address => uint256) addressToTokenId;

    // Rolling
    uint256 maxRoll;

    uint256 totalPlanets;
    uint256 totalSats;
    uint256 totalGameEvents;

    Types.Range lowYieldRange;
    Types.Range mediumYieldRange;
    Types.Range highYieldRange;
    Types.Range insaneYieldRange;

    Types.RangeUint8 easyAiRange;
    Types.RangeUint8 mediumAiRange;
    Types.RangeUint8 hardAiRange;
    Types.RangeUint8 insaneAiRange;
}
