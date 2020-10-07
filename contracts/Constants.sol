pragma solidity 0.6.12;
import {EternalStorage} from './EternalStorage.sol';

contract Constants {
    EternalStorage es;

    uint32 constant LOW_YIELD_LOW = 1;
    uint32 constant LOW_YIELD_HIGH = 75;

    uint32 constant MEDIUM_YIELD_LOW = 76;
    uint32 constant MEDIUM_YIELD_HIGH = 150;

    uint32 constant HIGH_YIELD_LOW = 151;
    uint32 constant HIGH_YIELD_HIGH = 400;

    uint32 constant INSANE_YIELD_LOW = 401;
    uint32 constant INSANE_YIELD_HIGH = 1000;

    // Total System Types
    uint256 constant TOTAL_SYSTEM_TYPES = 7;

    // Rolling
    uint32 constant MAX_ROLL = 10000;
    uint32 constant ONE_PERCENT_MAX_ROLL = MAX_ROLL / 100;
    uint32 constant POINT_ONE_PERCENT_OF_MAX_ROLL = MAX_ROLL / 1000;
    uint8 constant MAX_ALIENFLEET_O_D = 50;
    uint8 constant MIN_ALIENFLEET_O_D = 18;
    uint8 constant MAX_ADVANCED_ALIENFLEET_O_D = 75;
    uint8 constant MIN_ADVANCED_ALIENFLEET_O_D = 35;
    uint8 constant MAX_ANCIENTFLEET_O_D = 150;
    uint8 constant MIN_ANCIENTFLEET_O_D = 100;
    // Galaxy Boundaries
    uint8 constant MAX_QUADRANT = 4;
    uint8 constant MAX_DISTRICT = 8;
    uint8 constant MAX_SECTOR = 21;
    uint256 constant MAX_STAR = 10000;

    // Starting Position for all new addresses
    uint8 constant START_POSITION_QUADRANT = 1;
    uint8 constant START_POSITION_DISTRICT = 1;
    uint8 constant START_POSITION_SECTOR = 7;
    uint32 constant START_POSITION_STAR = 42;

    // Total Ships & Technology
    uint16 constant TOTAL_SAT_ITEMS = 46;

    // Bonus Variables
    uint256 constant DEFENSE_BONUS = 100000;
    uint256 constant TURNS = 10;

    // Goverance
    uint256 constant TOTAL_SUPPLY = 17000000;
    uint256 constant QORUM_VOTES = TOTAL_SUPPLY / 25;
    uint256 constant PROPOSAL_THRESHOLD = TOTAL_SUPPLY / 100;
    uint256 constant VOTING_PERIOD = 17280;
    uint256 constant VOTING_DELAY = 1;
    uint256 constant PROPOSAL_MAX_OPERATIONS = 10;

    enum ShipAndTechList {
        FEDERATION_CRUISER,
        FEDERATION_DESTROYER,
        FEDERATION_MASTER_VESSEL,
        FEDERATION_FIGHTER_PLANE,
        FEDERATION_MARKET_SHIP,
        FEDERATION_MINING_SHIP_SMALL,
        FEDERATION_MINING_SHIP_MEDIUM,
        FEDERATION_MINING_SHIP_LARGE,
        FEDERATION_WEAPON_SYSTEM_SMALL,
        FEDERATION_WEAPON_SYSTEM_MEDIUM,
        FEDERATION_WEAPON_SYSTEM_LARGE,
        ALIEN_MASTER_VESSEL,
        ALIEN_CRUISER,
        ALIEN_DESTROYER,
        ALIEN_FIGHTER_PLANE,
        ALIEN_MARKET_SHIP,
        ALIEN_MINING_SHIP_SMALL,
        ALIEN_MINING_SHIP_MEDIUM,
        ALIEN_MINING_SHIP_LARGE,
        ALIEN_WEAPON_SYSTEM_SMALL,
        ALIEN_WEAPON_SYSTEM_MEDIUM,
        ALIEN_WEAPON_SYSTEM_LARGE,
        ADVANCED_RACE_MASTER_VESSEL,
        ADVANCED_RACE_CRUISER,
        ADVANCED_RACE_DESTROYER,
        ADVANCED_RACE_FIGHTER_PLANE,
        ADVANCED_RACE_MARKET_SHIP,
        ADVANCED_RACE_MINING_SHIP_SMALL,
        ADVANCED_RACE_MINING_SHIP_MEDIUM,
        ADVANCED_RACE_MINING_SHIP_LARGE,
        ADVANCED_RACE_WEAPON_SYSTEM_SMALL,
        ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM,
        ADVANCED_RACE_WEAPON_SYSTEM_LARGE,
        ANCIENT_MASTER_VESSEL,
        ANCIENT_CRUISER,
        ANCIENT_DESTROYER,
        ANCIENT_FIGHTER_PLANE,
        ANCIENT_MARKET_SHIP,
        ANCIENT_MINING_SHIP_SMALL,
        ANCIENT_MINING_SHIP_MEDIUM,
        ANCIENT_MINING_SHIP_LARGE,
        ANCIENT_WEAPON_SYSTEM_SMALL,
        ANCIENT_WEAPON_SYSTEM_MEDIUM,
        ANCIENT_WEAPON_SYSTEM_LARGE,
        PIRATE_SHIP,
        PIRATE_WEAPON
    }

    // Ships and technology attack
    uint8 constant FEDERATION_MASTER_VESSEL_OFFENSE = 9;
    uint8 constant FEDERATION_CRUISER_OFFENSE = 10;
    uint8 constant FEDERATION_DESTROYER_OFFENSE = 15;
    uint8 constant FEDERATION_FIGHTER_PLANE_OFFENSE = 2;
    uint8 constant FEDERATION_MARKET_SHIP_OFFENSE = 1;
    uint8 constant FEDERATION_MINING_SHIP_SMALL_OFFENSE = 1;
    uint8 constant FEDERATION_MINING_SHIP_MEDIUM_OFFENSE = 1;
    uint8 constant FEDERATION_MINING_SHIP_LARGE_OFFENSE = 2;
    uint8 constant FEDERATION_WEAPON_SYSTEM_SMALL_OFFENSE = 1;
    uint8 constant FEDERATION_WEAPON_SYSTEM_MEDIUM_OFFENSE = 2;
    uint8 constant FEDERATION_WEAPON_SYSTEM_LARGE_OFFENSE = 3;

    uint8 constant ALIEN_MASTER_VESSEL_OFFENSE = 12;
    uint8 constant ALIEN_CRUISER_OFFENSE = 13;
    uint8 constant ALIEN_DESTROYER_OFFENSE = 10;
    uint8 constant ALIEN_FIGHTER_PLANE_OFFENSE = 3;
    uint8 constant ALIEN_MARKET_SHIP_OFFENSE = 1;
    uint8 constant ALIEN_MINING_SHIP_SMALL_OFFENSE = 1;
    uint8 constant ALIEN_MINING_SHIP_MEDIUM_OFFENSE = 2;
    uint8 constant ALIEN_MINING_SHIP_LARGE_OFFENSE = 3;
    uint8 constant ALIEN_WEAPON_SYSTEM_SMALL_OFFENSE = 2;
    uint8 constant ALIEN_WEAPON_SYSTEM_MEDIUM_OFFENSE = 3;
    uint8 constant ALIEN_WEAPON_SYSTEM_LARGE_OFFENSE = 4;

    uint8 constant ADVANCED_RACE_MASTER_VESSEL_OFFENSE = 15;
    uint8 constant ADVANCED_RACE_CRUISER_OFFENSE = 15;
    uint8 constant ADVANCED_RACE_DESTROYER_OFFENSE = 20;
    uint8 constant ADVANCED_RACE_FIGHTER_PLANE_OFFENSE = 5;
    uint8 constant ADVANCED_RACE_MARKET_SHIP_OFFENSE = 2;
    uint8 constant ADVANCED_RACE_MINING_SHIP_SMALL_OFFENSE = 2;
    uint8 constant ADVANCED_RACE_MINING_SHIP_MEDIUM_OFFENSE = 3;
    uint8 constant ADVANCED_RACE_MINING_SHIP_LARGE_OFFENSE = 4;
    uint8 constant ADVANCED_RACE_WEAPON_SYSTEM_SMALL_OFFENSE = 5;
    uint8 constant ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM_OFFENSE = 6;
    uint8 constant ADVANCED_RACE_WEAPON_SYSTEM_LARGE_OFFENSE = 7;

    uint8 constant ANCIENT_MASTER_VESSEL_OFFENSE = 20;
    uint8 constant ANCIENT_CRUISER_OFFENSE = 21;
    uint8 constant ANCIENT_DESTROYER_OFFENSE = 30;
    uint8 constant ANCIENT_FIGHTER_PLANE_OFFENSE = 10;
    uint8 constant ANCIENT_MARKET_SHIP_OFFENSE = 5;
    uint8 constant ANCIENT_MINING_SHIP_SMALL_OFFENSE = 5;
    uint8 constant ANCIENT_MINING_SHIP_MEDIUM_OFFENSE = 6;
    uint8 constant ANCIENT_MINING_SHIP_LARGE_OFFENSE = 7;
    uint8 constant ANCIENT_WEAPON_SYSTEM_SMALL_OFFENSE = 8;
    uint8 constant ANCIENT_WEAPON_SYSTEM_MEDIUM_OFFENSE = 9;
    uint8 constant ANCIENT_WEAPON_SYSTEM_LARGE_OFFENSE = 10;

    uint8 constant PIRATE_SHIP_OFFENSE = 12;
    uint8 constant PIRATE_WEAPON_OFFENSE = 22;

    // Ships and technology Defense
    uint8 constant FEDERATION_MASTER_VESSEL_DEFENSE = 9;
    uint8 constant FEDERATION_CRUISER_DEFENSE = 10;
    uint8 constant FEDERATION_DESTROYER_DEFENSE = 15;
    uint8 constant FEDERATION_FIGHTER_PLANE_DEFENSE = 2;
    uint8 constant FEDERATION_MARKET_SHIP_DEFENSE = 1;
    uint8 constant FEDERATION_MINING_SHIP_SMALL_DEFENSE = 1;
    uint8 constant FEDERATION_MINING_SHIP_MEDIUM_DEFENSE = 1;
    uint8 constant FEDERATION_MINING_SHIP_LARGE_DEFENSE = 2;
    uint8 constant FEDERATION_WEAPON_SYSTEM_SMALL_DEFENSE = 1;
    uint8 constant FEDERATION_WEAPON_SYSTEM_MEDIUM_DEFENSE = 2;
    uint8 constant FEDERATION_WEAPON_SYSTEM_LARGE_DEFENSE = 3;

    uint8 constant ALIEN_MASTER_VESSEL_DEFENSE = 12;
    uint8 constant ALIEN_CRUISER_DEFENSE = 13;
    uint8 constant ALIEN_DESTROYER_DEFENSE = 10;
    uint8 constant ALIEN_FIGHTER_PLANE_DEFENSE = 3;
    uint8 constant ALIEN_MARKET_SHIP_DEFENSE = 1;
    uint8 constant ALIEN_MINING_SHIP_SMALL_DEFENSE = 1;
    uint8 constant ALIEN_MINING_SHIP_MEDIUM_DEFENSE = 2;
    uint8 constant ALIEN_MINING_SHIP_LARGE_DEFENSE = 3;
    uint8 constant ALIEN_WEAPON_SYSTEM_SMALL_DEFENSE = 2;
    uint8 constant ALIEN_WEAPON_SYSTEM_MEDIUM_DEFENSE = 3;
    uint8 constant ALIEN_WEAPON_SYSTEM_LARGE_DEFENSE = 4;

    uint8 constant ADVANCED_RACE_MASTER_VESSEL_DEFENSE = 15;
    uint8 constant ADVANCED_RACE_CRUISER_DEFENSE = 15;
    uint8 constant ADVANCED_RACE_DESTROYER_DEFENSE = 20;
    uint8 constant ADVANCED_RACE_FIGHTER_PLANE_DEFENSE = 5;
    uint8 constant ADVANCED_RACE_MARKET_SHIP_DEFENSE = 2;
    uint8 constant ADVANCED_RACE_MINING_SHIP_SMALL_DEFENSE = 2;
    uint8 constant ADVANCED_RACE_MINING_SHIP_MEDIUM_DEFENSE = 3;
    uint8 constant ADVANCED_RACE_MINING_SHIP_LARGE_DEFENSE = 4;
    uint8 constant ADVANCED_RACE_WEAPON_SYSTEM_SMALL_DEFENSE = 5;
    uint8 constant ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM_DEFENSE = 6;
    uint8 constant ADVANCED_RACE_WEAPON_SYSTEM_LARGE_DEFENSE = 7;

    uint8 constant ANCIENT_MASTER_VESSEL_DEFENSE = 20;
    uint8 constant ANCIENT_CRUISER_DEFENSE = 21;
    uint8 constant ANCIENT_DESTROYER_DEFENSE = 30;
    uint8 constant ANCIENT_FIGHTER_PLANE_DEFENSE = 10;
    uint8 constant ANCIENT_MARKET_SHIP_DEFENSE = 5;
    uint8 constant ANCIENT_MINING_SHIP_SMALL_DEFENSE = 5;
    uint8 constant ANCIENT_MINING_SHIP_MEDIUM_DEFENSE = 6;
    uint8 constant ANCIENT_MINING_SHIP_LARGE_DEFENSE = 7;
    uint8 constant ANCIENT_WEAPON_SYSTEM_SMALL_DEFENSE = 8;
    uint8 constant ANCIENT_WEAPON_SYSTEM_MEDIUM_DEFENSE = 9;
    uint8 constant ANCIENT_WEAPON_SYSTEM_LARGE_DEFENSE = 10;

    uint8 constant PIRATE_SHIP_DEFENSE = 12;
    uint8 constant PIRATE_WEAPON_DEFENSE = 22;

    constructor(address _es) public {
        es = EternalStorage(_es);

        es.setUint(
            keccak256('constants.governance.total_supply'),
            TOTAL_SUPPLY
        );
        es.setUint(keccak256('constants.governance.qorum_votes'), QORUM_VOTES);
        es.setUint(
            keccak256('constants.governance.proposal_threshold'),
            PROPOSAL_THRESHOLD
        );
        es.setUint(
            keccak256('constants.governance.voting_period'),
            VOTING_PERIOD
        );
        es.setUint(
            keccak256('constants.governance.voting_delay'),
            VOTING_DELAY
        );
        es.setUint(
            keccak256('constants.governance.proposal_max_operations'),
            PROPOSAL_MAX_OPERATIONS
        );

        // Yield Constants
        es.setUint(keccak256('constants.yield.low_yield_low'), LOW_YIELD_LOW);
        es.setUint(keccak256('constants.yield.low_yeild_high'), LOW_YIELD_HIGH);
        es.setUint(
            keccak256('constants.yield.medium_yield_low'),
            MEDIUM_YIELD_LOW
        );
        es.setUint(
            keccak256('constants.yield.medium_yield_high'),
            MEDIUM_YIELD_HIGH
        );
        es.setUint(keccak256('constants.yield.high_yield_low'), HIGH_YIELD_LOW);
        es.setUint(
            keccak256('constants.yield.high_yield_high'),
            HIGH_YIELD_HIGH
        );
        es.setUint(
            keccak256('constants.yield.insane_yield_low'),
            INSANE_YIELD_LOW
        );
        es.setUint(
            keccak256('constants.yield.insane_yield_high'),
            INSANE_YIELD_HIGH
        );

        // Start Position Co-ordinates
        es.setUint8(
            keccak256('constants.startPosition.quadrant'),
            START_POSITION_QUADRANT
        );
        es.setUint8(
            keccak256('constants.startPosition.district'),
            START_POSITION_DISTRICT
        );
        es.setUint8(
            keccak256('constants.startPosition.sector'),
            START_POSITION_SECTOR
        );
        es.setUint(
            keccak256('constants.startPosition.star'),
            START_POSITION_STAR
        );

        // Galaxy Boundaries
        es.setUint8(keccak256('constants.boundaries.quadrant'), MAX_QUADRANT);
        es.setUint8(keccak256('constants.boundaries.district'), MAX_DISTRICT);
        es.setUint8(keccak256('constants.boundaries.sector'), MAX_SECTOR);
        es.setUint(keccak256('constants.boundaries.star'), MAX_STAR);

        // Rolling
        es.setUint(keccak256('constants.rolling.maxRoll'), MAX_ROLL);
        es.setUint(keccak256('constants.rolling.star'), START_POSITION_STAR);
        es.setUint(keccak256('constants.rolling.star'), START_POSITION_STAR);
        es.setUint8(
            keccak256('constants.rolling.alienfleet.min'),
            MIN_ALIENFLEET_O_D
        );
        es.setUint8(
            keccak256('constants.rolling.alienfleet.max'),
            MAX_ALIENFLEET_O_D
        );
        es.setUint8(
            keccak256('constants.rolling.advancedalienfleet.min'),
            MIN_ADVANCED_ALIENFLEET_O_D
        );
        es.setUint8(
            keccak256('constants.rolling.advancedalienfleet.max'),
            MAX_ADVANCED_ALIENFLEET_O_D
        );
        es.setUint8(
            keccak256('constants.rolling.ancientfleet.min'),
            MIN_ANCIENTFLEET_O_D
        );
        es.setUint8(
            keccak256('constants.rolling.ancientfleet.max'),
            MAX_ANCIENTFLEET_O_D
        );
        // Ship & Technology Offense
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_MASTER_VESSEL
                )
            ),
            FEDERATION_MASTER_VESSEL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_CRUISER
                )
            ),
            FEDERATION_CRUISER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_DESTROYER
                )
            ),
            FEDERATION_DESTROYER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_FIGHTER_PLANE
                )
            ),
            FEDERATION_FIGHTER_PLANE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_MARKET_SHIP
                )
            ),
            FEDERATION_MARKET_SHIP_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_MINING_SHIP_SMALL
                )
            ),
            FEDERATION_MINING_SHIP_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM
                )
            ),
            FEDERATION_MINING_SHIP_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_MINING_SHIP_LARGE
                )
            ),
            FEDERATION_MINING_SHIP_LARGE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL
                )
            ),
            FEDERATION_WEAPON_SYSTEM_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM
                )
            ),
            FEDERATION_WEAPON_SYSTEM_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE
                )
            ),
            FEDERATION_WEAPON_SYSTEM_LARGE_OFFENSE
        );

        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_MASTER_VESSEL
                )
            ),
            ALIEN_MASTER_VESSEL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_CRUISER
                )
            ),
            ALIEN_CRUISER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_DESTROYER
                )
            ),
            ALIEN_DESTROYER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_FIGHTER_PLANE
                )
            ),
            ALIEN_FIGHTER_PLANE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_MARKET_SHIP
                )
            ),
            ALIEN_MARKET_SHIP_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_MINING_SHIP_SMALL
                )
            ),
            ALIEN_MINING_SHIP_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM
                )
            ),
            ALIEN_MINING_SHIP_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_MINING_SHIP_LARGE
                )
            ),
            ALIEN_MINING_SHIP_LARGE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL
                )
            ),
            ALIEN_WEAPON_SYSTEM_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM
                )
            ),
            ALIEN_WEAPON_SYSTEM_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE
                )
            ),
            ALIEN_WEAPON_SYSTEM_LARGE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.FEDERATION_MASTER_VESSEL
                )
            ),
            FEDERATION_MASTER_VESSEL_OFFENSE
        );

        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_CRUISER
                )
            ),
            ADVANCED_RACE_CRUISER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_DESTROYER
                )
            ),
            ADVANCED_RACE_DESTROYER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE
                )
            ),
            ADVANCED_RACE_FIGHTER_PLANE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_MARKET_SHIP
                )
            ),
            ADVANCED_RACE_MARKET_SHIP_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL
                )
            ),
            ADVANCED_RACE_MINING_SHIP_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM
                )
            ),
            ADVANCED_RACE_MINING_SHIP_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE
                )
            ),
            ADVANCED_RACE_MINING_SHIP_LARGE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL
                )
            ),
            ADVANCED_RACE_WEAPON_SYSTEM_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM
                )
            ),
            ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE
                )
            ),
            ADVANCED_RACE_WEAPON_SYSTEM_LARGE_OFFENSE
        );

        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_MASTER_VESSEL
                )
            ),
            ANCIENT_MASTER_VESSEL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_CRUISER
                )
            ),
            ANCIENT_CRUISER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_DESTROYER
                )
            ),
            ANCIENT_DESTROYER_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_FIGHTER_PLANE
                )
            ),
            ANCIENT_FIGHTER_PLANE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_MARKET_SHIP
                )
            ),
            ANCIENT_MARKET_SHIP_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_MINING_SHIP_SMALL
                )
            ),
            ANCIENT_MINING_SHIP_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM
                )
            ),
            ANCIENT_MINING_SHIP_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_MINING_SHIP_LARGE
                )
            ),
            ANCIENT_MINING_SHIP_LARGE_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL
                )
            ),
            ANCIENT_WEAPON_SYSTEM_SMALL_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_WEAPON_SYSTEM_MEDIUM
                )
            ),
            ANCIENT_WEAPON_SYSTEM_MEDIUM_OFFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.offense',
                    ShipAndTechList.ANCIENT_WEAPON_SYSTEM_LARGE
                )
            ),
            ANCIENT_WEAPON_SYSTEM_LARGE_OFFENSE
        );

        // Ship & Technology Defense
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_MASTER_VESSEL
                )
            ),
            FEDERATION_MASTER_VESSEL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_CRUISER
                )
            ),
            FEDERATION_CRUISER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_DESTROYER
                )
            ),
            FEDERATION_DESTROYER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_FIGHTER_PLANE
                )
            ),
            FEDERATION_FIGHTER_PLANE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_MARKET_SHIP
                )
            ),
            FEDERATION_MARKET_SHIP_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_MINING_SHIP_SMALL
                )
            ),
            FEDERATION_MINING_SHIP_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM
                )
            ),
            FEDERATION_MINING_SHIP_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_MINING_SHIP_LARGE
                )
            ),
            FEDERATION_MINING_SHIP_LARGE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL
                )
            ),
            FEDERATION_WEAPON_SYSTEM_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM
                )
            ),
            FEDERATION_WEAPON_SYSTEM_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE
                )
            ),
            FEDERATION_WEAPON_SYSTEM_LARGE_DEFENSE
        );

        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_MASTER_VESSEL
                )
            ),
            ALIEN_MASTER_VESSEL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_CRUISER
                )
            ),
            ALIEN_CRUISER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_DESTROYER
                )
            ),
            ALIEN_DESTROYER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_FIGHTER_PLANE
                )
            ),
            ALIEN_FIGHTER_PLANE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_MARKET_SHIP
                )
            ),
            ALIEN_MARKET_SHIP_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_MINING_SHIP_SMALL
                )
            ),
            ALIEN_MINING_SHIP_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM
                )
            ),
            ALIEN_MINING_SHIP_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_MINING_SHIP_LARGE
                )
            ),
            ALIEN_MINING_SHIP_LARGE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL
                )
            ),
            ALIEN_WEAPON_SYSTEM_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM
                )
            ),
            ALIEN_WEAPON_SYSTEM_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE
                )
            ),
            ALIEN_WEAPON_SYSTEM_LARGE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.FEDERATION_MASTER_VESSEL
                )
            ),
            FEDERATION_MASTER_VESSEL_DEFENSE
        );

        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_CRUISER
                )
            ),
            ADVANCED_RACE_CRUISER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_DESTROYER
                )
            ),
            ADVANCED_RACE_DESTROYER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE
                )
            ),
            ADVANCED_RACE_FIGHTER_PLANE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_MARKET_SHIP
                )
            ),
            ADVANCED_RACE_MARKET_SHIP_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL
                )
            ),
            ADVANCED_RACE_MINING_SHIP_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM
                )
            ),
            ADVANCED_RACE_MINING_SHIP_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE
                )
            ),
            ADVANCED_RACE_MINING_SHIP_LARGE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL
                )
            ),
            ADVANCED_RACE_WEAPON_SYSTEM_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM
                )
            ),
            ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE
                )
            ),
            ADVANCED_RACE_WEAPON_SYSTEM_LARGE_DEFENSE
        );

        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_MASTER_VESSEL
                )
            ),
            ANCIENT_MASTER_VESSEL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_CRUISER
                )
            ),
            ANCIENT_CRUISER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_DESTROYER
                )
            ),
            ANCIENT_DESTROYER_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_FIGHTER_PLANE
                )
            ),
            ANCIENT_FIGHTER_PLANE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_MARKET_SHIP
                )
            ),
            ANCIENT_MARKET_SHIP_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_MINING_SHIP_SMALL
                )
            ),
            ANCIENT_MINING_SHIP_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM
                )
            ),
            ANCIENT_MINING_SHIP_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_MINING_SHIP_LARGE
                )
            ),
            ANCIENT_MINING_SHIP_LARGE_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL
                )
            ),
            ANCIENT_WEAPON_SYSTEM_SMALL_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_WEAPON_SYSTEM_MEDIUM
                )
            ),
            ANCIENT_WEAPON_SYSTEM_MEDIUM_DEFENSE
        );
        es.setUint8(
            keccak256(
                abi.encodePacked(
                    'constants.sats.defense',
                    ShipAndTechList.ANCIENT_WEAPON_SYSTEM_LARGE
                )
            ),
            ANCIENT_WEAPON_SYSTEM_LARGE_DEFENSE
        );
    }
}
