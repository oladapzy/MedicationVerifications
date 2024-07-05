// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MedicationVerification {

    // Struct to hold medication details
    struct Medication {
        uint256 id;
        string name;
        string manufacturer;
        string batchNumber;
        uint256 expiryDate;
        bool isVerified;
    }

    // State variable to store medications
    mapping(uint256 => Medication) public medications;

    // Event to emit when a medication is registered
    event MedicationRegistered(uint256 indexed id, string name, string manufacturer);

    // Event to emit when a medication is verified
    event MedicationVerified(uint256 indexed id, string name);

    // Address of the contract owner (e.g., regulatory authority)
    address public owner;

    // Modifier to check if the caller is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, “Caller is not the owner”);
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Function to register a new medication
    function registerMedication(uint256 _id, string memory _name, string memory _manufacturer, string memory _batchNumber, uint256 _expiryDate) public onlyOwner {
        // Ensure the medication is not already registered
        require(medications[_id].id == 0
