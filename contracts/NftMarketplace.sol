pragma solidity ^0.8.17;


/// @notice Smart Contract for the nft marketplace of the turkish football assocition
/// @dev Must receive payments for nft's (sell nfts), verify their creators id, create nfts

contract TurkishFootballCards 
{
    address payable TF_owner;
    address nftMinter;
    uint nftCount = 0;
    mapping(uint => card) public nfts;
    
    struct card
    {
        uint id;
        address owner;
        address nftID; //not sure if address, will check later
        bool soldBefore;
        uint price;
    }

    event nft_sold
    {
        uint id;
        address owner;
        address nftID; 
        bool soldBefore;
        uint price;
    }


    constructor()
    {
        TF_owner = payable(0x08B9F93cf5bde9dDEf4E4BF54df2aD5A9902f744);
        //nftMinter = 'address of the turkish football federation'; 

    }

    
    function createCard() public
    {


    }
    
    function purchaseCard(uint _id) public payable
    {
        //check correct id
        require(_id >= 0 && _id <= nftCount);
        //check if valid creator/current owner
        card memory _nft_card = nfts[_id]; 
        require(_nft_card.owner == TF_owner);
        //check if it's been sold
        require(!_nft_card.soldBefore);
        //check price/funds
        require(msg.value >= _nft_card.price);
        //change owner
        _nft_card.owner = msg.sender;
        //mark as sold
        _nft_card.soldBefore = true;
        //update nft list
        nfts[_id] = _nft_card;
        //transfer funds
        TF_owner.transfer(msg.value);
        //trigger event
        emit(_id, _nft_card.owner,_nft_card.nftID, true, _nft_card.price);

    }

    
}
