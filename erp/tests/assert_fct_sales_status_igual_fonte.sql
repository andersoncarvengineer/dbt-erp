-- O fato é incremental e depende do ModifiedDate do ERP.
-- Se alguém alterar um pedido sem atualizar a data, o fato fica desatualizado.
-- Este teste compara o status do fato com o staging (que lê a fonte na hora).
select
    fct.order_detail_id,
    fct.order_id,
    fct.status   as status_no_fato,
    stg.status   as status_na_fonte
from {{ ref('fct_sales') }} as fct
inner join {{ ref('stg_sales__orders') }} as stg
    on fct.order_id = stg.order_id
where fct.status <> stg.status