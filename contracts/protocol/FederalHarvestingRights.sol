// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract FederalHarvestingRights is
    ERC721('FederalHarvestingRights', 'FHR'),
    Ownable
{
    address internal operator;

    constructor(address _operator) public {
        operator = _operator;
    }

    modifier onlyOperator() {
        require(msg.sender == operator);
        _;
    }

    function mint(address _to, uint256 _tokenId) public onlyOperator {
        _safeMint(_to, _tokenId);
    }

    function setOperator(address _operator) public onlyOwner {}
}
