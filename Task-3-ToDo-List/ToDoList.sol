// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ToDoList {
    struct Task {
        string description;
        bool completed;
        uint256 createdAt;
    }

    mapping(address => Task[]) private userTasks;

    event TaskCreated(address indexed user, uint256 taskId);
    event TaskCompleted(address indexed user, uint256 taskId);

    function addTask(string memory _description) public {
        require(bytes(_description).length > 0, "Task cannot be empty");
        userTasks[msg.sender].push(
            Task(_description, false, block.timestamp)
        );
        emit TaskCreated(msg.sender, userTasks[msg.sender].length - 1);
    }

    function updateTaskStatus(uint256 _taskId, bool _completed) public {
        require(_taskId < userTasks[msg.sender].length, "Invalid task ID");
        userTasks[msg.sender][_taskId].completed = _completed;
        if (_completed) {
            emit TaskCompleted(msg.sender, _taskId);
        }
    }

    function getTasks(address _user) public view returns (Task[] memory) {
        return userTasks[_user];
    }

    function getTaskCount() public view returns (uint256) {
        return userTasks[msg.sender].length;
    }

    function deleteCompletedTask(uint256 _taskId) public {
        require(_taskId < userTasks[msg.sender].length, "Invalid task ID");
        require(userTasks[msg.sender][_taskId].completed, "Task not completed");

        uint256 lastIndex = userTasks[msg.sender].length - 1;
        userTasks[msg.sender][_taskId] = userTasks[msg.sender][lastIndex];
        userTasks[msg.sender].pop();
    }
}