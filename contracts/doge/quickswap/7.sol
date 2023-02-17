// Decompiled by library.dedaub.com
// 2023.02.16 23:05 UTC
// Compiled using the solidity compiler version 0.7.6


// Data structures and variables inferred from the use of storage instructions
uint256 _algebraSwapCallback; // STORAGE[0x0]



function WNativeToken() public payable {
    return 0xb7ddc6414bf4f5515b52d8bdd69973ae205ff101;
}

function quoteExactOutputSingle(address varg0, address varg1, uint256 varg2, uint160 varg3) public payable {
    require(msg.data.length - 4 >= 128);
    require(varg0 == varg0);
    require(varg1 == varg1);
    require(varg3 == address(varg3));
    v0, v1 = 0x593(varg3, varg2, varg1);
    return v1, uint16(v0);
}

function factory() public payable {
    return 0xd2480162aa7f02ead7bf4c127465446150d58452;
}

function quoteExactInput(bytes varg0, uint256 varg1) public payable {
    require(msg.data.length - 4 >= 64);
    require(varg0 <= 0xffffffffffffffff);
    require(4 + varg0 + 31 < msg.data.length);
    assert(varg0.length <= 0xffffffffffffffff);
    v0 = new bytes[](varg0.length);
    assert(!((v0 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + varg0.length)) < v0) | (v0 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + varg0.length)) > 0xffffffffffffffff)));
    require(4 + varg0 + varg0.length + 32 <= msg.data.length);
    CALLDATACOPY(v0.data, varg0.data, varg0.length);
    v0[varg0.length] = 0;
    require((v0.length - 20) / 20 <= 0xffffffffffffffff);
    v1 = new uint256[]((v0.length - 20) / 20);
    if ((v0.length - 20) / 20) {
        CALLDATACOPY(v1.data, msg.data.length, (v0.length - 20) / 20 << 5);
    }
    v2 = v3 = 0;
    while (1) {
        v4, v5 = 0x821(v0);
        v6, v7 = 0x2e0(0, v7, v4);
        if (60 <= MEM[v0] < MEM[v2]) {
            break;
        }
        assert(60 <= MEM[v0] < MEM[v2]);
        MEM[32 + ((60 <= MEM[v0]) << 5) + v2] = uint16(v6);
        if (!v5) {
            break;
        }
        if (!v5) {
            v8 = v9 = 0;
            v10 = new array[](MEM[v2]);
            v11 = v12 = v10.data;
            v13 = v14 = v2 + 32;
            while (v8 < MEM[v2]) {
                MEM[v11] = uint16(MEM[v13]);
                v13 += 32;
                v11 += 32;
                v8 += 1;
            }
            return v7, v10;
        }
        v0 = v15 = 0x9aa(v7);
        v2 = v16 = 1 + (60 <= MEM[v0]);
    }
}

function () public payable {
    revert();
}

function 0x2e0(uint256 varg0, uint256 varg1, uint256 varg2) private {
    varg1 = v0 = 0;
    v1 = address(v2) < address(varg2);
    v3 = 0x85f(varg2, v2);
    require(varg1 < 0x8000000000000000000000000000000000000000000000000000000000000000);
    if (!address(varg0)) {
        if (v1) {
            varg1 = v4 = 0x1000276a4;
        } else {
            varg1 = v5 = 0xfffd8963efd1fc6a506488495d951d5263988d25;
        }
    }
    v6 = varg2 << 96 & 0xffffffffffffffffffffffffffffffffffffffff000000000000000000000000;
    v7 = address(varg1);
    v8 = new array[](40);
    v9 = v10 = 0;
    while (v9 < 40) {
        v8[v9] = MEM[v9 + (MEM[64] + 32)];
        v9 += 32;
    }
    if (v9 > 40) {
        v8[40] = 0;
    }
    require((address(v3)).code.size);
    v11 = v12, v13, v14, v15 = address(v3).swap(address(this), v1, varg1, v7, v8, v16, v6).gas(msg.gas);
    if (v12) {
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 64);
        v11 = v17 = 1;
    }
    if (!v11) {
        if (!RETURNDATASIZE()) {
            v18 = v19 = 96;
        } else {
            v18 = v20 = new bytes[](RETURNDATASIZE());
            RETURNDATACOPY(v20.data, 0, RETURNDATASIZE());
        }
        if (64 == MEM[v18]) {
            require(v15 + MEM[v18] - v15 >= 64);
            varg1 = v21 = MEM[v15];
            varg1 = v22 = MEM[v15 + 32];
            require(v22 == uint16(v22));
        } else {
            if (MEM[v18] >= 68) {
                require(32 + (v18 + 4) + MEM[v18 + 4] - (32 + (v18 + 4)) >= 32);
                require(MEM[32 + (v18 + 4)] <= 0xffffffffffffffff);
                require(32 + (v18 + 4) + MEM[v18 + 4] > 32 + (v18 + 4) + MEM[32 + (v18 + 4)] + 31);
                v23 = MEM[32 + (v18 + 4) + MEM[32 + (v18 + 4)]];
                assert(v23 <= 0xffffffffffffffff);
                v24 = new bytes[](v23);
                assert(!((v24 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + v23)) < v24) | (v24 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + v23)) > 0xffffffffffffffff)));
                require(32 + (v18 + 4) + MEM[32 + (v18 + 4)] + v23 + 32 <= 32 + (v18 + 4) + MEM[v18 + 4]);
                v25 = v26 = 0;
                while (v25 < v23) {
                    v24[v25] = MEM[v25 + (32 + (v18 + 4) + MEM[32 + (v18 + 4)] + 32)];
                    v25 += 32;
                }
                if (v25 > v23) {
                    v24[v23] = 0;
                }
                v27 = new array[](v24.length);
                v28 = v29 = 0;
                while (v28 < v24.length) {
                    v27[v28] = v24[v28];
                    v28 += 32;
                }
                if (v28 > v24.length) {
                    v27[v24.length] = 0;
                }
                goto 0x917B0x453;
            }
            revert(Error(v27));
        }
    }
    return varg1, varg1;
}

function 0x593(uint256 varg0, uint256 varg1, uint256 varg2) private {
    varg1 = v0 = 0;
    v1 = address(v2) < address(varg2);
    if (!address(varg0)) {
        _algebraSwapCallback = varg1;
    }
    v3 = 0x85f(varg2, v2);
    require(varg1 < 0x8000000000000000000000000000000000000000000000000000000000000000);
    v4 = 0 - varg1;
    if (!address(varg0)) {
        if (v1) {
            varg1 = v5 = 0x1000276a4;
        } else {
            varg1 = v6 = 0xfffd8963efd1fc6a506488495d951d5263988d25;
        }
    }
    v7 = v2 << 96 & 0xffffffffffffffffffffffffffffffffffffffff000000000000000000000000;
    v8 = address(varg1);
    v9 = new array[](40);
    v10 = v11 = 0;
    while (v10 < 40) {
        v9[v10] = MEM[v10 + (MEM[64] + 32)];
        v10 += 32;
    }
    if (v10 > 40) {
        v9[40] = 0;
    }
    require((address(v3)).code.size);
    v12 = v13, v14, v15, v16 = address(v3).swap(address(this), v1, v4, v8, v9, v17, v7).gas(msg.gas);
    if (v13) {
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 64);
        v12 = v18 = 1;
    }
    if (!v12) {
        if (!RETURNDATASIZE()) {
            v19 = v20 = 96;
        } else {
            v19 = v21 = new bytes[](RETURNDATASIZE());
            RETURNDATACOPY(v21.data, 0, RETURNDATASIZE());
        }
        if (!address(varg1)) {
            _algebraSwapCallback = 0;
        }
        if (64 == MEM[v19]) {
            require(v16 + MEM[v19] - v16 >= 64);
            varg1 = v22 = MEM[v16];
            varg1 = v23 = MEM[v16 + 32];
            require(v23 == uint16(v23));
        } else {
            if (MEM[v19] >= 68) {
                require(32 + (v19 + 4) + MEM[v19 + 4] - (32 + (v19 + 4)) >= 32);
                require(MEM[32 + (v19 + 4)] <= 0xffffffffffffffff);
                require(32 + (v19 + 4) + MEM[v19 + 4] > 32 + (v19 + 4) + MEM[32 + (v19 + 4)] + 31);
                v24 = MEM[32 + (v19 + 4) + MEM[32 + (v19 + 4)]];
                assert(v24 <= 0xffffffffffffffff);
                v25 = new bytes[](v24);
                assert(!((v25 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + v24)) < v25) | (v25 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + v24)) > 0xffffffffffffffff)));
                require(32 + (v19 + 4) + MEM[32 + (v19 + 4)] + v24 + 32 <= 32 + (v19 + 4) + MEM[v19 + 4]);
                v26 = v27 = 0;
                while (v26 < v24) {
                    v25[v26] = MEM[v26 + (32 + (v19 + 4) + MEM[32 + (v19 + 4)] + 32)];
                    v26 += 32;
                }
                if (v26 > v24) {
                    v25[v24] = 0;
                }
                v28 = new array[](v25.length);
                v29 = v30 = 0;
                while (v29 < v25.length) {
                    v28[v29] = v25[v29];
                    v29 += 32;
                }
                if (v29 > v25.length) {
                    v28[v25.length] = 0;
                }
                goto 0x917B0x737;
            }
            revert(Error(v28));
        }
    }
    return varg1, varg1;
}

function 0x821(uint256 varg0) private {
    require(20 >= 0, Error('toAddress_overflow'));
    require(varg0.length >= 20, Error('toAddress_outOfBounds'));
    require(40 >= 20, Error('toAddress_overflow'));
    require(varg0.length >= 40, Error('toAddress_outOfBounds'));
    return varg0[20] >> 96, varg0[0] >> 96;
}

function 0x85f(uint256 varg0, uint256 varg1) private {
    MEM[MEM[64]] = 0;
    MEM[MEM[64] + 32] = 0;
    v0 = address(varg1);
    v1 = address(varg1);
    require(address(v0) < address(v1));
    MEM[MEM[64] + 128] = 0xff00000000000000000000000000000000000000000000000000000000000000;
    MEM[MEM[64] + 129] = 0x56c2162254b0e4417288786ee402c2b41d4e181e000000000000000000000000;
    MEM[MEM[64] + 149] = keccak256(address(v0), address(v1));
    MEM[MEM[64] + 181] = 0x6ec6c9c8091d160c0aa74b2b14ba9c1717e95093bd3ac085cee99a49aab294a4;
    v2 = new array[](181 + (MEM[64] - v2));
    v3 = v2.length;
    v4 = v2.data;
    return keccak256(v2);
}

function algebraSwapCallback(int256 varg0, int256 varg1, bytes varg2) public payable {
    require(msg.data.length - 4 >= 96);
    require(varg2 <= 0xffffffffffffffff);
    require(4 + varg2 + 31 < msg.data.length);
    assert(varg2.length <= 0xffffffffffffffff);
    v0 = new bytes[](varg2.length);
    assert(!((v0 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + varg2.length)) < v0) | (v0 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + varg2.length)) > 0xffffffffffffffff)));
    require(4 + varg2 + varg2.length + 32 <= msg.data.length);
    CALLDATACOPY(v0.data, varg2.data, varg2.length);
    v0[varg2.length] = 0;
    v1 = v2 = varg0 > 0;
    if (varg0 <= 0) {
        v1 = v3 = varg1 > 0;
    }
    require(v1);
    v4 = v5, v4 = v6 = 0x821(v0);
    MEM[MEM[64]] = 0;
    MEM[MEM[64] + 32] = 0;
    MEM[64] += 64;
    require(address(v4) < address(v4));
    MEM[MEM[64] + 128] = 0xff00000000000000000000000000000000000000000000000000000000000000;
    MEM[MEM[64] + 129] = 0x56c2162254b0e4417288786ee402c2b41d4e181e000000000000000000000000;
    MEM[MEM[64] + 149] = keccak256(address(v4), address(v4));
    MEM[MEM[64] + 181] = 0x6ec6c9c8091d160c0aa74b2b14ba9c1717e95093bd3ac085cee99a49aab294a4;
    v7 = new array[](181 + (MEM[64] - v7));
    v8 = v7.length;
    v9 = v7.data;
    require(address(keccak256(v7)) == msg.sender);
    if (varg0 > 0) {
        v10 = v11 = address(v6) < address(v5);
        v12 = v13 = 0 - varg1;
    } else {
        v10 = v14 = address(v5) < address(v6);
        v12 = v15 = 0 - varg0;
    }
    v16 = 0x85f(v5, v6);
    require((address(v16)).code.size);
    v17, v18, v19, v20, v21, v22, v23, v24 = address(v16).globalState().gas(msg.gas);
    require(v17); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 224);
    require(v18 == address(v18));
    require(v19 == (signextend(v19, 0x2)));
    require(v20 == uint16(v20));
    require(v21 == uint16(v21));
    require(v22 == v22 & 0xff);
    require(v23 == v23 & 0xff);
    require(v24 == v24);
    require(!v10, ROOT4146650865(v20));
    require(_algebraSwapCallbackv20);
    require(v12 == _algebraSwapCallback);
    revert(v20);
}

function 0x9aa(uint256 varg0) private {
    v0 = MEM[varg0] - 20;
    require(31 + v0 >= v0, Error('slice_overflow'));
    require(20 + v0 >= 20, Error('slice_overflow'));
    require(MEM[varg0] >= 20 + v0, Error('slice_outOfBounds'));
    if (v0) {
        v1 = v2 = MEM[64];
        v3 = v4 = v2 + (v0 & 0x1f) + (!(v0 & 0x1f) << 5);
        v5 = v6 = varg0 + (v0 & 0x1f) + (!(v0 & 0x1f) << 5) + 20;
        while (v3 < v4 + v0) {
            MEM[v3] = MEM[v5];
            v3 += 32;
            v5 += 32;
        }
        MEM[v2] = v0;
        MEM[64] = 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + v3;
    } else {
        v1 = v7 = MEM[64];
        MEM[v7] = 0;
        MEM[64] = v7 + 32;
    }
    return v1;
}

function quoteExactInputSingle(address varg0, address varg1, uint256 varg2, uint160 varg3) public payable {
    require(msg.data.length - 4 >= 128);
    require(varg0 == varg0);
    require(varg1 == varg1);
    require(varg3 == address(varg3));
    v0, v1 = 0x2e0(varg3, varg2, varg1);
    return v1, uint16(v0);
}

function quoteExactOutput(bytes varg0, uint256 varg1) public payable {
    require(msg.data.length - 4 >= 64);
    require(varg0 <= 0xffffffffffffffff);
    require(4 + varg0 + 31 < msg.data.length);
    assert(varg0.length <= 0xffffffffffffffff);
    v0 = new bytes[](varg0.length);
    assert(!((v0 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + varg0.length)) < v0) | (v0 + (32 + (0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0 & 31 + varg0.length)) > 0xffffffffffffffff)));
    require(4 + varg0 + varg0.length + 32 <= msg.data.length);
    CALLDATACOPY(v0.data, varg0.data, varg0.length);
    v0[varg0.length] = 0;
    require((v0.length - 20) / 20 <= 0xffffffffffffffff);
    v1 = new uint256[]((v0.length - 20) / 20);
    if ((v0.length - 20) / 20) {
        CALLDATACOPY(v1.data, msg.data.length, (v0.length - 20) / 20 << 5);
    }
    v2 = v3 = 0;
    while (1) {
        v4, v5 = 0x821(v0);
        v6, v7 = 0x593(0, v7, v5);
        if (60 <= MEM[v0] < MEM[v2]) {
            break;
        }
        assert(60 <= MEM[v0] < MEM[v2]);
        MEM[32 + ((60 <= MEM[v0]) << 5) + v2] = uint16(v6);
        if (!v5) {
            break;
        }
        if (!v5) {
            v8 = v9 = 0;
            v10 = new array[](MEM[v2]);
            v11 = v12 = v10.data;
            v13 = v14 = v2 + 32;
            while (v8 < MEM[v2]) {
                MEM[v11] = uint16(MEM[v13]);
                v13 += 32;
                v11 += 32;
                v8 += 1;
            }
            return v7, v10;
        }
        v0 = v15 = 0x9aa(v7);
        v2 = v16 = 1 + (60 <= MEM[v0]);
    }
}

function poolDeployer() public payable {
    return 0x56c2162254b0e4417288786ee402c2b41d4e181e;
}

// Note: The function selector is not present in the original solidity code.
// However, we display it for the sake of completeness.

function __function_selector__(bytes4 function_selector) public payable {
    MEM[64] = 128;
    require(!msg.value);
    if (msg.data.length < 4) {
        ();
    } else if (0x8af3ac85 > function_selector >> 224) {
        if (0x2c8958f6 == function_selector >> 224) {
            algebraSwapCallback(int256,int256,bytes);
        } else if (0x2d9ebd1d == function_selector >> 224) {
            quoteExactInputSingle(address,address,uint256,uint160);
        } else if (0x2f80bb1d == function_selector >> 224) {
            quoteExactOutput(bytes,uint256);
        } else {
            require(0x3119049a == function_selector >> 224);
            poolDeployer();
        }
    } else if (0x8af3ac85 == function_selector >> 224) {
        WNativeToken();
    } else if (0x9e73c81d == function_selector >> 224) {
        quoteExactOutputSingle(address,address,uint256,uint160);
    } else if (0xc45a0155 == function_selector >> 224) {
        factory();
    } else {
        require(0xcdca1753 == function_selector >> 224);
        quoteExactInput(bytes,uint256);
    }
}
