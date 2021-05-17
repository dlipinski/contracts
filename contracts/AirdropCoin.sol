// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.4;

contract SimpleCoin {
    string private _name = "SimpleCoin";
    string private _symbol = "SCO";
    uint256 private _totalSupply = (10**3) * (10**9);
    uint8 private _decimals = 9;
    bool _isAirdrop = true;
    uint256 _airdropAmount = 10;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(address => bool) private _airDropers;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor() {
        _balances[msg.sender] = _totalSupply;
    }

    function isAidrop() public view returns (bool) {
        return _isAirdrop;
    }

    function setIsAirdrop(bool newIsAirdrop) external {
        _isAirdrop = newIsAirdrop;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount)
        external
        returns (bool)
    {
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function allowance(address owner, address spender)
        external
        view
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        _allowances[sender][msg.sender] -= amount;
        emit Approval(sender, msg.sender, _allowances[sender][msg.sender]);
        return true;
    }
}
