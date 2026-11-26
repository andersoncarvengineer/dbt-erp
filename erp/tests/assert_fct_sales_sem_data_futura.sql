-- Uma data no futuro empurra a janela do incremental para frente,
-- e nenhuma alteração real entra mais até o calendário alcançar essa data.
select
    order_detail_id,
    modified_at
from {{ ref('fct_sales') }}
where modified_at > dateadd(day, 1, getdate())