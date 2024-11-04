// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FunctionModifier {

    address public owner;

    constructor() {
        
        owner = msg.sender;  // 初始化时， 将 交易发送方 设置为 合约 的 所有者 
    }

    // 通过 关键字 modifier 来定义 一个修饰器 onlyOwner
    modifier onlyOwner() {

        require(msg.sender == owner, "Not owner");  // 检查调用者是否为owner地址 

        _;  // 如果是的话，继续执行 回changeOwner函数 主体；否则报错 并 revert交易

    }

    // 带有 onlyOwner修饰符 的 函数 只能被 owner地址调用
    function changeOwner(address _newOwner) external onlyOwner{

        owner = _newOwner;  

    }

}


// 上面例子中，定义一个叫做 onlyOwner 的 modifier，然后 定义了 一个 changeOwner 函数 并添加 onlyOwner 修饰器。 
// 调用 changeOwner 函数 可以改变 合约 的 owner，但是由于 onlyOwner 修饰器 的存在，所以只有 原先的 owner 可以调用，
// 别人调用 就会报错，这也是最常用的 控制 智能合约 权限 的方法。

// 在Solidity修饰符中，_（下划线）代表 被修饰函数 的 原始（主体）代码块。
// 当 你 在 包含有 modifier 修饰符 的 函数 中 使用  _; 时，你实际上 是在告诉 Solidity编译器：
// “现在，执行 被这个修饰符修饰的函数 的 剩余部分”。
// 换句话说， _  是一个 占位符，用于 调用 修饰符 所附加 的 函数 的 主体。
