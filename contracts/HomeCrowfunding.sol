// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract HomeGrowFunding {
    string name;
    string description;
    uint count;
    bool isActive;
    uint currenctBalance;
    address payable ownerWallet;
    address owner;

    constructor(
        string memory _name,
        string memory _description,
        uint _count
    ){
        name = _name;
        description = _description;
        count = _count;
        currenctBalance = 0;
        isActive = true;
        ownerWallet = payable(msg.sender);
        owner = msg.sender;
    }

    function sendFund() public payable {
        require(isActive == true,
        "Current project is not available!");
        ownerWallet.transfer(msg.value);
        currenctBalance += msg.value;
    }

    function changeFundStatus() public {
        require(owner == msg.sender,
        "You must be the project owner");
        isActive = !isActive;
    }

    function getCount() public view 
        returns(uint){
            return count;
    }

    function getStatus() public view 
        returns(bool){
            return isActive;
    }

    function getFunds() public view
        returns(uint){
            return currenctBalance;
        }
}
