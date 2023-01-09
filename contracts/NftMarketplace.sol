pragma solidity >=0.8.17;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/// @notice Smart Contract for the nft marketplace of the turkish football assocition
/// @dev Must receive payments for nft's (sell nfts), verify their creators id, create nfts

contract TurkishFootballCards is ReentrancyGard
{
    address public payable TF_owner;
    uint256 public mintPrice = 0.002 ether
    uint256 nftCount = 0;
    mapping(uint256 => card) public nfts;

    
    struct card
    {
        uint256 id;
        address owner;
        bool soldBefore; 
        uint256 price;
    }

    event nft_sold
    (
        uint256 id,
        address owner,
        address nftID, 
        bool soldBefore,
        uint265 price
    );


    constructor TFF_Marketplace() is ReentrancyGuard
    {
        TF_owner = payable(0x08B9F93cf5bde9dDEf4E4BF54df2aD5A9902f744);
        //nftMinter = 'address of the turkish football federation'; 

    }

    
    function mint(uint256 _nft_price) external onlyOwner payable
    {
        //this funtion is responsible for the minting of new coins
        //only the Turkish Football federation is supposed to be able to mint
        require(msg.sender.address == TF_owner)
        //the message value should be equal to the minting cost
        require(msg.value == mintPrice);
        
        //creating the new nft in the marketplace
        card _new_nft(nftCount, TF_owner, false, _nft_price);
        nfts[nftCount] = _new_nft;
        nftCount++;

        //actually creating the nft in the
        uint256 TokenID = nftCount;
        _safeMint(TF_owner, TokenID); //emits a {Transfer} event



    }

    //this version of the funtion in gonna diiiieee
    //this is a normal marketplace, now, let us change it to a nft marketplace

    function purchaseCard(uint256 _id) public external payable
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
        //_nft_card.owner = msg.sender; we should use the proper thing to t«do this, aka ERC721
        //mark as sold
        _nft_card.soldBefore = true;
        //update nft list
        nfts[_id] = _nft_card;
        //transfer funds
        TF_owner.transfer(msg.value);
        //trigger event
        emit nft_sold(_id, _nft_card.owner,_nft_card.nftID, true, _nft_card.price);

    }
    //new version of the purchaseCard, using the standard ERC721
    function purchaseCard(uint256 _tokenID) public external payable
    {
        //check correct id
        require(_tokenID >= 0 && _id <= nftCount);
        //load nft information
        address owner = ownerOf(_tokenID);
        cards cardToSell = nfts[_tokenID];
        require(owner == TF_owner, "Invalid owner, nft does not belong to the Turkish football association");
        //check for funds 
        require(msg.value >= cardToSell.price, "Unsufficient funds");
        //tranfer the funds (fund value can change after calling external functions, aka the safeTransferFrom)
        TF_owner.transfer(msg.value); // maybe not use this because of the Istambull fork and change in gas prices (not safe anymore)
        //transfer the nft
        safeTransferFrom(owner, msg.sender(),_tokenID);
        //update the cards info
        cardToSell.owner = msg.sender;
        cardToSell.soldBefore = true;
        nfts[_tokenID] = cardToSell;
        //event to log this, maybe not do it, cause the safeTransferFrom function already emits a {Transfer} event
        emit nft_sold(_tokenID, _nft_card.owner,_nft_card.nftID, true, _nft_card.price);

    }

    
}
