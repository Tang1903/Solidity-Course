// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract InsertionSort {
    // 用于测试的数组生成函数
    function generateTestArray() public pure returns(uint[] memory) {
        uint[] memory arr = new uint[](5);
        arr[0] = 5;
        arr[1] = 2;
        arr[2] = 8;
        arr[3] = 1;
        arr[4] = 9;
        return arr;
    }

    // 插入排序实现
    function insertionSort(uint[] memory arr) public pure returns(uint[] memory) {
        // 从第二个元素开始遍历
        for (uint i = 1; i < arr.length; i++) {
            // 保存当前要插入的元素
            uint currentElement = arr[i];
            // 从当前位置向前比较
            uint j = i;

            // 当前元素小于前一个元素时，将前一个元素后移
            while (j >= 1 && currentElement < arr[j-1]) {
                arr[j] = arr[j-1];
                j--;
            }

            // 找到合适的位置，插入当前元素
            arr[j] = currentElement;
        }

        return arr;
    }

    // 验证数组是否已排序
    function isSorted(uint[] memory arr) public pure returns(bool) {
        for (uint i = 1; i < arr.length; i++) {
            if (arr[i] < arr[i-1]) {
                return false;
            }
        }
        return true;
    }
}