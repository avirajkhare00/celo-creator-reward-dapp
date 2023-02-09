const hre = require("hardhat");

async function main() {
  const CreatorReward = await hre.ethers.getContractFactory("CreatorReward");
  const creatorReward = await CreatorReward.deploy();

  await creatorReward.deployed();

  console.log(
    `Creator Reward smart contract address: ${creatorReward.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
