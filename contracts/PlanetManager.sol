pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import {Planet} from './Planet.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {ITreasury} from './interfaces/ITreasury.sol';

contract PlanetManager is Ownable {
    address public planetImplementation;
    ITreasury ts;
    address private fhr;
    address private solar;
    mapping(address => bool) operators;
    mapping(address => uint256) addressToTokenId;
    event ProxyCreated(address proxy);

    constructor(
        address _planetImplementation,
        address _gameOperations,
        address _treasury
    ) public {
        planetImplementation = _planetImplementation;
        ts = ITreasury(_treasury);
        addOperator(_gameOperations);
    }

    function addOperator(address _operator) public onlyOwner {
        operators[_operator] = true;
    }

    modifier onlyOperator() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(operators[msg.sender], 'Only Operator');
        _;
    }

    modifier onlyPlanet() {
        require(addressToTokenId[msg.sender] != 0, 'Only planets');
        _;
    }

    function createPlanet(uint256 tokenId, bytes memory _data)
        public
        onlyOperator
        returns (address)
    {
        emit ProxyCreated(planetImplementation);
        address proxy = deployMinimal(planetImplementation, _data);
        addressToTokenId[proxy] = tokenId;
        return proxy;
    }

    function rewardPlanet(address _to, uint256 _amount) public onlyPlanet {
        //TODO: more security on this
        ts.mintSolar(_to, _amount);
    }

    function deployMinimal(address _logic, bytes memory _data) internal returns (address proxy) {
        bytes20 targetBytes = bytes20(_logic);
        assembly {
            let clone := mload(0x40)
            mstore(clone, 0x3d602d80600a3d3981f3363d3d373d3d3d363d73000000000000000000000000)
            mstore(add(clone, 0x14), targetBytes)
            mstore(
                add(clone, 0x28),
                0x5af43d82803e903d91602b57fd5bf30000000000000000000000000000000000
            )
            proxy := create(0, clone, 0x37)
        }

        emit ProxyCreated(address(proxy));
        if (_data.length > 0) {
            (bool success, ) = proxy.call(_data);
            require(success);
        }
    }
}
