// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import {IFHR} from './interfaces/IFHR.sol';
import {ISolar} from './interfaces/ISolar.sol';
import {ISat} from './interfaces/ISat.sol';
import {EternalStorage} from './EternalStorage.sol';
import {ERC1155Holder} from '@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol';
import {ERC721Holder} from '@openzeppelin/contracts/token/ERC721/ERC721Holder.sol';

contract Treasury is ERC1155Holder, ERC721Holder {
    IFHR fhr;
    ISolar solar;
    ISat sats;
    EternalStorage es;

    function initialize(address _es) public {
        es = EternalStorage(_es);
        fhr = IFHR(es.getAddress(keccak256('contract.address.fhr')));
        solar = ISolar(es.getAddress(keccak256('contract.address.solar')));
        sats = ISat(es.getAddress(keccak256('contract.address.sat')));
    }

    function sendSats(
        address _to,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) public {
        sats.safeBatchTransferFrom(address(this), _to, _ids, _amounts, '');
    }

    function recieveSats(
        address _from,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) public {
        sats.safeBatchTransferFrom(_from, address(this), _ids, _amounts, '');
    }

    function mintFhr(address _to, uint256 _tokenId) public {
        fhr.mint(_to, _tokenId);
    }

    function recieveFhr(address _from, uint256 _tokenId) public {
        fhr.safeTransferFrom(_from, address(this), _tokenId);
    }

    function sendFhr(address _to, uint256 _tokenId) public {
        fhr.safeTransferFrom(address(this), _to, _tokenId);
    }

    function mintSolar(address _to, uint256 _amount) public {
        solar.mint(_to, _amount);
    }

    function sendSolar(address _to, uint256 _amount) public {
        solar.transfer(_to, _amount);
    }

    function sendSolarReward(
        address _to,
        uint256 _amount,
        uint256 _reward
    ) public {
        solar.transfer(_to, _amount);
        solar.mint(_to, _reward);
    }

    function recieveSolar(address _from, uint256 _amount) public {
        solar.transferFrom(_from, address(this), _amount);
    }
}
