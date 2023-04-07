I. QUICKSTART:

1. (if not) set the prod(nexo-exchanges) credentials in .aws/credentials [default]. Put the package in workdir or in `PYTHONPATH:` and import like:

`from quant_data_wrapper.wrapper import QuantWrapper`

`wrapper = QuantWrapper()`


II. SOURCES:
```    
source | databases:
    nexdp,
    marketdata,
    report,

tables:
    nexdp.influx_mmeh_stats
        influx_stats_default
        mm_deal
        mm_order
        mm_trade
        spot_edge_orderbook
        spot_edge_ticker
        spot_ticker
        spot_trade

    marketdata.mm_spot_trades
        mm_spot_tickers
        mm_tardis_perp_tickers
        mm_spot_ob_events
        mm_tardis_perp_ob
        mm_spot_ob_snapshots
        mm_tardis_perp_ob_snapshots
        mm_tardis_enriched_options_trades
        mm_tardis_perp_trades
        mm_tardis_options_trades
        ad_deribit_options_trades

    reports.mm_daily_markouts
```

III. METHODS:

***common params:
    debug=True | False *True prints query
    columns=list()
    date_from, date_to=string like 'YYYY-MM-DD'


1. Single source
```
wrapper.get_mm_trade(source="nexdp", columns=[#columns to select | empty or no param returns all columns],date_from="2023-02-22", date_to="2023-02-22", debug=True|False) 


wrapper.get_mm_deal(source="nexdp", columns=[#columns to select | empty or no param for all columns], date_from=deal_day_from, date_to=deal_day_to, symbols=, timestamp)

wrapper.get_mm_order(source="nexdp", columns=[#columns to select | empty or no param for all columns], 

date_from="year-month-day", date_to="year-month-day",
                    symbols=["BASE/QUOTE"],
                    exchanges=["EXCHANGE"],
                    timestamp='timestamp+1hour',
                    limit=(imit of returner rows)
```
2. Multi source
```
wrapper.get_trades(source="ad" | "tardis_perp" | "nexdp", 
                    columns=[#columns to select | empty or no param for all columns],
                    symbols=["base_qoute"],
                    exchanges=["exchange"],
                    date_from="date",
                    date_to="date",
                    timestamp=milisecond | microsecond | "2022-01-22 00:00:00")


wrapper.get_tickers(source="ad" | "tardis_perp" | "nexdp", 
                    columns=[#columns to select | empty or no param for all columns],
                    symbols=["base_qoute"],
                    exchanges=["exchange"],
                    date_from="date",
                    date_to="date",
                    timestamp=milisecond | microsecond | "2022-01-22 00:00:00")

wrapper.get_ob_events(source="ad" | "tardis" | "nexdp, columns=[#columns to select | empty or no param for all columns])

wrapper.get_ob_snapshots(source="ad" | "tardis", columns=[#columns to select | empty or no param for all columns] )
```
3. Options
```
wrapperp.get_tardis_options_trades(
                                    columns=[#columns to select | empty or no param for all columns], 
                                    symbols=[#this is the underlying],
                                    exchanges=[],
                                    date_from="2023-01-20"
                                    date_to="20239-01-20",
                                    expiration_date_from="2023-02-20",
                                    expiration_date_to="2023-02-20",
                                    symbols=["ETH-01JAN23"])


wrapper.get_tardis_enriched_options_trades(
                                    columns=[#columns to select | empty or no param for all columns], 
                                    symbols=[#this is the underlying],
                                    exchanges=[],
                                    date_from="2023-01-20"
                                    date_to="20239-01-20",
                                    expiration_date_from="2023-02-20",
                                    expiration_date_to="2023-02-20",
                                    symbols=["ETH-01JAN23-"])
```
4. Execute query 
```
wrapper.exec_query(database='marketdata'| or anyone else, query='SELECT something FROM table WHERE something', debug=True | False ) 
```
