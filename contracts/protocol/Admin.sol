// SPDX-License-Identifier: MIT

// code to deploy DyDx solo protocol locally
pragma solidity 0.6.12;
import {State} from './State.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';

contract Admin is State, Ownable {
    function setSolarAddress(address _solar) public onlyOwner {
        g_state.solarAddress = _solar;
    }

    function setFHRAddress(address _FHR) public onlyOwner {
        g_state.fhrAddress = _FHR;
    }

    function setSATsAddress(address _SATs) public onlyOwner {
        g_state.satsAddress = _SATs;
    }

    function setTimeLockAddress(address _Timelock) public onlyOwner {
        g_state.timeLockAddress = _Timelock;
    }
}
