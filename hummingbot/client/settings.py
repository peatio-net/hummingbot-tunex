from os.path import (
    realpath,
    join,
)
from typing import List

from hummingbot import get_strategy_list

# Global variables
required_exchanges: List[str] = []

# Global static values
KEYFILE_PREFIX = "key_file_"
KEYFILE_POSTFIX = ".json"
ENCYPTED_CONF_PREFIX = "encrypted_"
ENCYPTED_CONF_POSTFIX = ".json"
GLOBAL_CONFIG_PATH = "conf/conf_global.yml"
TRADE_FEES_CONFIG_PATH = "conf/conf_fee_overrides.yml"
TOKEN_ADDRESSES_FILE_PATH = realpath(join(__file__, "../../wallet/ethereum/erc20_tokens.json"))
DEFAULT_KEY_FILE_PATH = "conf/"
DEFAULT_LOG_FILE_PATH = "logs/"
DEFAULT_ETHEREUM_RPC_URL = "https://mainnet.coinalpha.com/hummingbot-test-node"
TEMPLATE_PATH = realpath(join(__file__, "../../templates/"))
CONF_FILE_PATH = "conf/"
CONF_PREFIX = "conf_"
CONF_POSTFIX = "_strategy"

EXCHANGES = {
    "bamboo_relay",
    "binance",
    "openware",
    "coinbase_pro",
    "huobi",
    "liquid",
    "radar_relay",
    "dolomite",
    "bittrex",
    "kucoin",
    "bitcoin_com",
    "kraken"
}

DEXES = {
    "bamboo_relay",
    "radar_relay",
    "dolomite"
}

STRATEGIES: List[str] = get_strategy_list()

EXAMPLE_PAIRS = {
    "bamboo_relay": "ZRX-WETH",
    "binance": "ZRX-ETH",
    "openware": "ETH-EUR",
    "bitcoin_com": "ETH-BCH",
    "bittrex": "ZRX-ETH",
    "kucoin": "ETH-USDT",
    "coinbase_pro": "ETH-USDC",
    "dolomite": "WETH-DAI",
    "huobi": "ETH-USDT",
    "liquid": "ETH-USD",
    "radar_relay": "ZRX-WETH",
    "kraken": "ETH-USDC"
}

EXAMPLE_ASSETS = {
    "bamboo_relay": "ZRX",
    "binance": "ZRX",
    "openware": "ETH",
    "bitcoin_com": "BCH",
    "bittrex": "ZRX",
    "kucoin": "ETH",
    "coinbase_pro": "ETH",
    "dolomite": "LRC",
    "huobi": "eth",
    "liquid": "ETH",
    "radar_relay": "ZRX",
    "kraken": "XETH"
}

MAXIMUM_OUTPUT_PANE_LINE_COUNT = 1000
MAXIMUM_LOG_PANE_LINE_COUNT = 1000
MAXIMUM_TRADE_FILLS_DISPLAY_OUTPUT = 100
