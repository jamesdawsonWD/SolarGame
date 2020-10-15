import {ERC1155Holder} from '@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol';
import {IFHR} from './interfaces/IFHR.sol';
import {ISolar} from './interfaces/ISolar.sol';

contract Planet is ERC1155Holder {
    address public owner;
    address public treasury;
    address public manager;
    uint256 public tokenId;

    constructor(
        address _manager,
        address _treasury,
        address _solar,
        address _fhr,
        address _owner,
        uint256 _tokenId
    ) public {
        manager = _manager;
        owner = _owner;
        tokenId = _tokenId;
        ISolar(_solar).approve(manager, 1000**18);
        IFHR(_fhr).setApprovalForAll(manager, true);
    }

    modifier onlyManager() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(msg.sender == manager, 'Only Planet Manager');
        _;
    }

    function setOwner(address _owner) public onlyManager {
        owner = _owner;
    }
}
