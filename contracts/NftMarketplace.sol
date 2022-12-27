pragma solidity ^0.8.17;


/// @notice Smart Contract for the nft marketplace of the turkish football assocition
/// @dev Must receive payments for nft's (sell nfts), verify their creators id, create nfts

contract TurkishFootballCards 
{
    string owner;
    address nftMinter;

    
    
    struct card
    {
        uint id;
        address owner;
        address nftID; //not sure if address, will check later
        bool soldBefore;
    }


    constructor()
    {
        owner = "All rights belong to the turkish football federation";
        //nftMinter = 'address of the turkish football federation'; 

    }

    
    function createCard() public
    {

    }
    
    function purchaseCard(uint _id) public payable
    {
        //check correct id
        //check if valid creator/current owner
        //check if it's been sold
        //check price/funds
        
        //change owner
        //mark as sold
        //transfer funds
        //trigger event
    }

    
}
