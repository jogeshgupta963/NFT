// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./base64.sol";
 
contract Kudos is ERC721 {

    constructor() ERC721("Kudos","KUD") {}
    uint nextTokenId = 0;

    mapping (address => uint[]) public  allKudos;
    mapping(uint => Kudo) public nfts;

    function giveKudos( address _reciever ,string memory _what,string memory _comments ) external {
        Kudo memory kudo = Kudo(_what,msg.sender,_comments,nextTokenId,_reciever);
        _mint(_reciever,nextTokenId);
        nfts[nextTokenId] = kudo;
        allKudos[_reciever].push(nextTokenId);
        nextTokenId++;
    }
     function toAsciiString(address x) internal pure returns (string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
        bytes1 b = bytes1(uint8(uint(uint160(x)) / (2**(8*(19 - i)))));
        bytes1 hi = bytes1(uint8(b) / 16);
        bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
        s[2*i] = char(hi);
        s[2*i+1] = char(lo);            
    }
    return string(s);
    }

function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
   }
    function tokenURI(uint tokenID) public view override returns (string memory) {
        Kudo memory kudo = nfts[tokenID];
        
        string[9] memory parts;
        parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

        parts[1] = toAsciiString(kudo.reciever);

        parts[2] = '</text><text x="10" y="40" class="base">';

        parts[3] = toAsciiString(kudo.giver) ;

        parts[4] = '</text><text x="10" y="60" class="base">';

        parts[5] = kudo.what;

        parts[6] = '</text><text x="10" y="80" class="base">';

        parts[7] = kudo.comments;

        parts[8] = '</text></svg>';

        string memory image = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));

        string memory kudoJSON =  Base64.encode(bytes(string(abi.encodePacked('{"image": "data:image/svg+xml;base64,', Base64.encode(bytes(image)), '"}'))));
        string memory output = string(abi.encodePacked('data:application/json;base64,', kudoJSON));

        return output;

    }
}
    struct Kudo {
        string what;
        address giver;
        string comments;
        uint nftTokenId;
        address reciever;
    }