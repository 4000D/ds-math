/// math.sol -- mixin for inline numerical wizardry

// Copyright (C) 2015, 2016, 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.10;

contract DSMath {
    function incr(uint128 x, uint128 y) constant returns (uint128 z) {
        assert((z = x + y) >= x);
    }

    function add(uint128 x, uint128 y) constant returns (uint128) {
        return incr(uint128(x), uint128(y));
    }

    function decr(uint128 x, uint128 y) constant returns (uint128 z) {
        assert((z = x - y) <= x);
    }

    function subtract(uint128 x, uint128 y) constant returns (uint128) {
        return decr(x, y);
    }

    function mul(uint128 x, uint128 y) constant returns (uint128 z) {
        assert((z = x * y) >= x);
    }

    function multiply(uint128 x, uint128 y) constant returns (uint128) {
        return mul(x, y);
    }

    function cast(uint256 x) constant returns (uint128 z) {
        assert((z = uint128(x)) == x);
    }

    uint128 constant WAD = 10 ** 18;

    function wmul(uint128 x, uint128 y) constant returns (uint128 z) {
        z = cast((uint256(x) * y + WAD / 2) / WAD);
    }

    function multiplyWad(uint128 x, uint128 y) constant returns (uint128) {
        return wmul(x, y);
    }

    function wdiv(uint128 x, uint128 y) constant returns (uint128 z) {
        z = cast((uint256(x) * WAD + y / 2) / y);
    }

    function divideWad(uint128 x, uint128 y) constant returns (uint128) {
        return wdiv(x, y);
    }

    uint128 constant RAY = 10 ** 36;

    function rmul(uint128 x, uint128 y) constant returns (uint128 z) {
        z = cast((uint256(x) * y + RAY / 2) / RAY);
    }

    function multiplyRay(uint128 x, uint128 y) constant returns (uint128) {
        return rmul(x, y);
    }

    function rdiv(uint128 x, uint128 y) constant returns (uint128 z) {
        z = cast((uint256(x) * RAY + y / 2) / y);
    }

    function divideRay(uint128 x, uint128 y) constant returns (uint128) {
        return rdiv(x, y);
    }

    function rpow(uint128 x, uint64 n) constant returns (uint128 z) {
        z = n % 2 != 0 ? x : RAY;

        for (n /= 2; n != 0; n /= 2) {
            x = rmul(x, x);

            if (n % 2 != 0) {
                z = rmul(z, x);
            }
        }
    }

    function powRay(uint128 x, uint64 n) constant returns (uint128) {
        return rpow(x, n);
    }

    function min(uint128 x, uint128 y) constant internal returns (uint128 z) {
        return (x <= y) ? x : y;
    }
    function max(uint128 x, uint128 y) constant internal returns (uint128 z) {
        return (x >= y) ? x : y;
    }

}
