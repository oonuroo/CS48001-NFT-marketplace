const NftMarketplace = artifacts.require("TurkishFootballCards");

module.exports = function(deployer) {
  deployer.deploy(NftMarketplace);
};
