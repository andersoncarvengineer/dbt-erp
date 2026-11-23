with

source as (

    select * from {{ source('sales', 'Customer') }}
),

renamed as (

    select
        CustomerID          as customer_id,
        PersonID            as person_id,
        StoreID             as store_id,
        TerritoryID         as territory_id,
        AccountNumber       as account_number,
        ModifiedDate        as modified_at
    from source
)



select * from renamed




