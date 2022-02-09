pragma solidity ^0.5.0;

contract Tether {
    string public name = 'Tether';
    string public symbol = 'USDT';
    uint256 public totalSupply = 100000000000000000000000; // 1 million tokens
    // note that because ethereum has 18 decimal places, 100000000000000000 = 1.
    // to get to 1 million token, six zeros have to be added
    uint8 public decimals = 18; // when a token has 18 decimal places, it means one ether

    event Transfer(
        address indexed _from, 
        address indexed _to,
        uint indexed _value
    ); // index allows for the addresses to be searched

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint _value
    );

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor () {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer (address _to, uint256 _value) public returns(bool success) {

        // ensure that the amount to be transferred is less than balance
        require(_value <= balanceOf[msg.sender]);

        // remove transfer amount from the sender
        balanceOf[msg.sender] -= _value;
        // add transfer amount to the receiver
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom (address _from, address _to, uint256 _value) public returns(bool success) {
        
        require(_value <= balanceOf[_from]);
        require(_value <= allowance[msg.sender][_from]); // take note of this

        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;
        allowance[msg.sender][_from] -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve (address _spender, uint256 _value) public returns(bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);

        return true;
    }
}