pragma solidity 0.6.12;

contract Utils {
    function sliceUint(bytes memory bs, uint256 start) internal pure returns (uint256) {
        require(bs.length >= start + 32, 'slicing out of range');
        uint256 x;
        assembly {
            x := mload(add(bs, add(0x20, start)))
        }
        return x;
    }

    function sliceUint16(bytes memory bs, uint256 start) internal pure returns (uint16) {
        require(bs.length >= start + 2, 'slicing out of range');
        uint16 x;
        assembly {
            x := mload(add(bs, add(0x2, start)))
        }
        return x;
    }

    function sliceUint8(bytes memory bs, uint256 start) internal pure returns (uint8) {
        require(bs.length >= start + 1, 'slicing out of range');
        uint8 x;
        assembly {
            x := mload(add(bs, add(0x1, start)))
        }
        return x;
    }
}
