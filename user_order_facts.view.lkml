view: user_order_facts {
  derived_table: {
    sql: select users.id as UserID,
      count(order_items.id) as LifeTimeOrders,
      sum(order_items.sale_price) as LifeTimeValue,
      min(order_items.created_at) as FirstOrder,
      max(order_items.created_at) as LastOrder
      from users
      left join order_items
      on users.id=order_items.user_id
      group by users.id
       ;;
      datagroup_trigger: 24_hour
      distribution_style: even
      sortkeys: ["userid"]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: userid {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.userid ;;
  }

  dimension: lifetimeorders {
    type: string
    sql: ${TABLE}.lifetimeorders ;;
  }

  dimension: lifetimevalue {
    type: number
    value_format_name: usd
    sql: ${TABLE}.lifetimevalue ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.firstorder ;;
  }

  dimension_group: last_order {
    type: time
    sql: ${TABLE}.lastorder ;;
  }

  set: detail {
    fields: [userid, lifetimeorders, lifetimevalue]
  }
}
