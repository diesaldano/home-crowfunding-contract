// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract HomeGrowFunding {

    string public id;
    string public name;
    string public description;
    address payable public author;
    string public state = "Opened";
    uint public funds;
    uint public fundraisingGoal;

    event ProjectFunded(string projectId , uint256 value);

    event ProjectStateChanged(string id , string state);

    constructor(
            string memory _id, 
            string memory _name, 
            string memory _description, 
            uint256 _fundraisingGoal
        )  {
            id = _id;
            name = _name;
            description = _description;
            fundraisingGoal = _fundraisingGoal;
            author = payable(msg.sender);
    }

    modifier isAuthor(){
        require(msg.sender == author, "You are not the author of this project");
        _;
    }

    modifier isNotAuthor(){
        require(msg.sender != author, "You cannot fund your own project");
        _;
    }

    function fundProject() public payable isNotAuthor {
        author.transfer(msg.value);
        funds += msg.value;
        emit ProjectFunded(id, msg.value);
    }

    function changeProjectState(string calldata newState) public isAuthor{
        state = newState;
        emit ProjectStateChanged(id, state);
    }
}