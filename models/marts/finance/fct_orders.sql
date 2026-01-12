select
    orders.order_id,
    orders.customer_id,
    sum(payments.amount) as amount

from {{ ref('stg_jaffle_shop__orders') }} as orders

left join {{ ref('stg_stripe__payments') }} as payments
    on orders.order_id = payments.order_id
    
where payments.status = 'success'
group by 1, 2