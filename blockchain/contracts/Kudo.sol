// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
 
contract Kudos {
    mapping (address => Kudo[]) public  allKudos;

    function giveKudo( address _reciever ,string memory _what,string memory _comments ) external {
        allKudos[_reciever].push(Kudo(_what,msg.sender,_comments));
    }
    function getKudosLength( address who ) public view returns(uint){
        return allKudos[who].length;
    }
}

    struct Kudo {
        string what;
        address giver;
        string comments;
    }