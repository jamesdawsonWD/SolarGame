pragma solidity 0.6.12;

library Types {
    // STAR POSITION
    struct Position {
        uint8 quadrant;
        uint8 sector;
        uint8 district;
        uint256 star;
    }

    function positionIsEqual(Position memory a, Position memory b) internal returns (bool) {
        return (a.quadrant == b.quadrant &&
            a.district == b.district &&
            a.sector == b.sector &&
            a.star == b.star);
    }

    function positionIsEqualUint(uint256 a, uint256 b) internal returns (bool) {
        return a == b;
    }

    function positionNotSet(Position memory a) internal returns (bool) {
        return (a.quadrant == 0 || a.district == 0 || a.sector == 0 || a.star == 0);
    }

    function positionWithinBoundaries(Position memory a, Position memory boundaries) internal returns (bool) {
        if (a.quadrant <= 0 || a.quadrant > boundaries.quadrant) return false;
        if (a.district <= 0 || a.district > boundaries.district) return false;
        if (a.sector <= 0 || a.sector > boundaries.sector) return false;
        if (a.star <= 0 || a.star > boundaries.star) return false;
        return true;
    }

    // STAR SYSTEM

    enum SystemType {
        Undiscovered,
        AncientFleetAggressive,
        SuperComputerEvent,
        AdvancedAlienFleetAggressive,
        AiFleetAggressive,
        AlienFleetAggressive,
        PiratesEvent,
        SolarWinds,
        Asteroids,
        Empty,
        GovermentOwned,
        LowYieldSystem,
        RandomEvent,
        MediumYieldSystem,
        ShipWreck,
        HighYieldSystem,
        AncientMiningSystem,
        AncientWeaponSystem,
        AncientShipWreck,
        InsaneYieldSystem,
        AncientRacePassive
    }
    struct StarSystem {
        SystemType systemType;
        uint256 investment;
        uint256 tokenId;
        uint16 yield;
        bool hasFleet;
    }

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
        ANCIENT_MARKET_SHIP,
        PIRATE_SHIP
    }

    // SHIPS AND TECHNOLOGY
    struct SatInfo {
        uint256 amount;
        uint256 id;
    }

    struct SatStats {
        uint8 offense;
        uint8 defense;
    }

    struct RangeUint8 {
        uint8 low;
        uint8 high;
    }

    struct Range {
        uint256 low;
        uint256 high;
    }

    function getFederationShips() public pure returns (uint256[4] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE)
        ];
    }

    function getAlienShips() public pure returns (uint256[4] memory) {
        return [
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE)
        ];
    }

    function getAdvancedRaceShips() public pure returns (uint256[4] memory) {
        return [
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE)
        ];
    }

    function getAnecienteShips() public pure returns (uint256[4] memory) {
        return [
            uint256(ShipAndTechList.ANCIENT_CRUISER),
            uint256(ShipAndTechList.ANCIENT_DESTROYER),
            uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL),
            uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE)
        ];
    }

    function getPirateShips() public pure returns (uint256[1] memory) {
        return [uint256(ShipAndTechList.PIRATE_SHIP)];
    }

    function getAllNonAncientShips() public pure returns (uint256[12] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE)
        ];
    }

    function getAllShips() public pure returns (uint256[17] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE),
            uint256(ShipAndTechList.ANCIENT_CRUISER),
            uint256(ShipAndTechList.ANCIENT_DESTROYER),
            uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL),
            uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE),
            uint256(ShipAndTechList.PIRATE_SHIP)
        ];
    }
}
