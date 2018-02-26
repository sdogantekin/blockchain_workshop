pragma solidity ^0.4.11;

contract Fibonacci {
    function Fibonacci() public {        
    }

    function calculateFibonacci(uint _value) public pure returns (uint result) {
        require(_value < 10);
        if (_value == 0) {
            result = 0;
        } else if (_value == 1) {
            result = 1;
        } else { 
            result = calculateFibonacci(_value-1) + calculateFibonacci(_value-2);
        }            
    }
    
    function calculateFibonacci2(uint _value) public pure returns(uint result) {
        require(_value < 10);
        if (_value == 0) {
            result = 0;
        } else if (_value == 1) {
            result = 1;        
        }
        uint[] memory array = new uint[](2);
        array[0] = 0;
        array[1] = 1;
        for (uint index = 2; index <= _value; index++) {
            uint value = array[0] + array [1];
            array[0] = array[1];
            array[1] = value;
        }    
        result = array[1];        
    }
}