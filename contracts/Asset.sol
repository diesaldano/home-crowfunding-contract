// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.22 <0.9.0;

contract Asset {

    string public tokenName = "PepeCoin";

    event ChangeNAme(
        address editor,
        string newName
    );

    function changeName(string memory newName) public {
        tokenName = newName;
        emit ChangeNAme(msg.sender, newName);
    }
}