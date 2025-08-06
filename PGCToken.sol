// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PGCToken is ERC20, ERC20Burnable, Pausable, Ownable {
    constructor() ERC20("Piglet Growth Coin", "PGC") {
        _mint(msg.sender, 100_000_000 * 10 ** decimals());
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function airdrop(address[] calldata recipients, uint256 amount) public onlyOwner {
        for (uint i = 0; i < recipients.length; i++) {
            _mint(recipients[i], amount);
        }
    }
}
