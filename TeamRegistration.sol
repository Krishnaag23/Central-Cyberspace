// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TeamRegistration {
    struct Team {
        string name;
        string description;
        address leader;
        address[] members;
    }

    mapping(uint256 => Team) public teams;
    uint256 public teamCount;

    event TeamRegistered(uint256 teamId, string name, address leader);
    event MemberAdded(uint256 teamId, address member);

    function registerTeam(string memory _name, string memory _description) public {
        teamCount++;
        teams[teamCount] = Team({
            name: _name,
            description: _description,
            leader: msg.sender,
            members: new address[](0)    
        });
        emit TeamRegistered(teamCount, _name, msg.sender);
    }

    function addMember(uint256 _teamId, address _member) public {
        require(_teamId > 0 && _teamId <= teamCount, "Invalid team ID");
        require(teams[_teamId].leader == msg.sender, "Only team leader can add members");

        teams[_teamId].members.push(_member);
        emit MemberAdded(_teamId, _member);
    }

    function getTeam(uint256 _teamId) public view returns (string memory, string memory, address, address[] memory) {
        require(_teamId > 0 && _teamId <= teamCount, "Invalid team ID");

        Team memory team = teams[_teamId];
        return (team.name, team.description, team.leader, team.members);
    }
}
