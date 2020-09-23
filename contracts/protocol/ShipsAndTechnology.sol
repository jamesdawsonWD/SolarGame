// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC1155} from '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract ShipsAndTechnology is Ownable, ERC1155 {
    uint256 public constant CRUISER = 0;
    uint256 public constant DESTROYER = 1;
    uint256 public constant THORS_HAMMER = 2;
    uint256 public constant SWORD = 3;
    uint256 public constant SHIELD = 4;
    address private operator;

    constructor() public ERC1155('https://game.example/api/item/{1}.json') {
        _mint(msg.sender, CRUISER, 10**18, '');
        _mint(msg.sender, DESTROYER, 10**27, '');
        _mint(msg.sender, THORS_HAMMER, 1, '');
        _mint(msg.sender, SWORD, 10**9, '');
        _mint(msg.sender, SHIELD, 10**9, '');
    }

    function setOperator(address _operator) public onlyOwner {
        operator = _operator;
    }
}
