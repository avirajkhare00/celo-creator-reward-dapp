// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract CreatorReward {
    
    struct Creator {
        string name;
        string description;
        string ipfsHash;
        address payable wallet;
    }

    event CreatorLog(string name, string description, string ipfsHash, address indexed wallet);

    event RewardLog(address indexed donor, address indexed creator, uint256 indexed amount);

    Creator[] private creators;

    function createAccount(string memory _name, string memory _description, string memory _ipfsHash) public {
        creators.push(Creator(_name, _description, _ipfsHash, payable(msg.sender)));
        emit CreatorLog(_name, _description, _ipfsHash, msg.sender);
    }

    function creatorsNumber() public view returns (uint) {
        return creators.length;
    }

    function creatorById(uint _id) public view returns (string memory, string memory, string memory description) {
        return(creators[_id].name, creators[_id].ipfsHash, creators[_id].description);
    }

    function rewardCreatorById(uint _id) public payable {
        require(msg.value > 0, "CELO amount must be greater then 0");
        require(msg.sender != creators[_id].wallet, "Creator cannot send CELO to itself");
        (bool sent, bytes memory data) = creators[_id].wallet.call{value: msg.value}("");
        require(sent, "Failed to send Ether");

        emit RewardLog(msg.sender, creators[_id].wallet, msg.value);
    }
}
