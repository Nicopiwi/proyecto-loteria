pragma solidity >=0.4.22 <0.7.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";

contract LoteriaToken is ERC20, ERC20Detailed, ERC20Mintable{
    constructor (uint256 _initialSupply) public ERC20Detailed("LoteriaToken", "LTN", 0) {
        _mint(msg.sender, _initialSupply);
    }
}