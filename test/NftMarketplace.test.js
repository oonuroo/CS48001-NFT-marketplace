const NftMarketplace = artifacts.require("TurkishFootballCards");

contract('TurkishFootballCards', (accounts) => {

        it("should be deployed", async() => {
             marketplaceInstance = await NftMarketplace.deployed();
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

        it("should set the price of minting", async() => {

            const price =  await marketplaceInstance.mintPrice();
            assert.equal(price, web3.utils.toWei('0.002', 'Ether'), "The mint price was not set" );
        })
        it("Should be able to mint an nft", async() => {
            let oldMinterBallance
            oldMinterBallance = web3.eth.getBalance(accounts[0]);
            //oldMinterBallance = new web3.utils.toBN(oldMinterBallance);

            //success
            const mint = await marketplaceInstance.mint(web3.utils.toWei('10','Ether'),{from:accounts[0], value:web3.utils.toWei('0.002', 'Ether')});
            const count = await marketplaceInstance.nftCount();
            assert.equal(count,'1', 'Nft not created');
            //check if the balance has dropped
            let newMintersBallance
            newMintersBallance = web3.eth.getBalance(accounts[0]);
            //newMintersBallance = new web3.utils.toBN(newMintersBallance);
            assert.notEqual(newMintersBallance, oldMinterBallance, 'Balance has not changed');
            console.log(oldMinterBallance, newMintersBallance);

        })

       

    
    })