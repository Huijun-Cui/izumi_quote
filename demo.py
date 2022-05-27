
from web3 import Web3
from abi import *
import time
def getAmountOut(amountIn,reserveIn,reserveOut):
    amountInWithFee = amountIn * 9990
    numerator = amountInWithFee * reserveOut
    denominator = reserveIn * 10000 + amountInWithFee
    amountOut = numerator / denominator
    return amountOut
w3 = Web3(Web3.HTTPProvider('https://bsc-dataseed.binance.org/'))
addr_input = '0xE9C97c26a090FdA5F526b3E2A45861F8D612789D'
izumi = w3.eth.contract(address = addr_input,abi = swap_abi)
# print(izumi.functions.factory().call())
ret = izumi.functions.multi_swap(
    "0x12a76434182c8cAF7856CE1410cD8abfC5e2639F",
    int(10 ** 18),
    ["0xe9e7cea3dedca5984780bafc599bd69add087d56" + \
        "0007d0" + \
            "bb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c" + \
                "0007d0" + "e9e7cea3dedca5984780bafc599bd69add087d56",
                    "0xe9e7cea3dedca5984780bafc599bd69add087d560007d0bb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c"
                    ],
    ["0x0000000000000000000000000000000000000000","0x58F876857a02D6762E0101bb5C46A8c1ED44Dc16"],
    [0] * 2,
    [25] * 2
).call()
print(ret)