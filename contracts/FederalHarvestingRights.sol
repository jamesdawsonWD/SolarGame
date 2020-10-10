// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC721} from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {EternalStorage} from './EternalStorage.sol';

contract FederalHarvestingRights is ERC721('FederalHarvestingRights', 'FHR'), Ownable {
    EternalStorage es;

    constructor(address _es) public {
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
        _safeMint(_to, _tokenId);
    }
}
