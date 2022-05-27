# izumi_quote

#### 价格获取函数 multi_swap（）
ulti_swap(address izumi_quote,uint128 amount,bytes[] calldata paths,address[] calldata pairs,uint128[] calldata directions,uint[] calldata fees) public returns (uint256[] memory)
izumi_quote：izumiquote 合约地址0x12a76434182c8cAF7856CE1410cD8abfC5e2639F
amount: 是token输入量
paths: 是izumi平台的路径
pairs：是AMM池子（pancake,biswap等）
direction: 表示经过某个AMM池子的时候的顺序，0表示 token->token1
fee:表示AMM池子的万分之手续费（biswap填10,pancake填25）
以上的参数都是列表，demo.py显示