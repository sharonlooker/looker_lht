connection: "events_ecommerce"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"
persist_with: 24_hour

datagroup: 24_hour {
  sql_trigger: select current_date  ;;
}

datagroup: new_users_add {
  sql_trigger: select count(*) from public.users ;;
}

explore: users {
  persist_with: new_users_add
  join: order_items {
    type: left_outer
    relationship: one_to_many
    sql_on: ${users.id} = ${order_items.user_id} ;;
  }

  join: inventory_items {
    type: left_outer
    relationship: many_to_one
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
  }

  join: products {
    type: left_outer
    relationship: many_to_one
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
  }

  join: user_order_facts {
    type: left_outer
    relationship: one_to_one
    sql_on: ${users.id} =${user_order_facts.user_id} ;;
  }

}


explore: order_items {
  join: users {
    type: inner
    relationship: many_to_one
    sql_on: ${users.id} = ${order_items.user_id} ;;

  }
}
