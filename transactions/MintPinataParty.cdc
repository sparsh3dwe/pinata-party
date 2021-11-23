import PinataPartyContract from 0xfe4fd66a6dff7c51

transaction {
  let receiverRef: &{PinataPartyContract.NFTReceiver}
  let minterRef: &PinataPartyContract.NFTMinter

  prepare(acct: AuthAccount) {
      self.receiverRef = acct.getCapability<&{PinataPartyContract.NFTReceiver}>(/public/NFTReceiver)
          .borrow()
          ?? panic("Could not borrow receiver reference")        
      
      self.minterRef = acct.borrow<&PinataPartyContract.NFTMinter>(from: /storage/NFTMinter)
          ?? panic("could not borrow minter reference")
  }

  execute {
      let metadata : {String : String} = {
          "name": "iTinker's ABCDE",
          "A": "Abhay", 
          "B": "Bani", 
          "C": "Chinmay",
          "D":"Dia",
          "E":"Era",
          "uri": "ipfs://QmWG4hw3yMRmbQnemKk6GoLrfRe3dohrbmcMsz3z5v7p7g"
      }
      let newNFT <- self.minterRef.mintNFT()
  
      self.receiverRef.deposit(token: <-newNFT, metadata: metadata)

      log("NFT Minted and deposited to Account 2's Collection")
  }
}
 