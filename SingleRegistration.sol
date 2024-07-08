// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IndividualRegistration {
    struct Individual {
        string name;
        string email;
        string bio;
    }

    mapping(address => Individual) public individuals;

    event IndividualRegistered(address indexed individualAddress, string name);

    function registerIndividual(string memory _name, string memory _email, string memory _bio) public {
        individuals[msg.sender] = Individual({
            name: _name,
            email: _email,
            bio: _bio
        });
        emit IndividualRegistered(msg.sender, _name);
    }

    function getIndividual(address _individualAddress) public view returns (string memory, string memory, string memory) {
        Individual memory individual = individuals[_individualAddress];
        return (individual.name, individual.email, individual.bio);
    }
}
