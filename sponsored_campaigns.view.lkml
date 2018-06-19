view: sponsored_campaigns {
  derived_table: {
    sql:
WITH campaign_stats as (
SELECT
  x.slug,
  sum(pv.web_page_views) + sum(pv.ios_page_views) + sum(pv.droid_page_views) as total_views,
  sum(pv.web_page_visitors) + sum(pv.ios_visitors) + sum(pv.droid_visitors) as total_visitors
FROM
  events.david_barr.sponsored_postID x INNER JOIN events.matviews.page_views pv
    ON (x.post_id = pv.post_id)
GROUP BY 1)
SELECT
  scd.campaign_start,
  scd.campaignname,
  cs.total_views,
  cs.total_visitors,
  scd.total_components,
  scd.sponsored_posts,
  scd.sponsored_social_posts,
  scd.sponsored_emails,
  scd.sponsored_interstitials,
  scd.sponsored_pushes,
  scd.sponsored_link
FROM
  events.david_barr.sponsored_campaign_deets scd INNER JOIN campaign_stats cs
    ON (scd.campaignname = cs.slug)
ORDER BY 1 DESC
        ;;
  }


  dimension: campaign_start {
    type: date
    sql: ${TABLE}.campaign_start ;;
  }

  dimension: campaignname {
    type: string
    sql: ${TABLE}.campaignname ;;
  }

  measure: total_views {
    type: sum
    sql: ${TABLE}.total_views ;;
  }

  measure: total_visitors {
    type: sum
    sql: ${TABLE}.total_visitors ;;
  }

  measure: total_components {
    type: sum
    sql: ${TABLE}.total_componenets ;;
  }

  measure: sponsored_posts {
    type: sum
    sql: ${TABLE}.sponsored_posts ;;
  }

  measure: sponsored_social_posts {
    type: sum
    sql: ${TABLE}.sponsored_social_posts ;;
  }

  measure: sponsored_emails {
    type: sum
    sql: ${TABLE}.sponsored_emails ;;
  }

  measure: sponsored_interstitials {
    type: sum
    sql: ${TABLE}.sponsored_interstitials ;;
  }

  measure: sponsored_pushes {
    type: sum
    sql: ${TABLE}.sponsored_pushes ;;
  }

  measure: sponsored_link {
    type: sum
    sql: ${TABLE}.sponsored_link ;;
  }

  }
