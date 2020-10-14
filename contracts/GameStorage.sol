pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
// import {Require} from './Require.sol';
import {Random} from './Random.sol';
import {Types} from './lib/Types.sol';
import {Utils} from './Utils.sol';
// import {Fleet} from './Fleet.sol';
// import {Constants} from './Constants.sol';
// import {Governance} from './Governance.sol';
import {EternalStorage} from './EternalStorage.sol';
import {Initializable} from '@openzeppelin/upgrades-core/contracts/Initializable.sol';

contract GameStorage is Utils, Initializable, Random {
    using SafeMath for uint256;
    EternalStorage es;
    mapping(address => bool[]) private addressToShipIds;
    mapping(uint256 => address) private stakedTokenToOwner;

    function initialize(address _es) public initializer {
        es = EternalStorage(_es);
    }

    function getSolarAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.solar'));
    }

    function getFhrAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.fhr'));
    }

    function getSatAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.sat'));
    }

    function getTreasuryAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.treasury'));
    }

    function getStakedBalance(address user, uint256 tokenId) public view returns (uint256) {
        return es.getUint(keccak256(abi.encodePacked('user.stakedBalance', user, tokenId)));
    }

    function setStakedBalance(
        address user,
        uint256 tokenId,
        uint256 newBalance
    ) public {
        es.setUint(keccak256(abi.encodePacked('user.stakedBalance', user, tokenId)), newBalance);
    }

    function getDateStakeLocked(address user, uint256 tokenId) public view returns (uint256) {
        return es.getUint(keccak256(abi.encodePacked('date.stakeLocked', user, tokenId)));
    }

    function setDateStakeLocked(
        address user,
        uint256 tokenId,
        uint256 locked
    ) public {
        es.setUint(keccak256(abi.encodePacked('date.stakeLocked', user, tokenId)), locked);
    }

    function setStakedTokenToOwner(uint256 tokenId, address owner) public {
        stakedTokenToOwner[tokenId] = owner;
    }

    function getStakedTokenToOwner(uint256 tokenId) public returns (address) {
        return stakedTokenToOwner[tokenId];
    }

    function getStartPosition() public view returns (Types.Position memory) {
        return
            Types.Position({
                quadrant: es.getUint8(keccak256('constants.startPosition.quadrant')),
                sector: es.getUint8(keccak256('constants.startPosition.sector')),
                district: es.getUint8(keccak256('constants.startPosition.district')),
                star: es.getUint(keccak256('constants.startPosition.star'))
            });
    }

    function getBoundaries() public view returns (Types.Position memory) {
        return
            Types.Position({
                quadrant: es.getUint8(keccak256('constants.boundaries.quadrant')),
                district: es.getUint8(keccak256('constants.boundaries.district')),
                sector: es.getUint8(keccak256('constants.boundaries.sector')),
                star: es.getUint(keccak256('constants.boundaries.star'))
            });
    }

    function getMaxRoll() public view returns (uint256) {
        return es.getUint(keccak256('constants.rolling.maxRoll'));
    }

    function incrementTotalFhr() public returns (uint256) {
        uint256 _id = es.getUint(keccak256('fhr.total')) + 1;
        es.setUint(keccak256('fhr.total'), _id);
        return _id;
    }

    function getStarSystemType(Types.Position memory pos) public view returns (Types.SystemType) {
        uint256 systemType = es.getUint(
            keccak256(
                abi.encodePacked(
                    'stars.systemType',
                    pos.quadrant,
                    pos.sector,
                    pos.district,
                    pos.star
                )
            )
        );
        return Types.SystemType(systemType);
    }

    function getStarSystemYieldRange(Types.SystemType systemType)
        public
        returns (uint256 low, uint256 high)
    {
        if (systemType == Types.SystemType.LowYieldSystem) {
            low = es.getUint(keccak256('constants.yield.low_yield_low'));
            high = es.getUint(keccak256('constants.yield.low_yield_high'));
        } else if (systemType == Types.SystemType.MediumYieldSystem) {
            low = es.getUint(keccak256('constants.yield.medium_yield_low'));
            high = es.getUint(keccak256('constants.yield.medium_yield_high'));
        } else if (systemType == Types.SystemType.LowYieldSystem) {
            low = es.getUint(keccak256('constants.yield.high_yield_low'));
            high = es.getUint(keccak256('constants.yield.high_yield_high'));
        } else if (systemType == Types.SystemType.LowYieldSystem) {
            low = es.getUint(keccak256('constants.yield.insane_yield_low'));
            high = es.getUint(keccak256('constants.yield.insane_yield_high'));
        }
    }

    function setStarSystemType(Types.Position memory pos, Types.SystemType systemType) public {
        es.setUint(
            keccak256(
                abi.encodePacked(
                    'stars.systemType',
                    pos.quadrant,
                    pos.sector,
                    pos.district,
                    pos.star
                )
            ),
            uint256(systemType)
        );
    }

    function getStarSystemYield(uint256 _tokenId) public view returns (uint256) {
        return es.getUint(keccak256(abi.encodePacked('stars.yield', _tokenId)));
    }

    function setStarSystemYield(uint256 _tokenId, uint256 yield) public {
        es.setUint(keccak256(abi.encodePacked('stars.yield', _tokenId)), uint256(yield));
    }

    function setMasterFleetPosition(address master, Types.Position memory pos) public {
        es.setUint8(
            keccak256(abi.encodePacked('master.fleet.position.quadrant', master)),
            pos.quadrant
        );
        es.setUint8(
            keccak256(abi.encodePacked('master.fleet.position.sector', master)),
            pos.sector
        );
        es.setUint8(
            keccak256(abi.encodePacked('master.fleet.position.district', master)),
            pos.district
        );
        es.setUint(keccak256(abi.encodePacked('master.fleet.position.star', master)), pos.star);
    }

    function getMasterFleetPosition(address master) public view returns (Types.Position memory) {
        return
            Types.Position({
                quadrant: es.getUint8(
                    keccak256(abi.encodePacked('master.fleet.position.quadrant', master))
                ),
                sector: es.getUint8(
                    keccak256(abi.encodePacked('master.fleet.position.sector', master))
                ),
                district: es.getUint8(
                    keccak256(abi.encodePacked('master.fleet.position.district', master))
                ),
                star: es.getUint(keccak256(abi.encodePacked('master.fleet.position.star', master)))
            });
    }

    function getMasterFleetOffense(address master) public view returns (uint256) {
        return es.getUint(keccak256(abi.encodePacked('master.fleet.offense', master)));
    }

    function setMasterFleetOffense(address master, uint256 offense) public {
        es.setUint(keccak256(abi.encodePacked('master.fleet.offense', master)), offense);
    }

    function getMasterFleetDefense(address master) public view returns (uint256) {
        return es.getUint(keccak256(abi.encodePacked('master.fleet.defense', master)));
    }

    function setMasterFleetDefense(address master, uint256 defense) public {
        es.setUint(keccak256(abi.encodePacked('master.fleet.defense', master)), defense);
    }

    function setMasterLockedInShipInfo(
        address master,
        uint256 id,
        uint256 amount
    ) public {
        es.setUint(keccak256(abi.encodePacked('master.fleet.lockedin', master, id)), amount);
    }

    function getMasterLockedInShipInfo(address master, uint256 id) public view returns (uint256) {
        return es.getUint(keccak256(abi.encodePacked('master.fleet.lockedin', master, id)));
    }

    function getMasterFleetInfo(address master)
        public
        view
        returns (uint256 offense, uint256 defense)
    {
        offense = getMasterFleetOffense(master);
        defense = getMasterFleetDefense(master);
    }

    function getMasterAddressToShipIds(address master) public view returns (bool[] memory) {
        return addressToShipIds[master];
    }

    function setMasterAddressToShipIds(address master, bool[] memory ids) public {
        addressToShipIds[master] = ids;
    }

    function getAiFleetInfo(Types.SystemType systemType)
        public
        view
        returns (uint256 offense, uint256 defense)
    {
        if (systemType == Types.SystemType.AlienFleetAggressive) {
            uint8 min = es.getUint8(keccak256('constants.rolling.alienfleet.min'));
            uint8 max = es.getUint8(keccak256('constants.rolling.alienfleet.max'));
            offense = Random.randrange(min, max);
            defense = Random.randrange(min, max);
        } else if (systemType == Types.SystemType.AdvancedAlienFleetAggressive) {
            uint8 min = es.getUint8(keccak256('constants.rolling.advancedalienfleet.min'));
            uint8 max = es.getUint8(keccak256('constants.rolling.advancedalienfleet.max'));
            offense = Random.randrange(min, max);
            defense = Random.randrange(min, max);
        } else if (systemType == Types.SystemType.AncientFleetAggressive) {
            uint8 min = es.getUint8(keccak256('constants.rolling.ancientfleet.min'));
            uint8 max = es.getUint8(keccak256('constants.rolling.ancientfleet.max'));
            offense = Random.randrange(min, max);
            defense = Random.randrange(min, max);
        }
    }

    function getTotalSats() public view returns (uint256) {
        return es.getUint(keccak256('constants.totalSats'));
    }

    function getSatInfo(Types.ShipAndTechList satType)
        public
        view
        returns (uint256 offense, uint256 defense)
    {
        offense = es.getUint8(keccak256(abi.encodePacked('constants.sats.offense', satType)));
        defense = es.getUint8(keccak256(abi.encodePacked('constants.sats.defense', satType)));
    }
}
