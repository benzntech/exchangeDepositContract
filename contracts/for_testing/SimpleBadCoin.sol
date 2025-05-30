// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface BadERC20Interface {
    /**
     * @dev BAD INTERFACE, DOESN'T RETURN bool
     */
    function transfer(address recipient, uint256 amount) external;
}

contract SimpleBadCoin is BadERC20Interface {
    // This is just for tests, does not fully implement ERC20, only methods we need.
    mapping(address => uint256) private balances;
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    function giveBalance(address account, uint256 amount) external {
        balances[account] = amount;
    }

    // Below are the two functions we need to provide for tests
    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) external override {
        if (
            balances[msg.sender] >= amount &&
            amount > 0 &&
            balances[recipient] + amount > balances[recipient] &&
            amount != 42
        ) {
            balances[msg.sender] -= amount;
            balances[recipient] += amount;
            emit Transfer(msg.sender, recipient, amount);
        }
    }
}
