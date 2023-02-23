// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {BlockedSea} from "../BlockedSea.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC2981, ERC2981} from "@openzeppelin/contracts/token/common/ERC2981.sol";

/**
 * @title ExampleERC721
 * @notice This contract will deploy with OpenSea being blocked. The setBlockOpenSea
 * can be used to turn the value on/off at the owners leisure.
 */
contract ExampleERC721 is ERC721, BlockedSea, Ownable, ERC2981 {
    bool public isOpenSeaBlocked;

    constructor() ERC721("Example", "EXAMPLE") {
        isOpenSeaBlocked = true;
    }

    function approve(address to, uint256 tokenId)
        public
        virtual
        override
        blockOpenSea(to)
    {
        super.approve(to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved)
        public
        virtual
        override
        blockOpenSea(operator)
    {
        super.setApprovalForAll(operator, approved);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(ERC721, ERC2981)
        returns (bool)
    {
        // Supports the following `interfaceId`s:
        // - IERC165: 0x01ffc9a7
        // - IERC721: 0x80ac58cd
        // - IERC721Metadata: 0x5b5e139f
        // - IERC2981: 0x2a55205a
        return
            ERC721.supportsInterface(interfaceId) ||
            ERC2981.supportsInterface(interfaceId);
    }

    function setBlockOpenSea(bool value) public onlyOwner {
        isOpenSeaBlocked = value;
    }

    function _blockOpenSeaEnabled() internal view override returns (bool) {
        return isOpenSeaBlocked;
    }
}
