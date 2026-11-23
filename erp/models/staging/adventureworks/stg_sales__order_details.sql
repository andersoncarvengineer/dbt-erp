with 

source as (

    select * from {{ source('sales', 'SalesOrderDetail') }}

),


renamed as (

    select
        SalesOrderID                                as order_id,
        SalesOrderDetailID                          as order_detail_id,
        CarrierTrackingNumber                       as carrier_tracking_number,
        OrderQty                                    as order_qty,
        ProductID                                   as product_id,
        SpecialOfferID                              as special_offer_id,
        cast(UnitPrice as decimal(19,4))            as unit_price,
        cast(UnitPriceDiscount as decimal(5, 4))    as discount_rate,
        cast(LineTotal as decimal(19,4))            as line_total_amount,          
        ModifiedDate                                as modified_at
    from source                
)

select * from renamed

