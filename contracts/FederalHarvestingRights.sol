// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {EternalStorage} from './EternalStorage.sol';

contract FederalHarvestingRights is ERC721, Ownable {
    EternalStorage es;
    event Mint(address to, address from, uint256 id);

    constructor(address _es) public ERC721('FederalHarvestingRights', 'FHR') {
        es = EternalStorage(_es);
    }

    modifier onlyOperator() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(
            es.getBool(keccak256(abi.encodePacked('fhr.access', msg.sender))),
            'Sender does not have access to FHR'
        );
        _;
    }

    function mint(address _to, uint256 _tokenId) public onlyOperator {
        emit Mint(_to, msg.sender, _tokenId);
        _safeMint(_to, _tokenId);
    }
}
