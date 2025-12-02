// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title SecureVoteSimulation
 * @dev Educational contract demonstrating how to track votes,
 * prevent duplicates, and maintain transparent audit logs.
 * All “votes” are simulated for learning only.
 */
contract SecureVoteSimulation {

    struct VoteRecord {
        address voter;
        uint256 candidateId;
        uint256 timestamp;
    }

    mapping(address => bool) public hasVoted;
    mapping(uint256 => uint256) public voteCount;
    VoteRecord[] public auditLog;

    event VoteSubmitted(address indexed voter, uint256 candidateId, uint256 timestamp);

    /**
     * @dev Casts a vote (simulation only). Prevents duplicate votes.
     */
    function castVote(uint256 candidateId) external {
        require(!hasVoted[msg.sender], "You have already voted.");

        hasVoted[msg.sender] = true;
        voteCount[candidateId] += 1;

        VoteRecord memory record = VoteRecord({
            voter: msg.sender,
            candidateId: candidateId,
            timestamp: block.timestamp
        });

        auditLog.push(record);

        emit VoteSubmitted(msg.sender, candidateId, block.timestamp);
    }

    /**
     * @dev Returns the total number of votes logged.
     */
    function totalVotes() external view returns (uint256) {
        return auditLog.length;
    }

    /**
     * @dev Returns audit log entry by index.
     */
    function getAuditEntry(uint256 index)
        external
        view
        returns (address voter, uint256 candidateId, uint256 timestamp)
    {
        require(index < auditLog.length, "Invalid index");
        VoteRecord memory record = auditLog[index];
        return (record.voter, record.candidateId, record.timestamp);
    }
}

