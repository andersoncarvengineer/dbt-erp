{{ config(
    materialized='incremental',
    unique_key='order_detail_id',
    incremental_strategy='merge',
    on_schema_change='append_new_columns'
) }}

with

order_details as (
    select * from {{ ref('stg_sales__order_details') }}
),

orders as (
    select * from {{ ref('stg_sales__orders') }}
),

joined as (

    select
        -- chaves
        order_details.order_detail_id,
        order_details.order_id,
        orders.customer_id,
        order_details.product_id,

        -- datas e status do pedido
        orders.order_date,
        orders.status,
        orders.is_online_order,

        -- valores do item
        order_details.order_qty,
        order_details.unit_price,
        order_details.discount_rate,
        order_details.line_total_amount,

        -- controle: a linha muda quando o pedido ou o item mudam
        greatest(orders.modified_at, order_details.modified_at) as modified_at

    from order_details
    inner join orders on order_details.order_id = orders.order_id

)

select * from joined

{% if is_incremental() %}
where modified_at >= (
    select dateadd(day, -3, max(modified_at)) from {{ this }}
)
{% endif %}