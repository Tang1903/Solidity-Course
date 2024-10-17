// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract dataLocationAndAssignRule{

    uint[] x = [1,2,3];      // 状态变量

    function fStorage() public {

        // 声明一个storage 的变量 xStorage ，指向 x， 修改 xStorage 也会影响 x
        uint[] storage xStorage = x;

        xStorage[0] = 200;
        
    }
}