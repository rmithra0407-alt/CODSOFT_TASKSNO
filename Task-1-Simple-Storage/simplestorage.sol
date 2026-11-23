// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleStorage {
    uint public storedValue;

    event ValueChanged(uint newValue);

    function setValue(uint _value) public {
        storedValue = _value;
        emit ValueChanged(_value);
    }

    function updateValue(uint _value) public {
        storedValue = _value;
        emit ValueChanged(_value);
    }

    function increment() public {
        storedValue++;
        emit ValueChanged(storedValue);
    }

    function decrement() public {
        require(storedValue > 0, "Value cannot be negative");
        storedValue--;
        emit ValueChanged(storedValue);
    }

    function getValue() public view returns (uint) {
        return storedValue;
    }
}