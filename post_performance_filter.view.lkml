view: post_performance_filter {
    derived_table: {
      sql: SELECT
              ${post_performance.SQL_TABLE_NAME}.* ,
              post_filters.taxonomy,
              post_filters.slug
              FROM
                ${post_performance.SQL_TABLE_NAME}   INNER JOIN ${post_filters.SQL_TABLE_NAME}
                  ON ( post_performance.post_id = post_filters.post_id )
               ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: post_id {
      type: string
      sql: ${TABLE}.post_id ;;
    }

    dimension: post_type {
      type: string
      sql: ${TABLE}.post_type ;;
    }

    dimension_group: post_date {
      type: time
      sql: ${TABLE}.post_date ;;
    }

    dimension: post_title {
      type: string
      sql: ${TABLE}.post_title ;;
    }

    measure: total_views {
      type: average
      sql: ${TABLE}.total_views ;;
    }

    measure: total_vistors {
      type: average
      sql: ${TABLE}.total_vistors ;;
    }

    measure: web_views {
      type: average
      sql: ${TABLE}.web_views ;;
    }

    measure: droid_views {
      type: average
      sql: ${TABLE}.droid_views ;;
    }

    measure: ios_views {
      type: average
      sql: ${TABLE}.ios_views ;;
    }

    measure: delivered_push {
      type: average
      sql: ${TABLE}.delivered_push ;;
    }

    measure: opened_push {
      type: average
      sql: ${TABLE}.opened_push ;;
    }

    measure: entrances {
      type: average
      sql: ${TABLE}.entrances ;;
    }

    measure: bounces {
      type: average
      sql: ${TABLE}.bounces ;;
    }

    measure: email_link_clicks {
      type: average
      sql: ${TABLE}.email_link_clicks ;;
    }

    measure: fb_posts {
      type: average
      sql: ${TABLE}.fb_posts ;;
    }

    measure: fb_impressions {
      type: average
      sql: ${TABLE}.fb_impressions ;;
    }

    measure: fb_reach {
      type: average
      sql: ${TABLE}.fb_reach ;;
    }

    measure: fb_link_clicks {
      type: average
      sql: ${TABLE}.fb_link_clicks ;;
    }

    measure: fb_engagements {
      type: average
      sql: ${TABLE}.fb_engagements ;;
    }

    dimension: taxonomy {
      type: string
      sql: ${TABLE}.taxonomy ;;
    }

    dimension: slug {
      type: string
      sql: ${TABLE}.slug ;;
    }

    set: detail {
      fields: [
        post_id,
        post_type,
        post_date_time,
        post_title,
        total_views,
        total_vistors,
        web_views,
        droid_views,
        ios_views,
        delivered_push,
        opened_push,
        entrances,
        bounces,
        email_link_clicks,
        fb_posts,
        fb_impressions,
        fb_reach,
        fb_link_clicks,
        fb_engagements,
        taxonomy,
        slug
      ]
 }
}
