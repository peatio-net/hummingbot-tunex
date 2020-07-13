from decimal import Decimal
from typing import (
    Any,
    Dict,
    Optional
)

from hummingbot.core.event.events import (
    OrderType,
    TradeType
)
from hummingbot.market.openware.openware_market import OpenwareMarket
from hummingbot.market.in_flight_order_base import InFlightOrderBase

s_decimal_0 = Decimal(0)


cdef class OpenwareInFlightOrder(InFlightOrderBase):
    def __init__(self,
                 client_order_id: str,
                 exchange_order_id: str,
                 trading_pair: str,
                 order_type: OrderType,
                 trade_type: TradeType,
                 price: Decimal,
                 amount: Decimal,
                 initial_state: str = "WAIT"):
        super().__init__(
            OpenwareMarket,
            client_order_id,
            exchange_order_id,
            trading_pair,
            order_type,
            trade_type,
            price,
            amount,
            initial_state
        )
        self.trade_id_set = set()

    @property
    def is_done(self) -> bool:
        return self.last_state in {"DONE", "CANCEL"}

    @property
    def is_failure(self) -> bool:
        return self.last_state in {"REJECT"}

    @property
    def is_cancelled(self) -> bool:
        return self.last_state in {"CANCEL"}

    @classmethod
    def from_json(cls, data: Dict[str, Any]) -> InFlightOrderBase:
        cdef:
            OpenwareInFlightOrder retval = OpenwareInFlightOrder(
                client_order_id=data["client_order_id"],
                exchange_order_id=data["exchange_order_id"],
                trading_pair=data["trading_pair"],
                order_type=getattr(OrderType, data["order_type"].upper()),
                trade_type=getattr(TradeType, data["trade_type"].upper()),
                price=Decimal(data["price"]),
                amount=Decimal(data["amount"]),
                initial_state=data["last_state"]
            )
        retval.executed_amount_base = Decimal(data["executed_amount_base"])
        retval.executed_amount_quote = Decimal(data["executed_amount_quote"])
        retval.fee_asset = data["fee_asset"]
        retval.fee_paid = Decimal(data["fee_paid"])
        return retval

    def update_with_execution_report(self, execution_report: Dict[str, Any]):
        print('UPDATE WITH EXECUTION REPORT')
        print(execution_report)
        #trade_id = execution_report["t"]
        #if trade_id in self.trade_id_set:
        #    # trade already recorded
        #    return
        #self.trade_id_set.add(trade_id)
        #last_executed_quantity = Decimal(execution_report["l"])
        #last_commission_amount = Decimal(execution_report["n"])
        #last_commission_asset = execution_report["N"]
        #last_order_state = execution_report["X"]
        #last_executed_price = Decimal(execution_report["L"])
        #executed_amount_quote = last_executed_price * last_executed_quantity
        #self.executed_amount_base += last_executed_quantity
        #self.executed_amount_quote += executed_amount_quote
        #if last_commission_asset is not None:
        #    self.fee_asset = last_commission_asset
        #self.fee_paid += last_commission_amount
        #self.last_state = last_order_state

    def update_with_trade_update(self, trade_update: Dict[str, Any]):
        trade_id = trade_update["id"]
        # trade_update["orderId"] is type int
        if str(trade_update["order_id"]) != self.exchange_order_id or trade_id in self.trade_id_set:
            # trade already recorded
            return
        self.trade_id_set.add(trade_id)
        self.executed_amount_base += Decimal(trade_update["amount"])
        # self.fee_paid += Decimal(trade_update["commission"])
        self.executed_amount_quote += Decimal(trade_update["total"])
        # if not self.fee_asset:
        #    self.fee_asset = trade_update["commissionAsset"]
        return trade_update
