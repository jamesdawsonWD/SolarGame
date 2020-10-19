// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract FederalHarvestingRights is ERC721, Ownable {
    event Mint(address to, address from, uint256 id);
    mapping(address => bool) operators;

    constructor(address _treasury) public ERC721('FederalHarvestingRights', 'FHR') {
        addOperator(_treasury);
    }

    function addOperator(address _operator) public onlyOwner {
        operators[_operator] = true;
    }

    modifier onlyOperator() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(operators[msg.sender], 'Only Operator');
        _;
    }

    function mint(address _to, uint256 _tokenId) public onlyOperator {
        emit Mint(_to, msg.sender, _tokenId);
        _safeMint(_to, _tokenId);
    }
}
