pragma solidity 0.6.12;

import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract EternalStorage is Ownable {
    /**** Storage Types *******/

    mapping(bytes32 => uint256) private uIntStorage;
    mapping(bytes32 => string) private stringStorage;
    mapping(bytes32 => address) private addressStorage;
    mapping(bytes32 => bytes) private bytesStorage;
    mapping(bytes32 => bool) private boolStorage;
    mapping(bytes32 => int256) private intStorage;
    mapping(bytes32 => uint8) private uint8Storage;
    mapping(bytes32 => uint16) private uint16Storage;

    /*** Modifiers ************/

    /// @dev Only allow access from the latest version of a contract in the Rocket Pool network after deployment
    modifier onlyLatestRocketNetworkContract() {
        // The owner and other contracts are only allowed to set the storage upon deployment to register the initial contracts/settings, afterwards their direct access is disabled
        if (
            boolStorage[keccak256(
                abi.encodePacked('contract.storage.initialised')
            )] == true
        ) {
            // Make sure the access is permitted to only contracts in our Dapp
            require(
                boolStorage[keccak256(
                    abi.encodePacked('contract.exists', msg.sender)
                )],
                'Invalid or outdated network contract'
            );
        }
        _;
    }

    /// @dev Construct RocketStorage
    constructor() public {
        // Set the main owner upon deployment
        boolStorage[keccak256(
            abi.encodePacked('access.role', 'owner', msg.sender)
        )] = true;
    }

    /**** Get Methods ***********/

    /// @param _key The key for the record
    function getAddress(bytes32 _key) external view returns (address) {
        return addressStorage[_key];
    }

    /// @param _key The key for the record
    function getUint(bytes32 _key) external view returns (uint256) {
        return uIntStorage[_key];
    }

    /// @param _key The key for the record
    function getString(bytes32 _key) external view returns (string memory) {
        return stringStorage[_key];
    }

    /// @param _key The key for the record
    function getBytes(bytes32 _key) external view returns (bytes memory) {
        return bytesStorage[_key];
    }

    /// @param _key The key for the record
    function getBool(bytes32 _key) external view returns (bool) {
        return boolStorage[_key];
    }

    /// @param _key The key for the record
    function getInt(bytes32 _key) external view returns (int256) {
        return intStorage[_key];
    }

    function getUint8(bytes32 _key) external view returns (uint8) {
        return uint8Storage[_key];
    }

    function getUint16(bytes32 _key) external view returns (uint16) {
        return uint16Storage[_key];
    }

    /**** Set Methods ***********/

    /// @param _key The key for the record
    function setAddress(bytes32 _key, address _value)
        external
        onlyLatestRocketNetworkContract
    {
        addressStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setUint(bytes32 _key, uint256 _value)
        external
        onlyLatestRocketNetworkContract
    {
        uIntStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setString(bytes32 _key, string memory _value)
        external
        onlyLatestRocketNetworkContract
    {
        stringStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBytes(bytes32 _key, bytes memory _value)
        external
        onlyLatestRocketNetworkContract
    {
        bytesStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setBool(bytes32 _key, bool _value)
        external
        onlyLatestRocketNetworkContract
    {
        boolStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setInt(bytes32 _key, int256 _value)
        external
        onlyLatestRocketNetworkContract
    {
        intStorage[_key] = _value;
    }

    /// @param _key The key for the record
    function setUint8(bytes32 _key, uint8 _value)
        external
        onlyLatestRocketNetworkContract
    {
        uint8Storage[_key] = _value;
    }

    /// @param _key The key for the record
    function setUint16(bytes32 _key, uint16 _value)
        external
        onlyLatestRocketNetworkContract
    {
        uint16Storage[_key] = _value;
    }

    /**** Delete Methods ***********/

    /// @param _key The key for the record
    function deleteAddress(bytes32 _key)
        external
        onlyLatestRocketNetworkContract
    {
        delete addressStorage[_key];
    }

    /// @param _key The key for the record
    function deleteUint(bytes32 _key) external onlyLatestRocketNetworkContract {
        delete uIntStorage[_key];
    }

    /// @param _key The key for the record
    function deleteString(bytes32 _key)
        external
        onlyLatestRocketNetworkContract
    {
        delete stringStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBytes(bytes32 _key)
        external
        onlyLatestRocketNetworkContract
    {
        delete bytesStorage[_key];
    }

    /// @param _key The key for the record
    function deleteBool(bytes32 _key) external onlyLatestRocketNetworkContract {
        delete boolStorage[_key];
    }

    /// @param _key The key for the record
    function deleteInt(bytes32 _key) external onlyLatestRocketNetworkContract {
        delete intStorage[_key];
    }

    /// @param _key The key for the record
    function deleteUint8(bytes32 _key)
        external
        onlyLatestRocketNetworkContract
    {
        delete uint8Storage[_key];
    }

    /// @param _key The key for the record
    function deleteUint16(bytes32 _key)
        external
        onlyLatestRocketNetworkContract
    {
        delete uint16Storage[_key];
    }
}
