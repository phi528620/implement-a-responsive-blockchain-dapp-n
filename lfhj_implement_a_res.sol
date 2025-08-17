pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/ReentrancyGuard.sol";

contract LfhjNotifier {
    using SafeERC20 for address;

    struct Notification {
        address user;
        string message;
        uint256 timestamp;
    }

    mapping(address => Notification[]) public notifications;

    event NewNotification(address user, string message, uint256 timestamp);

    constructor() {
        // Initialize the contract with an initial notification
        notifications[msg.sender].push(Notification(msg.sender, "Initial notification", block.timestamp));
    }

    function notifyUser(address _user, string memory _message) public {
        require(_user != address(0), "Invalid user address");
        require(bytes(_message).length > 0, "Empty message");

        notifications[_user].push(Notification(_user, _message, block.timestamp));

        emit NewNotification(_user, _message, block.timestamp);
    }

    function getNotifications(address _user) public view returns (Notification[] memory) {
        return notifications[_user];
    }
}