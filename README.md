# MessageBoard on Monad Testnet

## 项目简介

这是我部署到 Monad Testnet 的最小智能合约。合约名为 `MessageBoard`，功能是允许任意用户在链上写入一条留言，并记录最后一次留言的发送者地址和更新时间。

这个合约主要用于练习完整的链上开发流程：

- 编写 Solidity 合约源码
- 使用 Remix 编译合约
- 连接课程专用钱包
- 部署到 Monad Testnet
- 调用 read function 读取链上状态
- 调用 write function 修改链上状态
- 使用区块浏览器查询部署和交互记录

## 合约信息

- 合约名称：`MessageBoard`
- 部署网络：Monad Testnet
- 钱包工具：MetaMask
- 课程钱包地址：`0xCB1004C940C0267dc9FEB41B0c85A60E2D5f5A24`
- 合约地址：`待补充`
- 部署交易 hash：`待补充`
- 合约交互交易 hash：`待补充`
- 区块浏览器：`https://testnet.monadvision.com`

## 合约源码

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MessageBoard {
    string private message;
    address public lastSender;
    uint256 public lastUpdatedAt;

    event MessageUpdated(address indexed sender, string newMessage, uint256 timestamp);

    function setMessage(string memory newMessage) public {
        message = newMessage;
        lastSender = msg.sender;
        lastUpdatedAt = block.timestamp;

        emit MessageUpdated(msg.sender, newMessage, block.timestamp);
    }

    function getMessage() public view returns (string memory) {
        return message;
    }
}
```

## 如何部署

1. 打开 Remix。
2. 新建 `MessageBoard.sol` 文件，并粘贴合约源码。
3. 在 Solidity Compiler 面板选择 `0.8.20` 或兼容版本进行编译。
4. 在 Deploy & Run Transactions 面板中选择连接 MetaMask 的部署环境。
5. 确认 MetaMask 当前网络为 Monad Testnet。
6. 点击 Deploy，并在 MetaMask 中确认交易。
7. 部署成功后，记录合约地址和部署交易 hash。

## 如何交互

### Read function

调用 `getMessage()` 可以读取当前保存的留言。这个操作不会修改链上状态，不需要支付 gas。

也可以读取自动生成的 public 变量：

- `lastSender()`：查看最后一次写入留言的钱包地址。
- `lastUpdatedAt()`：查看最后一次写入留言的区块时间戳。

### Write function

调用 `setMessage(string newMessage)` 可以写入新的留言。这个操作会修改链上状态，需要通过 MetaMask 签名并支付 Monad Testnet 的测试 gas。

本次测试写入内容：

```text
Hello Monad this is my first smart contract
```

## 人工检查记录

1. 合约可以在 Remix 中成功编译。
2. `setMessage` 函数符合预期，可以写入留言并更新发送者和时间。
3. `getMessage` 是 read function，只读取数据，不修改链上状态。
4. 合约没有 owner 权限，任何地址都可以写入留言；这是本次最小留言板的设计选择。
5. 合约没有引入外部库或复杂继承，逻辑比较简单，适合作为第一个测试网合约。
6. 注意到过长字符串会增加写入成本，因此实际交互时使用了较短留言。

