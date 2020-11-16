pragma solidity 0.6.12;

contract GE_DiscoverPlanet {
    event Logged(uint256 eventId, address indexed user);
    uint256 eventId;

    function initialize(uint256 _eventId) public {
        eventId = _eventId;
    }

    function start(address user) public {
        emit Logged(eventId, user);
    }

    function reward() private {}
}
