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

    function positionWithinBoundaries(Position memory a, Position memory boundaries)
        internal
        returns (bool)
    {
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

    function getFederationShips() public pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.FEDERATION_MARKET_SHIP),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_LARGE)
        ];
    }

    function getFederationWeapons() public pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAlienShips() public pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_MARKET_SHIP),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_LARGE)
        ];
    }

    function getAlienWeapons() public pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAdvancedRaceShips() public pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_MARKET_SHIP),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE)
        ];
    }

    function getAdvancedRaceWeapons() public pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAnecienteShips() public pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.ANCIENT_CRUISER),
            uint256(ShipAndTechList.ANCIENT_DESTROYER),
            uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL),
            uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE),
            uint256(ShipAndTechList.ANCIENT_MARKET_SHIP),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_LARGE)
        ];
    }

    function getAncientMiningShip() public pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_LARGE)
        ];
    }

    function getAncientWeapons() public pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getPirateShips() public pure returns (uint256[1] memory) {
        return [uint256(ShipAndTechList.PIRATE_SHIP)];
    }

    function getAllNonAncientShips() public pure returns (uint256[24] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.FEDERATION_MARKET_SHIP),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_MARKET_SHIP),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_MARKET_SHIP),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE)
        ];
    }

    function getAllShips() public pure returns (uint256[33] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.FEDERATION_MARKET_SHIP),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_MARKET_SHIP),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_MARKET_SHIP),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ANCIENT_CRUISER),
            uint256(ShipAndTechList.ANCIENT_DESTROYER),
            uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL),
            uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE),
            uint256(ShipAndTechList.ANCIENT_MARKET_SHIP),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.PIRATE_SHIP)
        ];
    }

    function getAllNonAncientWeapons() public pure returns (uint256[9] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAllWeapons() public pure returns (uint256[12] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_LARGE)
        ];
    }
}
