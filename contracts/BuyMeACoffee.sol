//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

//deployed to Rinkeby at 0xAA515aB66297cf1D0d82Eafc6A10ecD107e77492

contract BuyMeACoffee {
    //Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo Struct
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    Memo[] memos;

    address payable owner;

    constructor(){
        owner = payable(msg.sender);
    }

    function buyCoffee(string memory _name, string memory _message) public payable{
        require(msg.value > 0, "Can't buy coffee with 0 eth");

        memos.push(Memo(msg.sender, block.timestamp, _name, _message));

        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }



    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     *    @dev send the entire balance stored in this contract to the owner
     */
    function getMemos() public view returns(Memo[] memory){
        return memos;
    }
}
