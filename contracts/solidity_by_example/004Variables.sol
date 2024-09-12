// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract Variables{

    // 通过 内置的 type函数 获取 当前的类型变量 的 最大值 最小值
    uint16 public a  = type(uint16).max;

    int32 public b  = type(int32).max;

    // Local Variables 存在 函数内存 中，调用时才有； blockchain 存在链上，要消耗GAS； global 默认的全局变量，整个以太坊自带的变量

    string public text = 'hello,Walking';  // 存在 区块链上 的

    uint public numa = 88;

    function dosomething() public view returns (uint,address) {

        uint numb = 99;   // 内存变量，就在调用这个函数时，才有这个变量

        uint time = block.timestamp;  // 当前区块的时间戳，全局变量，是根据 1970年 到 目前 的 秒数

        address sender = msg.sender;  // mgs.sender 调用 这个函数的地址

        return (time,sender);

    }

}