const NftMarketplace = artifacts.require("TurkishFootballCards");

contract('TurkishFootballCards', (accounts) => {
        let nftCount;

        before(async() => {

            marketplaceInstance = await NftMarketplace.deployed();
            nftCount = await NftMarketplace.nftCount;
        })
        
        it("should be deployed", async() => {
            
             const address = await marketplaceInstance.address;
             assert.notEqual(address, 0x0);
             assert.notEqual(address, '');
             assert.notEqual(address, null);
             assert.notEqual(address, undefined); 
            
        }) 
        it("Has the right name", async() =>{
            const name = await marketplaceInstance.name;
            assert.notEqual(name, "");
            assert.notEqual(name, "hello");
            assert.notEqual(name, null);
        })

     /*   it("should set the price of minting", async() => {

            const price =  await marketplaceInstance.mintPrice();
            assert.equal(price, web3.utils.toWei('0.002', 'Ether'), "The mint price was not set" );
        })*/

        it("Should mint an nft", async() => {
    

            const mint_result = await marketplaceInstance.mint(web3.utils.toWei('10','Ether'),{from:accounts[0], value:web3.utils.toWei('0.002', 'Ether')});
            const count = await marketplaceInstance.nftCount();
            const creation_event = mint_result.logs[0].args;
            const nft_event = mint_result.logs[1].args;

            //make sure counter incremented
            assert.equal(toString(count),toString(nftCount + 1), 'Nft not created');
            //test the sold state of the nft
            assert.equal(false, creation_event.soldBefore);
            //check the price of the new nft
            assert.equal(web3.utils.toWei('10','Ether'), creation_event.price);
            //check the owner of the new nft
            assert.equal(creation_event.owner, nft_event.to, accounts[0]);
            //check the TokenID
            assert.equal(toString(creation_event.id), toString(nft_event.TokenId), toString(nftCount));

        })
      /*  it("Should be owned by the contract", async() => {

            const  contract = await marketplaceInstance.address
            const owner_return = await marketplaceInstance.ownerOf(0);
            assert.equal(owner_return, contract, "The contract is not the owner");
            
        })*/

        it("Should buy an nft", async() => {

            const buy = await marketplaceInstance.purchaseCard(0, {from: accounts[1], value: web3.utils.toWei('10','Ether')});
            const transfer_event = await buy.logs[0].args;
            const purchase_event = await buy.logs[1].args;
            
            //see ownership transfer
            assert(transfer_event.to, accounts[1], purchase_event.owner);
            
        })

       

    
    })