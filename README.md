# CrowdFunding Smart Contract

This Solidity smart contract, named "CrowdFunding," enables the creation and management of crowdfunding campaigns. Users can create campaigns, donate funds, and retrieve campaign details.

## Contract Details
- **Contract Name:** CrowdFunding
- **Solidity Version:** 0.8.9
- **License:** UNLICENSED

## Contract Overview
The CrowdFunding contract provides the following functionalities:
- Users can create crowdfunding campaigns with details such as title, description, image, target amount, and deadline.
- Users can donate funds to specific campaigns, and the contract tracks donors and donation amounts.
- Campaign owners can withdraw collected funds after a successful campaign.

## State Variables
- **Campaign:** Struct to represent a crowdfunding campaign with details like owner, title, description, image, target amount, deadline, amount collected, donators, and donations.
- **campaigns:** Mapping to store all campaigns by their unique IDs.
- **numberOfCampaigns:** Total number of created campaigns.

## Functions
### `createCampaign()`
Allows users to create a new crowdfunding campaign with specified details.

### `donateToCampaign(uint _campaignId)`
Allows users to donate funds to a specific campaign, updating donor and donation records.

### `getDonators(uint _campaignId)`
Returns the list of donators and their corresponding donations for a specific campaign.

### `getCampaigns()`
Returns an array of all campaigns with their details.