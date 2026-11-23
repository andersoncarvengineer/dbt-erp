with

source as (

    select * from {{ source('production', 'Product') }}
),

renamed as (

    select

        ProductID                               as product_id,
        Name                                    as product_name,
        ProductNumber                           as product_number,
        MakeFlag                                as is_manufactured,
        FinishedGoodsFlag                       as is_finished_good,              
        Color                                   as color,
        SafetyStockLevel                        as safety_stock_level,
        ReorderPoint                            as reorder_point,
        cast(StandardCost as decimal(19,4))     as standard_cost,
        cast(ListPrice as decimal(19,4))        as list_price,
        Size                                    as size,
        SizeUnitMeasureCode                     as size_unit_measure_code, 
        case WeightUnitMeasureCode
            when 'G'  then Weight / 1000.0
            when 'LB' then Weight * 0.45359237
        end                                     as weight_kg,
        DaysToManufacture                       as days_to_manufacture,
        trim(ProductLine)                       as product_line,
        trim(Class)                             as class,
        trim(Style)                             as style,
        ProductSubcategoryID                    as product_subcategory_id,  
        ProductModelID                          as product_model_id,
        cast(SellStartDate as date)             as sell_start_date,
        cast(SellEndDate as date)               as sell_end_date,
        cast(DiscontinuedDate as date)          as discontinued_date,
        ModifiedDate                            as modified_at
    from source
)


select * from renamed


