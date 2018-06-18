view: post_performance {
 derived_table: {
  sql:
  WITH pviews as (
SELECT
  wp.id,
  wp.post_title,
  wp.post_date,
  wp.post_type,
  sum(pv.ios_page_views) as ios_views,
  sum(pv.ios_visitors) as ios_visitors,
  sum(pv.droid_page_views) as droid_views,
  sum(pv.droid_visitors) as droid_visitors,
  sum(pv.web_page_views) as web_views,
  sum(pv.web_page_visitors) as web_visitors,
  sum(pv.ios_page_views) + sum(pv.droid_page_views) + sum(pv.web_page_views) as total_views,
  sum(pv.ios_visitors) + sum(pv.droid_page_views) + sum(pv.web_page_visitors) as total_vistors
FROM events.wordpress.posts wp INNER JOIN events.matviews.page_views pv
    ON (wp.id = pv.post_id)
WHERE wp.post_type IN ('tip','post') and wp.post_date > '2017-01-01'
GROUP BY 1,2,3,4
ORDER BY 3 DESC ),
landings as (
SELECT
  map.post_id,
  sum(sa.entrances) as entrances,
  sum(sa.bounces) as bounces
FROM
  events.google_analytics.site_analytics sa  INNER JOIN events.google_analytics.vw_site_map map
    ON (sa.pagepath = map.pagepath and sa.view_id = map.view_id)
GROUP BY 1
HAVING min(sa.date) > '2017-01-01'
),
push as (
SELECT
  wp.id,
  wp.post_title,
  wp.post_date,
  wp.post_type,
  coalesce(sum(cps.total_delivered),0) as delivered_push,
  coalesce(sum(cps.total_opens),0) as opened_push
FROM events.wordpress.posts wp LEFT JOIN events.marketing.combined_push_stats cps
    ON (wp.id = cps.post_id)
WHERE wp.post_type IN ('tip','post')
GROUP BY 1,2,3,4
ORDER BY 3 DESC),
emails as (
WITH
email_clicks as (
SELECT
  cec.email_name,
  cec.platform,
  CASE WHEN cec.url like '%?%'
    THEN trim(trailing '/' from substring(cec.url,0,position('?' IN cec.url)))
    ELSE trim(trailing '/' from substring(cec.url,0,length(cec.url)))
    END AS linkURL,
  count(*) as clicks
FROM
  events.marketing.consolidated_email_clicks cec
WHERE cec.received_at > '2017-01-01'
GROUP BY 1,2,3
ORDER BY 4 desc)
SELECT
--  ec.email_name,
--  ec.platform,
  ppv.post_id,
  sum(ec.clicks) link_clicks
FROM
  email_clicks ec LEFT JOIN events.wordpress.post_permalink_vw ppv
    ON (ec.linkURL = ppv.permalink)
GROUP  BY 1),
fbook as (
SELECT
  wp.id,
  wp.post_title,
  wp.post_date,
  wp.post_type,
  count(distinct fbp.post_id) as fb_posts,
  sum(fbp.post_impressions) as impressions,
  sum(fbp.post_fan_reach) as reach,
  sum(fbp.post_consumptions_by_type_link_clicks) as link_clicks,
   sum(
     coalesce(fbp.shares,0) +
     coalesce(fbp.comments,0)  +
     coalesce(fbp.post_reactions_by_type_total_like,0) +
     coalesce(fbp.post_reactions_by_type_total_anger,0) +
     coalesce(fbp.post_reactions_by_type_total_haha,0) +
     coalesce(fbp.post_reactions_by_type_total_love,0) +
     coalesce(fbp.post_reactions_by_type_total_sorry,0) +
     coalesce(fbp.post_reactions_by_type_total_wow,0)
 ) as engagements
FROM
  events.wordpress.posts wp INNER JOIN events.facebookinsights.vw_map map
    ON (wp.id = map.post_id)
  LEFT JOIN
    events.facebookinsights.posts fbp
      ON (map.fb_post_id = fbp.post_id)
WHERE wp.post_type IN ('tip','post') and wp.post_date > '2017-01-01'
GROUP BY 1,2,3,4
ORDER BY 3 DESC
  )
SELECT
  pviews.id as post_id,
  pviews.post_type,
  pviews.post_date,
  pviews.post_title,
  pviews.total_views,
  pviews.total_vistors,
  pviews.web_views,
  pviews.droid_views,
  pviews.ios_views,
  push.delivered_push,
  push.opened_push,
  coalesce(landings.entrances,0) as entrances,
  coalesce(landings.bounces,0) as bounces,
  coalesce(emails.link_clicks,0) as email_link_clicks,
  coalesce(fbook.fb_posts,0) as fb_posts,
  coalesce(fbook.impressions,0) as fb_impressions,
  coalesce(fbook.reach,0) as fb_reach,
  coalesce(fbook.link_clicks,0) as fb_link_clicks,
  coalesce(fbook.engagements,0) as fb_engagements
FROM
  pviews LEFT JOIN push
    ON (pviews.id = push.id)
  LEFT JOIN emails
    ON (pviews.id = emails.post_id)
  LEFT JOIN fbook
    ON (pviews.id = fbook.id)
  LEFT JOIN landings
    ON (pviews.id = landings.post_id)
ORDER BY 3 desc;;
}

  measure: count {
  type: count
}

dimension_group: post_date {
  type: time
  sql: ${TABLE}.post_date ;;
}


dimension: post_id {
  type: string
  sql: ${TABLE}.post_id ;;
  }

dimension: post_type {
  type: string
  sql: ${TABLE}.post_type ;;
  }

dimension: post_title {
  type: string
  sql: ${TABLE}.post_title ;;
  }

measure:   total_views{
  type: sum
  sql: ${TABLE}.total_views ;;
}

measure:   total_visitors{
  type: sum
  sql: ${TABLE}.total_visitors ;;
}

measure:   web_views{
  type: sum
  sql: ${TABLE}.web_views ;;
}

measure:   droid_views{
  type: sum
  sql: ${TABLE}.droid_views ;;
}

measure:   ios_views{
  type: sum
  sql: ${TABLE}.ios_views ;;
}

measure:   entrances{
  type: sum
  sql: ${TABLE}.entrances ;;
}

measure:  bounces{
  type: sum
  sql: ${TABLE}.bounces ;;
}

measure:   delivered_push{
  type: sum
  sql: ${TABLE}.delivered_push ;;
}

measure:   opened_push{
  type: sum
  sql: ${TABLE}.opened_push ;;
}

measure:   email_link_clicks{
  type: sum
  sql: ${TABLE}.email_link_clicks ;;
}

measure:   fb_posts{
  type: sum
  sql: ${TABLE}.fb_posts ;;
}

measure:   fb_impressions{
  type: sum
  sql: ${TABLE}.fb_impressions ;;
}

measure:   fb_reach{
  type: sum
  sql: ${TABLE}.fb_reach ;;
}

measure:   fb_link_clicks{
  type: sum
  sql: ${TABLE}.fb_link_clicks ;;
}

measure:   fb_engagements{
  type: sum
  sql: ${TABLE}.fb_engagements ;;
}

  measure:   avg_fb_engagements{
    type: average
    sql: ${TABLE}.fb_engagements ;;
  }

  }
