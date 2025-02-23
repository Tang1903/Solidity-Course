// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// 意味着 DeployContract合约 将能够使用 DeleteContract合约中 定义的功能。
import "./045Selfdestruct.sol";

contract DeployContract {

    // 将 被用于 demo函数 的 返回值
    struct DemoResult {
        address addr;
        uint balance;
        uint value;
    }

    // 构造函数 被标记为 payable，这意味着 该合约在部署时 可以向其 发送以太币，然而，这里构造函数内部并没有执行任何操作。
    constructor() payable {}

    // 被标记为view 意味着 它不会修改 区块链上的任何状态，它会返回 当前合约的以太币余额。
    function getBalance() external view returns (uint balance) {

        balance = address(this).balance;

    }

    function demo() public payable returns (DemoResult memory) {

        // 使用 msg.value（即：调用者发送的以太币数量）部署 一个新的DeleteContract实例，并将其地址存储在 变量del 中。
        DeleteContract del = new DeleteContract{value: msg.value}();

        DemoResult memory res = DemoResult({
            addr: address(del),
            balance: del.getBalance(),
            value: del.value()
        });

        del.deleteContract(); // 调用del.deleteContract() 用于删除或自毁合约

        return res;
    }
}
