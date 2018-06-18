view: post_filters {
  sql_table_name: david_barr.post_filters ;;

  dimension: post_id {
    type: string
    sql: ${TABLE}.post_id ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: taxonomy {
    type: string
    sql: ${TABLE}.taxonomy ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
