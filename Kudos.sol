pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

  contract  Kudos is ERC721{

      constructor() ERC721("kudos","mjk"){

      }


      mapping (address => uint[]) allKudos;
      mapping(uint => Kudo) nfts;
      uint public nextTokenId = 0;

      function giveKudos(address who,string memory what,string memory comment) public {
          Kudo memory kudo = Kudo(what,msg.sender,comment,nextTokenId);
          
          _mint(who,nextTokenId);
          nfts[nextTokenId] = kudo;

            allKudos[who].push(nextTokenId);

          nextTokenId = nextTokenId+1;
          
      }

    function getKudosLength(address who) public view returns(uint){
        uint[] memory kudosForWho = allKudos[who];
        return kudosForWho.length;
    }

      function getKudosAtIndex(address who,uint idx) public view returns(string memory,address,string memory){
          Kudo memory kudo = nfts[allKudos[who][idx]];
          return (kudo.what,kudo.giver,kudo.comment);
      }

      function getNftInfo(uint _tokenId) public view returns(string memory,address,string memory){ 
           Kudo memory kudo = nfts[_tokenId];
          return (kudo.what,kudo.giver,kudo.comment);
      }
  }

  struct Kudo{
      string what;
      address giver;
      string comment;
      uint nftTokenId;
  }
