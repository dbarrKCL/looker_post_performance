view: page_views {
  sql_table_name: matviews.page_views ;;

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  measure: droid_page_views {
    type: sum
    sql: ${TABLE}.droid_page_views ;;
  }

  measure: droid_visitors {
    type: sum
    sql: ${TABLE}.droid_visitors ;;
  }

  measure: ios_page_views {
    type: sum
    sql: ${TABLE}.ios_page_views ;;
  }

  measure: ios_visitors {
    type: sum
    sql: ${TABLE}.ios_visitors ;;
  }

  dimension_group: post {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.post_date ;;
  }

  dimension: post_id {
    type: string
    sql: ${TABLE}.post_id ;;
  }

  dimension: post_name {
    type: string
    sql: ${TABLE}.post_name ;;
  }

  dimension: post_type {
    type: string
    sql: ${TABLE}.post_type ;;
  }

  measure: web_page_views {
    type: sum
    sql: ${TABLE}.web_page_views ;;
  }

  measure: web_page_visitors {
    type: sum
    sql: ${TABLE}.web_page_visitors ;;
  }

  measure: count {
    type: count
    drill_fields: [post_name]
  }
}
