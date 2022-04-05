 pragma solidity >=0.7.0 <0.9.0;

  contract  Kudos {
      mapping (address => Kudo[]) allKudos;

      function giveKudos(address who,string memory what,string memory comment) public {
          Kudo memory kudo = Kudo(what,msg.sender,comment);
          allKudos[who].push(kudo);
      }

    function getKudosLength(address who) public view returns(uint){
        Kudo[] memory kudosForWho = allKudos[who];
        return kudosForWho.length;
    }

      function getKudosAtIndex(address who,uint idx) public view returns(string memory,address,string memory){
          Kudo memory kudo = allKudos[who][idx];
          return (kudo.what,kudo.giver,kudo.comment);
      }
  }

  struct Kudo{
      string what;
      address giver;
      string comment;
  }

  // giving to ->0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
  // from ->0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
