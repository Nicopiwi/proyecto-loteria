const Loteria = artifacts.require("Loteria");
const LoteriaToken = artifacts.require("LoteriaToken");

module.exports = function (deployer) {
  deployer.deploy(LoteriaToken, 1000000000)
    .then(() => LoteriaToken.deployed())
    .then(_instance => deployer.deploy(Loteria, _instance.address));
};

