import {ERC1155Holder} from '@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol';
import {ISolar} from './interfaces/ISolar.sol';
import {ISat} from './interfaces/ISat.sol';
import '@openzeppelin/upgrades/contracts/Initializable.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {GameStorage} from './GameStorage.sol';

interface IPlanetManager {
    function requestReward(
        uint256 staked,
        uint256 amount,
        uint256 yield,
        uint256 held,
        uint256 tokenId,
        address requestor,
        address planet
    ) external;
}

contract Planet is ERC1155Holder, Initializable {
    using SafeMath for uint256;
    GameStorage gs;
    ISolar solar;
    ISat sat;
    IPlanetManager pm;

    uint256 public yield;
    uint256 public dateLocked;
    uint256 public minHold;
    uint256 public staked;
    uint256 public tokenId;

    function initialize(
        address _gameStorage,
        uint256 _yield,
        uint256 _tokenId
    ) public {
        tokenId = _tokenId;
        yield = _yield;
        minHold = 14 days;
        gs = GameStorage(_gameStorage);
        solar = ISolar(gs.getSolarAddress());
        sat = ISat(gs.getSatAddress());
        pm = IPlanetManager(gs.getPlanetManagerAddress());
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

        pm.requestReward(staked, amount, yield, held, tokenId, msg.sender, address(this));
        solar.transfer(msg.sender, amount);

        staked = staked.sub(amount);
        if (staked == 0) dateLocked = 0;
    }

    function depositSats(uint256[] memory _ids, uint256[] memory _amounts) public {
        sat.safeBatchTransferFrom(msg.sender, address(this), _ids, _amounts, '');
    }

    function withdrawSats(uint256[] memory _ids, uint256[] memory _amounts) public {
        sat.safeBatchTransferFrom(address(this), msg.sender, _ids, _amounts, '');
    }
}
