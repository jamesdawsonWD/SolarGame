import {ERC1155Holder} from '@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol';
import {IFHR} from './interfaces/IFHR.sol';
import {ISolar} from './interfaces/ISolar.sol';
import {ITreasury} from './interfaces/ITreasury.sol';
import {ISat} from './interfaces/ISat.sol';
import '@openzeppelin/upgrades/contracts/Initializable.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';

contract Planet is ERC1155Holder, Initializable {
    using SafeMath for uint256;

    uint256 public tokenId;
    uint256 public yield;
    uint256 public dateLocked;
    uint256 public minHold;
    uint256 public staked;
    IFHR fhr;
    ISolar solar;
    ITreasury ts;
    ISat sats;

    function initialize(
        address _treasury,
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
        ts = ITreasury(_treasury);
    }

    modifier onlyTokenHolder() {
        require(fhr.ownerOf(tokenId) == msg.sender, 'Sender not owner');
        _;
    }

    function depositSolar(uint256 amount) public onlyTokenHolder() {
        if (staked > 0) {
            // calculate and pay interest so far if there is already solar deposited
        }
        solar.transferFrom(msg.sender, address(this), amount);
        staked = staked.add(amount);
        dateLocked = now;
    }

    function withdrawSolar(uint256 amount) public onlyTokenHolder() {
        require(amount <= staked, 'Amount greater than balance');

        uint256 held = now.sub(dateLocked);
        require(held >= minHold, 'Minimum hold not complete');

        uint256 percentageOfYear = held.div(365 days).mul(100);
        uint256 reward = staked.div(100).mul(yield.div(100).mul(percentageOfYear));
        ts.mintSolar(msg.sender, reward);
        solar.transfer(msg.sender, amount);

        if (staked.sub(amount) == 0) dateLocked = 0;
    }

    function depositSats(uint256[] memory _ids, uint256[] memory _amounts)
        public
        onlyTokenHolder()
    {
        sats.safeBatchTransferFrom(msg.sender, address(this), _ids, _amounts, '');
    }

    function withdrawSats(uint256[] memory _ids, uint256[] memory _amounts)
        public
        onlyTokenHolder()
    {
        sats.safeBatchTransferFrom(address(this), msg.sender, _ids, _amounts, '');
    }
}
