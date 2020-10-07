// SPDX-License-Identifier: MIT

pragma solidity ^0.6.2;

import {IERC721} from '@openzeppelin/contracts/token/ERC721/IERC721.sol';

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IFHR is IERC721 {
    function mint(address _to, uint256 _tokenId) external;

    function setOperator(address _operator) external;
}
