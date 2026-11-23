// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CertificateVerification {

    address public owner;

    struct Certificate {
        string studentName;
        string certificateId;
        string courseName;
        uint issueDate;
    }

    mapping(string => Certificate) private certificates;
    mapping(string => bool) private certificateExists;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can add");
        _;
    }

    event CertificateAdded(string certificateId);

    function addCertificate(
        string memory _name,
        string memory _id,
        string memory _course,
        uint _date
    ) public onlyOwner {

        require(bytes(_id).length > 0, "Invalid ID");
        require(!certificateExists[_id], "Certificate already exists");

        certificates[_id] = Certificate(
            _name,
            _id,
            _course,
            _date
        );

        certificateExists[_id] = true;

        emit CertificateAdded(_id);
    }

    function verifyCertificate(string memory _id)
        public
        view
        returns (bool, string memory, string memory, uint)
    {
        if (!certificateExists[_id]) {
            return (false, "", "", 0);
        }

        Certificate memory cert = certificates[_id];

        return (
            true,
            cert.studentName,
            cert.courseName,
            cert.issueDate
        );
    }
}