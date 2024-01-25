// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract MintNFT is ERC1155, Ownable {
    string public name;
    string public symbol;
    uint maxTokenId; 

    mapping(uint => string) private tokenURIs;

    constructor(string memory _name, string memory _symbol, uint _maxTokenId) ERC1155("")  Ownable(msg.sender) {
        name = _name;
        symbol = _symbol;
        maxTokenId = _maxTokenId;
    } 

    function mintToken(uint _tokenId, uint _amount, string memory _tokenURI) public {
        require(_tokenId <= maxTokenId && _tokenId != 0, "Not exist token id.");

        tokenURIs[_tokenId] = _tokenURI;
        _mint(msg.sender, _tokenId, _amount, "");
    }

    function uri(uint256 _tokenId) public view override returns (string memory) {
        return tokenURIs[_tokenId];
    }

    function transferToken(address _from, address _to, uint256 _tokenId, uint256 _amount) public {
        require(msg.sender == _from, "Only the owner can transfer.");
        safeTransferFrom(_from, _to, _tokenId, _amount, "");
    }
}
