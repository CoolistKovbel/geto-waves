

const main = async () => {

  // 1. Grab Contract
  const waveContractPortal = await hre.ethers.getContractFactory("WavePortal");

  // 2. Deploy Contract
  const waveContract = await waveContractPortal.deploy()

  await waveContract.deployed()
  console.log('We have an contract address', waveContract.address)

  let waveTxn = await waveContract.wave("Hello world")
  await waveTxn.wait()

  // Gets local eth address accounts
  const [ _, randomPerson ] = await hre.ethers.getSigners()
  waveTxn = await waveContract.connect(randomPerson).wave("Hello from the other side")
  // Waiting till txn gets mined
  await waveTxn.wait()

  let allWaves = await waveContract.getAllWaves()
  console.log(allWaves)

}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();