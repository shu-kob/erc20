// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenVendingContract {

    ERC20 public ERC20Token;
    address public TokenOwner;
    uint256 private weiAmount;
    uint256 private weiBalance;

    function TokenVending(address _ERC20Token, address payable _TokenOwner) public {
        ERC20Token = ERC20(_ERC20Token);
        TokenOwner = _TokenOwner;
    }

    function withdrawal(uint withdraw_amount) private {

        ERC20Token.transferFrom(TokenOwner, msg.sender, withdraw_amount);
    }

    receive() external payable {
	    weiAmount = msg.value;
        withdrawal(weiAmount * 1000);
    }

    function withdrawEth(address payable _to, uint _value) public {
        require(msg.sender == TokenOwner, "Token owner only can withdrawal eth!");
        weiBalance = address(this).balance;
        require(_value < weiBalance);
	    _to.transfer(_value);
	}
}
