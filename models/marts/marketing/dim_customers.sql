select
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
    coalesce(orders.amount, 0) as lifetime_value

from {{ ref('stg_jaffle_shop__customers') }} as customers

left join {{ ref('stg_jaffle_shop__customer_orders') }} as customer_orders
using (customer_id)

left join (
    select
        customer_id,
        sum(amount) as amount
    from {{ ref('fct_orders') }}
    group by 1
) as orders
using (customer_id)