// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * @title CrowdFunding
 * @dev Smart contract for creating and managing crowdfunding campaigns.
 */
contract CrowdFunding {
    // Struct to represent a crowdfunding campaign
    struct Campaign {
        address owner;
        string title;
        string description;
        string image;
        uint target;
        uint deadline;
        uint amountCollected;
        address[] donators;
        uint[] donations;
    }

    // Mapping to store all campaigns by their unique IDs
    mapping(uint => Campaign) public campaigns;

    // Total number of created campaigns
    uint public numberOfCampaigns = 0;

    /**
     * @dev Creates a new crowdfunding campaign.
     * @param _owner The address of the campaign owner.
     * @param _title The title of the campaign.
     * @param _description The description of the campaign.
     * @param _image The image URL associated with the campaign.
     * @param _target The target fundraising amount.
     * @param _deadline The deadline for reaching the target amount.
     * @return The unique ID of the newly created campaign.
     */
    function createCampaign(
        address _owner, string memory _title,
        string memory _description, string memory _image,
        uint _target, uint _deadline
    ) public returns (uint) {
        // Creating a new campaign with the specified details
        Campaign storage newCampaign = campaigns[numberOfCampaigns];

        // Ensure the deadline is in the future
        require(newCampaign.deadline > block.timestamp, "Deadline should be a date in the future!");

        // Initialize campaign details
        newCampaign.owner = _owner;
        newCampaign.title = _title;
        newCampaign.description = _description;
        newCampaign.image = _image;
        newCampaign.target = _target;
        newCampaign.deadline = _deadline;
        newCampaign.amountCollected = 0;

        // Increment the total number of campaigns
        numberOfCampaigns++;

        // Return the index of the most newly created campaign
        return numberOfCampaigns - 1;
    }

    /**
     * @dev Allows users to donate funds to a specific campaign.
     * @param _campaignId The unique ID of the campaign.
     */
    function donateToCampaign(uint _campaignId) public payable {
        uint amount = msg.value;

        // Retrieve the campaign to which the donation is made
        Campaign storage tempCampaign = campaigns[_campaignId];

        // Record the donor and donation amount
        tempCampaign.donators.push(msg.sender);
        tempCampaign.donations.push(amount);

        // Transfer the donated amount to the campaign owner
        (bool sent,) = payable(tempCampaign.owner).call{value: amount}("");
        require(sent, "Donation failed!");

        // Update the total amount collected by the campaign
        tempCampaign.amountCollected += amount;
    }

    /**
     * @dev Returns the list of donators and their corresponding donations for a specific campaign.
     * @param _campaignId The unique ID of the campaign.
     * @return Arrays of addresses (donators) and uints (donations).
     */
    function getDonators(uint _campaignId) public view returns (address[] memory, uint[] memory) {
        return (campaigns[_campaignId].donators, campaigns[_campaignId].donations);
    }

    /**
     * @dev Returns an array of all campaigns with their details.
     * @return An array of Campaign structs representing all campaigns.
     */
    function getCampaigns() public view returns (Campaign[] memory) {
        // Creating an empty array with as many empty elements as there are actual campaigns
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns);

        // Populating the array with campaign details
        for(uint i = 0; i < numberOfCampaigns; i++) {
            Campaign storage camp = campaigns[i];
            allCampaigns[i] = camp;
        }

        return allCampaigns;
    }
}
