const NftMarketplace = artifacts.require("TurkishFootballCards");

module.exports = function(_deployer) {
  _deployer.deploy(NftMarketplace);
};
