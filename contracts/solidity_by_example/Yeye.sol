// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

// 写一个爷爷合约Yeye，里面包含1个Log事件和3个function: hip(), pop(), yeye()，输出都是”Yeye”。
contract Yeye {
    event Log(string msg);

    // 定义3个 function：hip()  , pop() , man()  , log值 为 Yeye
    function hip() public virtual {
        emit Log("Yeye");
    }

    function pop() public virtual {
        emit Log("Yeye");
    }

    function yeye() public virtual {
        emit Log("Yeye");
    }
}

contract Baba is Yeye{
    
    function hip() public virtual override{     // 继承两个function: hip()和pop()，输出改为Baba。
        emit Log("Baba");
    }

    function pop() public virtual override{
        emit Log("Baba");
    }

    function baba() public virtual{
        emit Log("Baba");
    }
}
