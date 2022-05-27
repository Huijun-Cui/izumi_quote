swap_abi = [
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "addr",
				"type": "address"
			},
			{
				"internalType": "uint128",
				"name": "amount",
				"type": "uint128"
			},
			{
				"internalType": "bytes",
				"name": "path",
				"type": "bytes"
			}
		],
		"name": "izumi_swap",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "izumi_quote",
				"type": "address"
			},
			{
				"internalType": "uint128",
				"name": "amount",
				"type": "uint128"
			},
			{
				"internalType": "bytes[]",
				"name": "paths",
				"type": "bytes[]"
			},
			{
				"internalType": "address[]",
				"name": "pairs",
				"type": "address[]"
			},
			{
				"internalType": "uint128[]",
				"name": "directions",
				"type": "uint128[]"
			},
			{
				"internalType": "uint256[]",
				"name": "fees",
				"type": "uint256[]"
			}
		],
		"name": "multi_swap",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "amount_rets",
				"type": "uint256[]"
			},
			{
				"internalType": "uint256[]",
				"name": "amount_inner",
				"type": "uint256[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"inputs": [],
		"name": "_owner",
		"outputs": [
			{
				"internalType": "address payable",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "pair",
				"type": "address"
			}
		],
		"name": "get_reserves",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "reserveA",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "reserveB",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]