// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract CalldataVariableDataStorageLocation{

    function fCalldata(uint[] calldata vds) public pure returns (uint[] calldata) {

        // 由于 calldata 类型 是一个 只读的 和 不可变性 的 类型 ，因此，不能修改，修改会报错！ 

        // vds[0]  = 0;  // 这行代码 会报错 ： Calldata arrays are read-only. 

        return (vds);

    }

    function processDataOne(uint256[] calldata data) public pure{

        // 遍历 calldata 类型 的 数组， 进行只读操作
        for(uint256 i = 0; i < data.length; i++){

            // 假设进行一些处理，但注意不能修改data
            // ...

        }
    }

    // 内部函数 也可以使用 calldata参数
    function processDataTwo(uint256[] calldata data2) internal pure{

         // ...

    }

}

// calldata 类型 本质上 是一个 只读的、不可变 的 内存区域，主要用于存储 外部函数调用时 传递的参数 和 返回值。

// 当 你 尝试 将一个 calldata 类型的变量 赋值给 另一个 calldata 类型的变量 时，你实际上 并不是 在创建数据的副本，而是让 两个变量 引用相同 的 calldata 区域。

// calldata 类型 的 变量 存储 在 内存 中，不上链。

// calldata 类型的变量 一般用在 函数的参数 处