const Suma = artifacts.require("./Suma.sol");

module.exports = function(deployer){
    deployer.deploy(Suma);
}