with

source as (

    select * from {{ source('sales', 'SalesOrderHeader') }}

),

renamed as (

    select
        -- chaves
        SalesOrderID                         as order_id,
        CustomerID                           as customer_id,
        SalesPersonID                        as salesperson_id,
        TerritoryID                          as territory_id,

        -- datas
        cast(OrderDate as date)              as order_date,
        cast(DueDate as date)                as due_date,
        cast(ShipDate as date)               as ship_date,

        -- status
        Status                               as status_code,
        case Status
            when 1 then 'in_process'
            when 2 then 'approved'
            when 3 then 'backordered'
            when 4 then 'rejected'
            when 5 then 'shipped'
            when 6 then 'cancelled'
        end                                  as status,
        OnlineOrderFlag                      as is_online_order,

        -- valores
        cast(SubTotal as decimal(19, 4))     as subtotal_amount,
        cast(TaxAmt as decimal(19, 4))       as tax_amount,
        cast(Freight as decimal(19, 4))      as freight_amount,
        cast(TotalDue as decimal(19, 4))     as total_due_amount,

        -- controle
        ModifiedDate                         as modified_at

    from source

)

select * from renamed