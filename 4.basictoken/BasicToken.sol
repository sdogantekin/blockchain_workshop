pragma solidity ^0.4.11;

contract Owner {
    address owner;
    
    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }
    
    function getOwner() public view returns(address) {
        return owner;
    }
}

contract BasicToken is Owner {
    mapping(address => uint) private balanceTable;
    
    function BasicToken(uint initialSupply ) public {
        balanceTable[msg.sender] = initialSupply;
        owner = msg.sender;
    }

    function transfer(address _to, uint value) public {
        require(balanceTable[msg.sender] >= value);
        balanceTable[msg.sender] -= value;
        balanceTable[_to] += value;
    }

    function balanceOf(address _target) public view returns (uint) {
        return balanceTable[_target];
    }
    
    function changeOwner(address newOwner) onlyOwner public returns (address) {
        owner = newOwner;
        return owner;
    }
}