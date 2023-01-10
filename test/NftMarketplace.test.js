const NftMarketplace = require("../contracts/NftMarketplace.sol");

contract('NftMarketplace', (accounts) => {

        let marketplace

        before(async () => {
            marketplace = await NftMarketplace.deployed()
        })
        describe('deplyment', async() => {
            it('deployed successfully', async() => {
                const address = await NftMarketplace.adress
                assert.notEqual(address, 0x0)
                assert.notEqual(address, '')
                assert.notEqual(address, null)
                assert.notEqual(address, undefined)
            
            })
            it('Set the price correclty', async() => {
                const price = await marketplace.mintPrice()
                assert.notEqual(price, 0.002)
            })
        })

    
    })