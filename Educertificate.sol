// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/access/Ownable.sol";

contract EduCertificate is ERC721URIStorage, Ownable {
    uint256 private _tokenIds;
    uint256 public constant MAX_CERTIFICATES = 1000;

    mapping(address => uint256) public certificatesMinted;

    constructor() ERC721("EduCertificate", "EDCERT") {}

    function mintCertificate(address recipient, string memory tokenURI)
        public onlyOwner returns (uint256)
    {
        require(recipient != address(0), "Recipient invalid");
        require(bytes(tokenURI).length > 0, "tokenURI kosong");
        require(_tokenIds < MAX_CERTIFICATES, "Batas sertifikat tercapai");

        _tokenIds++;
        uint256 newItemId = _tokenIds;

        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        certificatesMinted[recipient] += 1;

        return newItemId;
    }

    function getLastTokenId() public view returns (uint256) {
        return _tokenIds;
    }
}
