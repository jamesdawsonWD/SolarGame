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

    function initialize(address _es) public initializer {
        es = EternalStorage(_es);
    }

    function getSolarAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.solar'));
    }

    function getFHRAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.fhr'));
    }

    function getSatAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.sat'));
    }

    function getTreasuryAddress() public view returns (address) {
        return es.getAddress(keccak256('contract.address.treasury'));
    }

    function getBalance(address user) public view returns (uint256) {
        return es.getUint(keccak256(abi.encodePacked('user.balance', user)));
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

    function getRandomSystemType() public view returns (Types.SystemType systemType, uint256 rand) {
        uint256 MAX_ROLL = es.getUint(keccak256('constants.rolling.maxRoll'));
        uint256 ONE_PERCENT = MAX_ROLL / 100;
        rand = Random.randrange(1, MAX_ROLL);
        uint16 roll = uint16(rand);
        if (roll == 1) {
            systemType = Types.SystemType.AncientFleetAggressive;
        } else if (roll == 42) {
            systemType = Types.SystemType.SuperComputerEvent;
        } else if (roll <= ONE_PERCENT * 5) {
            systemType = Types.SystemType.AdvancedAlienFleetAggressive;
        } else if (roll > ONE_PERCENT * 5 && roll <= ONE_PERCENT * 10) {
            systemType = Types.SystemType.AiFleetAggressive;
        } else if (roll > ONE_PERCENT * 10 && roll <= ONE_PERCENT * 20) {
            systemType = Types.SystemType.AlienFleetAggressive;
        } else if (roll > ONE_PERCENT * 20 && roll <= ONE_PERCENT * 30) {
            systemType = Types.SystemType.PiratesEvent;
        } else if (roll > ONE_PERCENT * 30 && roll <= ONE_PERCENT * 35) {
            systemType = Types.SystemType.SolarWinds;
        } else if (roll > ONE_PERCENT * 35 && roll <= ONE_PERCENT * 40) {
            systemType = Types.SystemType.Asteroids;
        } else if (roll > ONE_PERCENT * 40 && roll <= ONE_PERCENT * 47) {
            systemType = Types.SystemType.Empty;
        } else if (roll > ONE_PERCENT * 47 && roll <= ONE_PERCENT * 60) {
            systemType = Types.SystemType.GovermentOwned;
        } else if (roll > ONE_PERCENT * 60 && roll <= ONE_PERCENT * 65) {
            systemType = Types.SystemType.LowYieldSystem;
        } else if (roll > ONE_PERCENT * 65 && roll <= ONE_PERCENT * 70) {
            systemType = Types.SystemType.RandomEvent;
        } else if (roll > ONE_PERCENT * 70 && roll <= ONE_PERCENT & 75) {
            systemType = Types.SystemType.MediumYieldSystem;
        } else if (roll > ONE_PERCENT * 70 && roll <= ONE_PERCENT & 80) {
            systemType = Types.SystemType.ShipWreck;
        } else if (roll > ONE_PERCENT * 80 && roll <= ONE_PERCENT & 85) {
            systemType = Types.SystemType.HighYieldSystem;
        } else if (roll > ONE_PERCENT * 85 && roll <= ONE_PERCENT & 90) {
            systemType = Types.SystemType.AncientMiningSystem;
        } else if (roll > ONE_PERCENT * 90 && roll <= ONE_PERCENT & 95) {
            systemType = Types.SystemType.AncientWeaponSystem;
        } else if (roll > ONE_PERCENT * 95 && roll <= ONE_PERCENT & 99) {
            systemType = Types.SystemType.AncientShipWreck;
        } else if (roll > ONE_PERCENT * 99 && roll <= MAX_ROLL - 1) {
            systemType = Types.SystemType.InsaneYieldSystem;
        } else if (roll == MAX_ROLL) {
            systemType = Types.SystemType.AncientRacePassive;
        } else {
            systemType = Types.SystemType.Empty;
        }
    }

    function getRandomYield(Types.SystemType systemType) public view returns (uint16 rand) {
        if (systemType == Types.SystemType.LowYieldSystem) {
            rand = uint16(
                Random.randrange(
                    es.getUint(keccak256('constants.yield.low_yield_low')),
                    es.getUint(keccak256('constants.yield.low_yield_high'))
                )
            );
        } else if (systemType == Types.SystemType.MediumYieldSystem) {
            rand = uint16(
                Random.randrange(
                    es.getUint(keccak256('constants.yield.medium_yield_low')),
                    es.getUint(keccak256('constants.yield.medium_yield_high'))
                )
            );
        } else if (systemType == Types.SystemType.LowYieldSystem) {
            rand = uint16(
                Random.randrange(
                    es.getUint(keccak256('constants.yield.high_yield_low')),
                    es.getUint(keccak256('constants.yield.high_yield_high'))
                )
            );
        } else if (systemType == Types.SystemType.LowYieldSystem) {
            rand = uint16(
                Random.randrange(
                    es.getUint(keccak256('constants.yield.insane_yield_low')),
                    es.getUint(keccak256('constants.yield.insane_yield_high'))
                )
            );
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

    function getStarSystemYield(Types.Position memory pos) public view returns (uint16) {
        es.getUint16(
            keccak256(
                abi.encodePacked('stars.yield', pos.quadrant, pos.sector, pos.district, pos.star)
            )
        );
    }

    function setStarSystemYield(Types.Position memory pos, uint16 yield) public {
        es.setUint16(
            keccak256(
                abi.encodePacked('stars.yield', pos.quadrant, pos.sector, pos.district, pos.star)
            ),
            yield
        );
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

    function getSatInfo(Types.ShipAndTechList satType)
        public
        view
        returns (uint256 offense, uint256 defense)
    {
        offense = es.getUint8(keccak256(abi.encodePacked('constants.sats.offense', satType)));
        defense = es.getUint8(keccak256(abi.encodePacked('constants.sats.defense', satType)));
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
}
