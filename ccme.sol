// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

// CCME is a non-fungible token (NFT) contract that represents unique collectibles.
// It allows anyone to mint up to 950 unique NFTs out of a total supply of 1000.
contract CCME is ERC721 {
    // The name of the NFT
    string public name = "CCME";

    // The symbol of the NFT
    string public symbol = "CCME";

    // The total supply of unique NFTs
    uint256 public totalSupply = 1000;

    // The owner of the contract
    address public owner;

    // Mapping of NFT IDs to the owner of each NFT
    mapping(uint256 => address) public tokenOwner;

    // Counter to track the number of minted NFTs
    uint256 public mintedCount = 0;

    // Event that is emitted whenever an NFT is minted
    event Mint(uint256 indexed id, address owner);

    constructor() public {
        // Set the owner of the contract to the address that deployed it
        owner = msg.sender;
    }

    // Function to mint a new NFT
    function mint(uint256 id) public {
        // Ensure that the NFT ID is within the total supply
        require(id <= totalSupply, "NFT ID is out of range");

        // Ensure that the NFT ID is not already in use
        require(tokenOwner[id] == address(0), "NFT ID is already in use");

        // Ensure that the total number of minted NFTs does not exceed 950
        require(mintedCount < 950, "The maximum number of minted NFTs has been reached");

        // Assign the NFT to the caller of this function
        tokenOwner[id] = msg.sender;

        // Increment the minted count
        mintedCount++;

        // Emit a Mint event to record the minting of the NFT
        emit Mint(id, msg.sender);
    }
}
