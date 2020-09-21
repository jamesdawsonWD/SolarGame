// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC20} from '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract TsunoToken is ERC20('TsunoToken', 'TSUNO'), Ownable {
    address private operator;
    modifier onlyOperator() {
        require(msg.sender == operator);
        _;
    }

    function mint(address _to, uint256 _amount) public onlyOperator {
        _mint(_to, _amount);
    }

    function setOperator(address _operator) public onlyOwner {
        operator = _operator;
    }
}
