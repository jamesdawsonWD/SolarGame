// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;
import {IFHR} from './interfaces/IFHR.sol';
import {ISolar} from './interfaces/ISolar.sol';
import {ISat} from './interfaces/ISat.sol';
import {EternalStorage} from './EternalStorage.sol';
import {ERC1155Holder} from '@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol';
import {ERC721Holder} from '@openzeppelin/contracts/token/ERC721/ERC721Holder.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract Treasury is ERC1155Holder, ERC721Holder, Ownable {
    IFHR fhr;
    ISolar solar;
    ISat sats;
    mapping(address => bool) operators;

    modifier onlyOperator() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(operators[msg.sender], 'Only Operator');
        _;
    }

    function initialize(
        address _fhr,
        address _solar,
        address _sats,
        address _gameOperations,
        address _planetManager
    ) public onlyOwner {
        fhr = IFHR(_fhr);
        solar = ISolar(_solar);
        sats = ISat(_sats);
        operators[_gameOperations] = true;
        operators[_planetManager] = true;
    }

    function addOperator(address _operator) public onlyOwner {
        operators[_operator] = true;
    }

    function sendSats(
        address _to,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) public onlyOperator {
        sats.safeBatchTransferFrom(address(this), _to, _ids, _amounts, '');
    }

    function recieveSats(
        address _from,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) public onlyOperator {
        sats.safeBatchTransferFrom(_from, address(this), _ids, _amounts, '');
    }

    function mintFhr(address _to, uint256 _tokenId) public onlyOperator {
        fhr.mint(_to, _tokenId);
    }

    function recieveFhr(address _from, uint256 _tokenId) public onlyOperator {
        fhr.safeTransferFrom(_from, address(this), _tokenId);
    }

    function transferFhr(
        address _from,
        address _to,
        uint256 _tokenId
    ) public onlyOperator {
        fhr.safeTransferFrom(_from, _to, _tokenId);
    }

    function sendFhr(address _to, uint256 _tokenId) public onlyOperator {
        fhr.safeTransferFrom(address(this), _to, _tokenId);
    }

    function mintSolar(address _to, uint256 _amount) public onlyOperator {
        solar.mint(_to, _amount);
    }

    function sendSolar(address _to, uint256 _amount) public onlyOperator {
        solar.transfer(_to, _amount);
    }

    function sendSolarReward(
        address _to,
        uint256 _amount,
        uint256 _reward
    ) public onlyOperator {
        solar.transfer(_to, _amount);
        solar.mint(_to, _reward);
    }

    function recieveSolar(address _from, uint256 _amount) public onlyOperator {
        solar.transferFrom(_from, address(this), _amount);
    }
}
