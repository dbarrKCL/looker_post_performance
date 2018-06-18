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

  dimension: droid_page_views {
    type: number
    sql: ${TABLE}.droid_page_views ;;
  }

  dimension: droid_visitors {
    type: number
    sql: ${TABLE}.droid_visitors ;;
  }

  dimension: ios_page_views {
    type: number
    sql: ${TABLE}.ios_page_views ;;
  }

  dimension: ios_visitors {
    type: number
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

  dimension: web_page_views {
    type: number
    sql: ${TABLE}.web_page_views ;;
  }

  dimension: web_page_visitors {
    type: number
    sql: ${TABLE}.web_page_visitors ;;
  }

  measure: count {
    type: count
    drill_fields: [post_name]
  }
}
