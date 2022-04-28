const HomeCrowFundingFinal = artifacts.require("./HomeCrowFundingFinal.sol");

module.exports = function(deployer){
    deployer.deploy(HomeCrowFundingFinal);
}