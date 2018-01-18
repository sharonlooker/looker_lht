view: user_order_facts {
  derived_table: {
    sql:
      select
        users.id as user_id,
        count(order_items.id) as lifetime_order_items,
        sum(order_items.sale_price) as lifetime_value,
        min(order_items.created_at) as first_order,
        max(order_items.created_at) as last_order
      from users
      left join order_items on users.id = order_items.user_id
      group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: user_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: lifetime_order_items {
    type: number
    sql: ${TABLE}.lifetime_order_items ;;
  }

  dimension: lifetime_value {
    type: number
    sql: ${TABLE}.lifetime_value ;;
    value_format_name: usd
  }

  dimension_group: first_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.last_order ;;
  }

  set: detail {
    fields: [user_id, lifetime_order_items, lifetime_value, first_order_date, last_order_date]
  }
}
