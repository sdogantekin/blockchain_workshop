pragma solidity ^0.4.11;

import "./strings.sol";

contract HelloWeb {
    using strings for *;
    string public message;

    function HelloWeb(string _message) public {
        message = _message;
    }

    function say(string name) public view returns(string) {
        return message.toSlice().concat(name.toSlice());
    }
}