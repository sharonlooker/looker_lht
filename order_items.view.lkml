view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

<<<<<<< HEAD
dimension: days_as_user {
  type: number
  sql: datediff('day',${users.created_date},${order_items.created_date}) ;;
}
=======
  dimension: days_as_user {
    type: number
    sql: datediff('day',${users.created_date},${order_items.created_date}) ;;
  }

>>>>>>> branch 'master' of git@github.com:sharonlooker/looker_lht.git
  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension: sale_price_tier {
    type: tier
    tiers: [0,50,100,500,1000]
    style: integer
    sql: ${sale_price} ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: total_sale_price {
    type: sum
<<<<<<< HEAD
    value_format_name: usd
    sql: ${sale_price} ;;
  }

  measure: running_total_sale_price{
    type: running_total
    sql: ${total_sale_price} ;;
  }
=======
    sql: ${sale_price} ;;
    value_format_name: usd
  }

  measure: running_total_sale_price {
    type: running_total
    sql: ${total_sale_price} ;;
    value_format_name: usd
  }

>>>>>>> branch 'master' of git@github.com:sharonlooker/looker_lht.git

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      users.id,
      users.first_name,
      users.last_name,
      inventory_items.id,
      inventory_items.product_name
    ]
  }
}
