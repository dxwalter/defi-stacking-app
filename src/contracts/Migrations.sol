pragma solidity ^0.5.0;

contract Migrations {
    address public owner;
    uint public last_completed_migration;

    constructor () public {
        owner = msg.sender; // this is the person making a call to the contract
    }

    modifier restricted () {
        if (msg.sender == owner) _; // this underscore means continue with this function
    }

    function setCompleted(uint completed) public restricted {
        last_completed_migration = completed;
    }

    function upgrade (address new_address) public restricted {
        Migrations upgraded = Migrations(new_address);
        upgraded.setCompleted(last_completed_migration);
    }
} 