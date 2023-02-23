// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IERC721A, ERC721A} from "erc721a/contracts/ERC721A.sol";
import {BlockedSea} from "../BlockedSea.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC2981, ERC2981} from "@openzeppelin/contracts/token/common/ERC2981.sol";

/**
 * @title ExampleERC721A
 * @notice This contract will deploy with OpenSea being blocked. The setBlockOpenSea
 * can be used to turn the value on/off at the owners leisure.
 */
contract ExampleERC721A is ERC721A, BlockedSea, Ownable, ERC2981 {
    bool public isOpenSeaBlocked;

    constructor() ERC721A("ExampleERC721A", "EXAMPLE") {
        isOpenSeaBlocked = true;
    }

    function approve(address to, uint256 tokenId)
        public
        payable
        override(ERC721A)
        blockOpenSea(to)
    {
        super.approve(to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved)
        public
        virtual
        override(ERC721A)
        blockOpenSea(operator)
    {
        super.setApprovalForAll(operator, approved);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721A, ERC2981)
        returns (bool)
    {
        // Supports the following `interfaceId`s:
        // - IERC165: 0x01ffc9a7
        // - IERC721: 0x80ac58cd
        // - IERC721Metadata: 0x5b5e139f
        // - IERC2981: 0x2a55205a
        return
            ERC721A.supportsInterface(interfaceId) ||
            ERC2981.supportsInterface(interfaceId);
    }

    function setBlockOpenSea(bool value) public onlyOwner {
        isOpenSeaBlocked = value;
    }

    function _blockOpenSeaEnabled() internal view override returns (bool) {
        return isOpenSeaBlocked;
    }
}
