const {
    EtherscanProvider
} = require("@ethersproject/providers");
const {
    loadFixture
} = require("@nomicfoundation/hardhat-network-helpers");
const {
    expect
} = require("chai");
const {
    ethers
} = require("hardhat");

const ContractName = "ExampleERC721"

describe(ContractName, function () {
    async function deployTokenFixture() {
        const Token = await ethers.getContractFactory(ContractName);
        const [owner, addr1] = await ethers.getSigners();

        const ExampleToken = await Token.deploy();
        await ExampleToken.deployed();

        return {
            Token,
            ExampleToken,
            owner,
            addr1
        };
    }

    describe("Deployment", function () {
        it("Deployment should reveal the owner matches deployed owner", async function () {
            const {
                ExampleToken,
                owner
            } = await loadFixture(
                deployTokenFixture
            );

            expect(await ExampleToken.owner()).to.equal(owner.address);
        });
    });
});