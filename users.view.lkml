view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0,10,30,80]
    style: integer
    sql: ${age} ;;
  }

  dimension: is_over_age_18 {
    type: yesno
    sql: ${age}>18 ;;
  }

  dimension: is_from_usa {
    type: yesno
    sql: ${country}= 'USA' ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name} || ' ' || ${last_name} ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  dimension: full_name {
    type: string
    sql: ${first_name}|| ' ' || ${last_name} ;;
  }

  dimension: is_over_age_18 {
    type: yesno
    sql: ${age}>18 ;;
  }

  dimension: is_user_from_USA{
    type: yesno
    sql: ${country}='USA' ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0,10,25,50]
    style: integer
    sql: ${age}  ;;
  }

measure: count_female {
  type: count
  filters: {
    field: gender
    value: "Female"
  }
  drill_fields: [age]
}

  measure: count {
    type: count
    drill_fields: [id, full_name, state, zip]
  }

  measure: count_female {
    type: count
    filters: {
      field: gender
      value: "Female"
    }
    drill_fields: [id, full_name, city, state, zip]
  }
}
