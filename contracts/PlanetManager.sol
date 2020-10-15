pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import {Planet} from './Planet.sol';
import {GameStorage} from './GameStorage.sol';

contract PlanetManager {
    address private treasury;
    address private fhr;
    address private solar;
    GameStorage GS;
    mapping(uint256 => address) tokenIdToPlanetAddress;

    constructor(
        address _treasury,
        address _fhr,
        address _solar,
        address _gameStorage
    ) public {
        treasury = _treasury;
        fhr = _fhr;
        solar = _solar;
        GS = GameStorage(_gameStorage);
    }

    modifier onlyTokenHolder(uint256 _tokenId) {
        // Make sure the access is permitted to only contracts in our Dapp
        require(fhr.ownerOf(tokenId) == msg.sender, 'Sender not owner');
        _;
    }

    function createPlanet(address _owner, uint256 _tokenId) internal returns (address) {
        require(tokenIdToPlanetAddress[_tokenId] == address(0), 'Planet already created');
        Planet p = new Planet(address(this), treasury, fhr, solar, _owner, _tokenId);
        tokenIdToPlanetAddress[_tokenId] = address(p);
        return address(p);
    }

    function getPlanetAddress(uint256 _tokenId) public returns (address) {
        return tokenIdToPlanetAddress[_tokenId];
    }

    function depositSolar(uint256 _tokenId, uint256 amount) public onlyTokenHolder(_tokenId) {
        address planet = getPlanetAddress(tokenId) == address(0)
            ? createPlanet(msg.sender, tokenId)
            : getPlanetAddress(tokenId);

        if (solar.balanceOf(planet) > 0) {
            // calculate and pay interest so far if there is already solar deposited
        }
        solar.transfer(planet, amount);
        GS.setDateStakeLocked(msg.sender, tokenId, now);
    }

    function withdrawSolar(uint256 _tokenId, uint256 amount) public onlyTokenHolder(_tokenId) {
        address planet = getPlanetAddress(tokenId);
        require(planet != address(0), 'Planet not activated');

        uint256 staked = solar.balanceOf(planet);
        require(amount <= staked, 'Amount greater than balance');

        uint256 yield = GS.getStarSystemYield(tokenId);
        uint256 locked = (now.sub(GS.getDateStakeLocked(msg.sender, tokenId))).div(365 days).mul(
            100
        );
        uint256 reward = staked.div(yield).mul(locked);

        TS.mintSolar(msg.sender, reward);
        solar.transfer(planet, amount);
        GS.setStakedBalance(msg.sender, tokenId, staked.sub(amount));

        if (staked.sub(amount) == 0) {
            GS.setDateStakeLocked(msg.sender, tokenId, 0);
        }
    }

    function depositSats(
        uint256 _tokenId,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) public onlyTokenHolder(_tokenId) {
        address planet = getPlanetAddress(tokenId) == address(0)
            ? createPlanet(msg.sender, tokenId)
            : getPlanetAddress(tokenId);
        sats.safeBatchTransferFrom(msg.sender, planet, _ids, _amounts, '');
    }

    function withdrawSats(
        uint256 _tokenId,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) public onlyTokenHolder(_tokenId) {
        address planet = getPlanetAddress(tokenId);
        require(planet != address(0), 'Planet not activated');
        sats.safeBatchTransferFrom(planet, msg.sender, _ids, _amounts, '');
    }
}
