pragma solidity 0.8.4; //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable{
  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address seller, uint256 amountOfTokens, uint256 amountOfETH);

  YourToken public yourToken;
  uint public constant tokensPerEth = 100;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  // ToDo: create a payable buyTokens() function:
  function buyTokens() payable public {
    uint numOfTokens = tokensPerEth * msg.value;
    yourToken.transfer(msg.sender, numOfTokens);
    emit BuyTokens(msg.sender, msg.value, numOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
    function withdraw() payable public {
      require(msg.sender == owner());
      payable(owner()).transfer((address(this)).balance);
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 amount)public {
    yourToken.transferFrom(msg.sender, address(this), amount);
    payable(msg.sender).transfer(amount/tokensPerEth);
    emit SellTokens(msg.sender, amount, amount/tokensPerEth);
  }
}
