pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import {Types} from './lib/Types.sol';

contract BaseStorage {
    mapping(uint256 => address) internal stakedTokenToOwner;
    mapping(address => uint256) internal proxyAddressToTokenId;
    mapping(uint256 => address) internal tokenIdToProxyAddress;
    mapping(address => Types.Position) internal fleetToPosition;
    mapping(uint256 => Types.SatStats) internal idToSatStats;
    mapping(uint256 => mapping(uint256 => mapping(uint256 => mapping(uint256 => Types.SystemType))))
        internal positionToSystemType;

    address internal solar;
    address internal planetManager;
    address internal fhr;
    address internal sat;
    address internal treasury;

    Types.Position startPosition;
    Types.Position boundaries;

    uint256 maxRoll;

    uint256 totalFhr;
    uint256 totalSats;

    Types.Range lowYieldRange;
    Types.Range mediumYieldRange;
    Types.Range highYieldRange;
    Types.Range insaneYieldRange;

    Types.RangeUint8 easyAiRange;
    Types.RangeUint8 mediumAiRange;
    Types.RangeUint8 hardAiRange;
    Types.RangeUint8 insaneAiRange;
}
