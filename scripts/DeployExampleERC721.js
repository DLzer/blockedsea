const {
    ethers
} = require("hardhat");

const ContractName = "ExampleERC721";

async function main() {
    const [deployer] = await ethers.getSigners();

    console.log(`Deploy contract: ${ContractName}`);
    console.log(`Deploying contracts with account: ${deployer}`);

    const Token = await ethers.getContractFactory(ContractName);
    const token = await Token.deploy();

    console.log(`Token Address: ${token.address}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });