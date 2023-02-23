// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Conduit Controller Interface
interface IConduitController {
    function getKey(address conduit) external view returns (bytes32);
}

// Custom Error returns 'OpenSeaIsBlocked'
error OpenSeaIsBlocked();

/// @notice An absolutely un-optimized and possibly unnecessary
/// contract that creates a filter to block OpenSea's SeaPort and
/// conduit filters.
abstract contract BlockedSea {
    /// @dev The OpenSea Seaport Address
    address internal constant _SEAPORT =
        0x00000000006c3852cbEf3e08E8dF289169EdE581;

    /// @dev The OpenSea Conduit Controller Address
    address internal constant _CONDUIT_CONTROLLER =
        0x00000000F9490004C11Cef243f5400493c00Ad63;

    /// @dev Modifier to guard and revert if the address matches OpenSea
    modifier blockOpenSea(address from) virtual {
        if (from != msg.sender) {
            if (_blockOpenSeaEnabled()) {
                if (from == _SEAPORT) revert OpenSeaIsBlocked();

                (bool success, ) = _CONDUIT_CONTROLLER.staticcall(
                    abi.encodeWithSelector(
                        IConduitController.getKey.selector,
                        from
                    )
                );

                if (success) revert OpenSeaIsBlocked();
            }
        }
        _;
    }

    /// @dev This function is meant to be overrided in the inheriting contract.
    /// The default is to return true, however this can be set based on user preference.
    function _blockOpenSeaEnabled() internal view virtual returns (bool) {
        return true;
    }
}
