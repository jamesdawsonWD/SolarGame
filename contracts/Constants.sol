pragma solidity 0.6.12;
import './BaseStorage.sol';

contract Constants is BaseStorage {
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
    uint16 constant TOTAL_SAT_ITEMS = 18;

    // Bonus Variables
    uint256 constant DEFENSE_BONUS = 100000;

    enum ShipAndTechList {
        FEDERATION_MASTER_VESSEL,
        FEDERATION_CRUISER,
        FEDERATION_DESTROYER,
        FEDERATION_FIGHTER_PLANE,
        ALIEN_MASTER_VESSEL,
        ALIEN_CRUISER,
        ALIEN_DESTROYER,
        ALIEN_FIGHTER_PLANE,
        ADVANCED_RACE_MASTER_VESSEL,
        ADVANCED_RACE_CRUISER,
        ADVANCED_RACE_DESTROYER,
        ADVANCED_RACE_FIGHTER_PLANE,
        ANCIENT_MASTER_VESSEL,
        ANCIENT_CRUISER,
        ANCIENT_DESTROYER,
        ANCIENT_FIGHTER_PLANE,
        PIRATE_SHIP,
        PIRATE_WEAPON
    }

    // Ships and technology attack
    uint8 constant FEDERATION_MASTER_VESSEL_OFFENSE = 9;
    uint8 constant FEDERATION_CRUISER_OFFENSE = 10;
    uint8 constant FEDERATION_DESTROYER_OFFENSE = 15;
    uint8 constant FEDERATION_FIGHTER_PLANE_OFFENSE = 2;

    uint8 constant ALIEN_MASTER_VESSEL_OFFENSE = 12;
    uint8 constant ALIEN_CRUISER_OFFENSE = 13;
    uint8 constant ALIEN_DESTROYER_OFFENSE = 10;
    uint8 constant ALIEN_FIGHTER_PLANE_OFFENSE = 3;

    uint8 constant ADVANCED_RACE_MASTER_VESSEL_OFFENSE = 15;
    uint8 constant ADVANCED_RACE_CRUISER_OFFENSE = 15;
    uint8 constant ADVANCED_RACE_DESTROYER_OFFENSE = 20;
    uint8 constant ADVANCED_RACE_FIGHTER_PLANE_OFFENSE = 5;

    uint8 constant ANCIENT_MASTER_VESSEL_OFFENSE = 20;
    uint8 constant ANCIENT_CRUISER_OFFENSE = 21;
    uint8 constant ANCIENT_DESTROYER_OFFENSE = 30;
    uint8 constant ANCIENT_FIGHTER_PLANE_OFFENSE = 10;

    uint8 constant PIRATE_SHIP_OFFENSE = 12;

    // Ships and technology Defense
    uint8 constant FEDERATION_MASTER_VESSEL_DEFENSE = 9;
    uint8 constant FEDERATION_CRUISER_DEFENSE = 10;
    uint8 constant FEDERATION_DESTROYER_DEFENSE = 15;
    uint8 constant FEDERATION_FIGHTER_PLANE_DEFENSE = 2;

    uint8 constant ALIEN_MASTER_VESSEL_DEFENSE = 12;
    uint8 constant ALIEN_CRUISER_DEFENSE = 13;
    uint8 constant ALIEN_DESTROYER_DEFENSE = 10;
    uint8 constant ALIEN_FIGHTER_PLANE_DEFENSE = 3;

    uint8 constant ADVANCED_RACE_MASTER_VESSEL_DEFENSE = 15;
    uint8 constant ADVANCED_RACE_CRUISER_DEFENSE = 15;
    uint8 constant ADVANCED_RACE_DESTROYER_DEFENSE = 20;
    uint8 constant ADVANCED_RACE_FIGHTER_PLANE_DEFENSE = 5;

    uint8 constant ANCIENT_MASTER_VESSEL_DEFENSE = 20;
    uint8 constant ANCIENT_CRUISER_DEFENSE = 21;
    uint8 constant ANCIENT_DESTROYER_DEFENSE = 30;
    uint8 constant ANCIENT_FIGHTER_PLANE_DEFENSE = 10;

    uint8 constant PIRATE_SHIP_DEFENSE = 12;

    function resetConstants() public {
        // Yield Constants
        lowYieldRange.low = LOW_YIELD_LOW;
        lowYieldRange.high = LOW_YIELD_HIGH;
        mediumYieldRange.low = MEDIUM_YIELD_LOW;
        mediumYieldRange.high = MEDIUM_YIELD_HIGH;
        highYieldRange.low = HIGH_YIELD_LOW;
        highYieldRange.high = HIGH_YIELD_HIGH;
        insaneYieldRange.low = INSANE_YIELD_LOW;
        insaneYieldRange.high = INSANE_YIELD_HIGH;

        startPosition = Types.Position({
            quadrant: START_POSITION_QUADRANT,
            district: START_POSITION_DISTRICT,
            sector: START_POSITION_SECTOR,
            star: START_POSITION_STAR
        });
        boundaries = Types.Position({
            quadrant: MAX_QUADRANT,
            district: MAX_DISTRICT,
            sector: MAX_SECTOR,
            star: MAX_STAR
        });

        maxRoll = MAX_ROLL;

        easyAiRange.low = MIN_ALIENFLEET_O_D;
        easyAiRange.high = MAX_ALIENFLEET_O_D;

        mediumAiRange.low = MAX_ADVANCED_ALIENFLEET_O_D;
        mediumAiRange.high = MAX_ADVANCED_ALIENFLEET_O_D;

        hardAiRange.low = MAX_ANCIENTFLEET_O_D;
        hardAiRange.high = MAX_ANCIENTFLEET_O_D;

        totalSats = TOTAL_SAT_ITEMS;

        Types.SatStats[17] memory stats = [
            Types.SatStats({
                offense: FEDERATION_MASTER_VESSEL_OFFENSE,
                defense: FEDERATION_MASTER_VESSEL_DEFENSE
            }),
            Types.SatStats({
                offense: FEDERATION_CRUISER_OFFENSE,
                defense: FEDERATION_CRUISER_DEFENSE
            }),
            Types.SatStats({
                offense: FEDERATION_DESTROYER_OFFENSE,
                defense: FEDERATION_DESTROYER_DEFENSE
            }),
            Types.SatStats({
                offense: FEDERATION_FIGHTER_PLANE_OFFENSE,
                defense: FEDERATION_FIGHTER_PLANE_DEFENSE
            }),
            Types.SatStats({
                offense: ALIEN_MASTER_VESSEL_OFFENSE,
                defense: ALIEN_MASTER_VESSEL_DEFENSE
            }),
            Types.SatStats({offense: ALIEN_CRUISER_OFFENSE, defense: ALIEN_CRUISER_DEFENSE}),
            Types.SatStats({offense: ALIEN_DESTROYER_OFFENSE, defense: ALIEN_DESTROYER_DEFENSE}),
            Types.SatStats({
                offense: ALIEN_FIGHTER_PLANE_OFFENSE,
                defense: ALIEN_FIGHTER_PLANE_DEFENSE
            }),
            Types.SatStats({
                offense: ADVANCED_RACE_MASTER_VESSEL_OFFENSE,
                defense: ADVANCED_RACE_MASTER_VESSEL_DEFENSE
            }),
            Types.SatStats({
                offense: ADVANCED_RACE_CRUISER_OFFENSE,
                defense: ADVANCED_RACE_CRUISER_DEFENSE
            }),
            Types.SatStats({
                offense: ADVANCED_RACE_DESTROYER_OFFENSE,
                defense: ADVANCED_RACE_DESTROYER_DEFENSE
            }),
            Types.SatStats({
                offense: ADVANCED_RACE_FIGHTER_PLANE_OFFENSE,
                defense: ADVANCED_RACE_FIGHTER_PLANE_DEFENSE
            }),
            Types.SatStats({
                offense: ANCIENT_MASTER_VESSEL_OFFENSE,
                defense: ANCIENT_MASTER_VESSEL_DEFENSE
            }),
            Types.SatStats({offense: ANCIENT_CRUISER_OFFENSE, defense: ANCIENT_CRUISER_DEFENSE}),
            Types.SatStats({
                offense: ANCIENT_DESTROYER_OFFENSE,
                defense: ANCIENT_DESTROYER_DEFENSE
            }),
            Types.SatStats({
                offense: ANCIENT_FIGHTER_PLANE_OFFENSE,
                defense: ANCIENT_FIGHTER_PLANE_DEFENSE
            }),
            Types.SatStats({offense: PIRATE_SHIP_OFFENSE, defense: PIRATE_SHIP_DEFENSE})
        ];
        for (uint256 i = 0; i < stats.length; i++) {
            idToSatStats[i] = stats[i];
        }
    }
    // mapping(uint256 => address) private stakedTokenToOwner;
    // mapping(uint256 => address) private tokenIdToPlanetAddress;
    // mapping(address => Types.Position) private fleetToPosition;
    // mapping(uint256 => Types.SatStats) private tokenIdToSatStats;
    // mapping(Types.Position => Types.SystemType) private positionToSystemType;
}
