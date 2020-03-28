const Loteria = artifacts.require("Loteria");
const LoteriaToken = artifacts.require("LoteriaToken");

module.exports = function(deployer) {
  deployer.deploy(Loteria);
  deployer.deploy(LoteriaToken);
};
