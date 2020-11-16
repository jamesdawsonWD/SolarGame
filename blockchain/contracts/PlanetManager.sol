pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import {Planet} from './Planet.sol';
import {Planets} from './Planets.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {ITreasury} from './interfaces/ITreasury.sol';
import {GameStorage} from './GameStorage.sol';
import {IPlanets} from './interfaces/IPlanets.sol';
import {ISolar} from './interfaces/ISolar.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Initializable} from '@openzeppelin/upgrades-core/contracts/Initializable.sol';

contract PlanetManager is Ownable, Initializable {
    using SafeMath for uint256;
    ITreasury ts;
    IPlanets planets;
    ISolar solar;
    GameStorage gs;
    address planetImplementation;
    event ProxyCreated(address proxy);

    modifier onlyPlanet() {
        require(gs.getProxyAddressToTokenId(msg.sender) != 0, 'Only planets');
        _;
    }

    function initialize(address _gameStorage) public initializer {
        gs = GameStorage(_gameStorage);
        ts = ITreasury(gs.getTreasuryAddress());
        planetImplementation = gs.getPlanetImplementation();
        solar = ISolar(gs.getSolarAddress());
        planets = IPlanets(gs.getPlanetsAddress());
    }

    function createPlanet(uint256 tokenId) public returns (address) {
        emit ProxyCreated(planetImplementation);
        bytes memory _data = abi.encodeWithSignature(
            'initialize(address,uint256,uint256)',
            address(gs),
            tokenId,
            gs.getTokenIdToYield(tokenId)
        );
        address proxy = deployMinimal(planetImplementation, _data);
        gs.setProxyAddressToTokenId(tokenId, proxy);
        return proxy;
    }

    function requestReward(
        uint256 staked,
        uint256 amount,
        uint256 yield,
        uint256 held,
        uint256 tokenId,
        address requestor,
        address planet
    ) public onlyPlanet {
        require(planets.ownerOf(tokenId) == requestor, 'The sender must be the owner of the planet token');
        require(solar.balanceOf(planet) == staked, 'Check the balance of the planet is correct');
        uint256 percentageOfYear = held.mul(100).div(365 days);
        uint256 reward = staked.mul(yield.mul(percentageOfYear).div(100)).div(100);
        ts.mintSolar(requestor, amount);
    }

    function deployMinimal(address _logic, bytes memory _data) internal returns (address proxy) {
        bytes20 targetBytes = bytes20(_logic);
        assembly {
            let clone := mload(0x40)
            mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
            mstore(add(clone, 0x14), targetBytes)
            mstore(add(clone, 0x28), 0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000)
            proxy := create(0, clone, 0x37)
        }

        emit ProxyCreated(address(proxy));
        if (_data.length > 0) {
            (bool success, ) = proxy.call(_data);
            require(success);
        }
    }
}
