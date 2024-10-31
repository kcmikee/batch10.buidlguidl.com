// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

/**
 * @title Interface for the BatchRegistry contract
 * @notice This interface defines the checkIn function
 *         that is called by the BatchCheckIn contract
 */
interface IBatchRegistry {
	/**
	 * @notice Call the checkIn function on the BatchRegistry contract
	 */
	function checkIn() external;
}

/**
 * @title CheckIn contract
 * @notice This contract is used to call the checkIn function on the BatchRegistry contract
 *         It is intended to be used as a proxy contract to simplify the interaction with the BatchRegistry contract
 */
contract CheckIn {
	/**
	 * @notice The address of the BatchRegistry contract
	 */
	IBatchRegistry public batchRegistry;

	/**
	 * @notice The address of the contract owner
	 * @dev This is an optional field and is only used if the owner pattern is desired
	 */
	address public owner;

	/**
	 * @notice Modifier that checks if the caller is the contract owner
	 * @dev This modifier is used to restrict access to certain functions
	 */
	modifier onlyOwner() {
		require(msg.sender == owner, "Not the contract owner");
		_;
	}

	/**
	 * @notice Constructor function that sets the address of the BatchRegistry contract
	 * @param _batchRegistry The address of the BatchRegistry contract
	 */
	constructor(address _batchRegistry) {
		batchRegistry = IBatchRegistry(_batchRegistry);
		owner = msg.sender; // Set the deployer as the owner
	}

	/**
	 * @notice Function that calls the checkIn function on the BatchRegistry contract
	 * @dev This function is only callable by the contract owner
	 */
	function callCheckIn() public onlyOwner {
		batchRegistry.checkIn();
	}
}
