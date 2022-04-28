// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract HomeCrowFundingFinal {
    enum fundraisingState {
        Open,
        Closed,
        Funded
    }

    struct Contribution {
        address contributor;
        uint256 value;
    }

    struct Project {
        string id;
        string name;
        string description;
        address payable author;
        fundraisingState state;
        uint256 funds;
        uint256 fundraisingGoal;
    }

    Project[] public projects;
    mapping(string => Contribution[]) public contributions;

    event ProjectCreated(
        string projectId,
        string projectName,
        string projectDescription,
        uint256 projectFundraisingGoal
    );

    event ProjectFunded(string projectId, uint256 value);

    event ProjectStateChanged(string id, fundraisingState state);

    modifier isAuthor(uint256 projectIndex) {
        require(    
            projects[projectIndex].author == msg.sender, 
            "You need to be the project author"
        );
        _;
    }

    modifier isNotAuthor(uint256 projectIndex) {
        require(
           projects[projectIndex].author != msg.sender,
            "As author you can not fund your own project"
        );
        _;
    }

    modifier isNotFunding(uint256 projectIndex) {
        require(
            projects[projectIndex].state != fundraisingState.Funded,
            "Project is already funded"
        );
        _;
    }

    //create project
    function createProject(
        string calldata id,
        string calldata name,
        string calldata description,
        uint256 fundraisingGoal
    ) public {
        require(
            fundraisingGoal > 0,
            "Fundraising goal must be greater than 0"
        );
        Project memory project = Project(
            id,
            name,
            description,
            payable(msg.sender),
            fundraisingState.Open,
            0,
            fundraisingGoal
        );
        projects.push(project);
        emit ProjectCreated(id, name, description, fundraisingGoal);
    }

        function fundProject(uint256 projectIndex)
        public
        payable
        isNotAuthor(projectIndex)
    {
        Project memory project = projects[projectIndex];
        require(
            project.state != fundraisingState.Closed,
            "The project can not receive funds"
        );
        require(msg.value > 0, "Fund value must be greater than 0");
        project.author.transfer(msg.value);
        project.funds += msg.value;
        projects[projectIndex] = project;

        contributions[project.id].push(Contribution(msg.sender, msg.value));

        emit ProjectFunded(project.id, msg.value);
    }

    function changeProjectState(fundraisingState newState, uint256 projectIndex)
        public
        isAuthor(projectIndex)
    {
        Project memory project = projects[projectIndex];
        require(project.state != newState, "New state must be different");
        project.state = newState;
        projects[projectIndex] = project;
        emit ProjectStateChanged(project.id, newState);
    }
}

