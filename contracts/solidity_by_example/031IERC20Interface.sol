// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {

    function totalSupply() external view returns (uint256);    // 返回  代币的总供应量

    function balanceOf(address account) external view returns (uint256);   // 查询 特定地址 持有的 代币余额

    function transfer(address recipient, uint256 amount) external returns (bool);   // 将 代币 从 一个账户 (调用者地址) 转移到 另一个账户

    function allowance(address owner, address spender) external view returns (uint256);  // 查询 一个账户 允许 另一个账户（即“spender”）, 从 其账户 中 转出的 最大代币数量。

    function approve(address spender, uint256 amount) external returns (bool);  // 批准 一个账户  可以从  你的账户中  转出   指定数量的代币 
    
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);  // 批准 一个账户  可以从  你的账户中  转出   指定数量的代币

}


contract ERC20 is IERC20 {
    
    // 转账事件：记录代币从一个地址转移到另一个地址
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 授权事件：记录代币持有者授权其他地址使用其代币
    event Approval(address indexed owner, address indexed spender, uint256 value);

    uint256 public totalSupply;                              // 代币总供应量
    mapping(address => uint256) public balanceOf;            // 记录每个地址的代币余额
    mapping(address => mapping(address => uint256)) public allowance;  // 记录授权额度：owner => spender => amount
    string public name;                                      // 代币名称
    string public symbol;                                    // 代币符号
    uint8 public decimals;                                   // 代币小数位数

    // 构造函数：初始化代币基本信息
    // @param _name 代币名称
    // @param _symbol 代币符号
    // @param _decimals 代币小数位数
    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    // 转账函数：将代币从调用者地址转移到指定地址
    // @param recipient 接收者地址
    // @param amount 转账金额
    function transfer(address recipient, uint256 amount) external returns (bool){
        balanceOf[msg.sender] -= amount;                     // 扣除发送者余额
        balanceOf[recipient] += amount;                      // 增加接收者余额
        emit Transfer(msg.sender, recipient, amount);        // 触发转账事件
        return true;
    }

    // 授权函数：授权其他地址使用调用者的代币
    // @param spender 被授权的地址
    // @param amount 授权金额
    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;             // 设置授权额度
        emit Approval(msg.sender, spender, amount);          // 触发授权事件
        return true;
    }

    // 授权转账函数：代表其他地址转移代币
    // @param sender 代币持有者地址
    // @param recipient 接收者地址
    // @param amount 转账金额
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){
        allowance[sender][msg.sender] -= amount;             // 减少授权额度
        balanceOf[sender] -= amount;                         // 扣除发送者余额
        balanceOf[recipient] += amount;                      // 增加接收者余额
        emit Transfer(sender, recipient, amount);            // 触发转账事件
        return true;
    }

    // 内部铸币函数：创建新代币（仅内部调用）
    // @param to 接收新代币的地址
    // @param amount 铸造数量
    function _mint(address to, uint256 amount) internal {
        balanceOf[to] += amount;                            // 增加接收者余额
        totalSupply += amount;                              // 增加总供应量
        emit Transfer(address(0), to, amount);              // 触发转账事件（从零地址转出）
    }

    // 内部销毁函数：销毁代币（仅内部调用）
    // @param from1 销毁代币的地址
    // @param amount 销毁数量
    function _burn(address from1, uint256 amount) internal {
        balanceOf[from1] -= amount;                         // 减少持有者余额
        totalSupply -= amount;                              // 减少总供应量
        emit Transfer(from1, address(0), amount);           // 触发转账事件（转入零地址）
    }

    // 外部铸币函数：供外部调用的铸币接口
    // @param to1 接收新代币的地址
    // @param amount1 铸造数量
    function mint(address to1, uint256 amount1) external {
        _mint(to1, amount1);                                // 调用内部铸币函数
    }

    // 外部销毁函数：供外部调用的销毁接口
    // @param from1 销毁代币的地址
    // @param amount 销毁数量
    function burn(address from1, uint256 amount) external {
        _burn(from1, amount);                               // 调用内部销毁函数
    }
}


// contract interactBAYC {

//     // 利用 BAYC地址 创建 接口合约 变量（ETH主网）
//     IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

//     // 通过 接口调用 BAYC 的 balanceOf() 查询 持仓量
//     function balanceOfBAYC(address owner) external view returns (uint256 balance){
//         return BAYC.balanceOf(owner);
//     }

//     // 通过 接口调用 BAYC 的 safeTransferFrom() 安全转账
//     function safeTransferFromBAYC(address from, address to, uint256 tokenId) external{
//         BAYC.safeTransferFrom(from, to, tokenId);
//     }
// }




