import {ERC1155Holder} from '@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol';
import {IFHR} from './interfaces/IFHR.sol';
import {ISolar} from './interfaces/ISolar.sol';
import {ISat} from './interfaces/ISat.sol';
import '@openzeppelin/upgrades/contracts/Initializable.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';

interface IPlanetManager {
    function rewardPlanet(address _to, uint256 _amount) external;
}

contract Planet is ERC1155Holder, Initializable {
    using SafeMath for uint256;

    uint256 public tokenId;
    uint256 public yield;
    uint256 public dateLocked;
    uint256 public minHold;
    uint256 public staked;
    IFHR fhr;
    ISolar solar;
    IPlanetManager pm;
    ISat sats;

    function initialize(
        address _planetManager,
        address _solar,
        address _fhr,
        address _sats,
        uint256 _yield,
        uint256 _tokenId
    ) public {
        tokenId = _tokenId;
        yield = _yield;
        minHold = 14 days;

        solar = ISolar(_solar);
        fhr = IFHR(_fhr);
        sats = ISat(_sats);
        pm = IPlanetManager(_planetManager);
    }

    // modifier onlyTokenHolder() {
    //     require(fhr.ownerOf(tokenId) == msg.sender, 'Sender not owner');
    //     _;
    // }

    function depositSolar(uint256 amount) public {
        if (staked > 0) {
            // calculate and pay interest so far if there is already solar deposited
        }
        solar.transferFrom(msg.sender, address(this), amount);
        staked = staked.add(amount);
        dateLocked = now;
    }

    function withdrawSolar(uint256 amount) public {
        require(amount <= staked, 'Amount greater than balance');

        uint256 held = now.sub(dateLocked);
        require(held >= minHold, 'Minimum hold not complete');

        uint256 percentageOfYear = held.mul(100).div(365 days);
        uint256 reward = staked.mul(yield.mul(percentageOfYear).div(100)).div(100);
        solar.transfer(msg.sender, amount);
        pm.rewardPlanet(msg.sender, reward);

        if (staked.sub(amount) == 0) dateLocked = 0;
    }

    function depositSats(uint256[] memory _ids, uint256[] memory _amounts) public {
        sats.safeBatchTransferFrom(msg.sender, address(this), _ids, _amounts, '');
    }

    function withdrawSats(uint256[] memory _ids, uint256[] memory _amounts) public {
        sats.safeBatchTransferFrom(address(this), msg.sender, _ids, _amounts, '');
    }
}
