connection: "redshift"

# # include all the views
# include: "*.view"
#
# # include all the dashboards
# #include: "*.dashboard"
#
# datagroup: post_performance_default_datagroup {
#   # sql_trigger: SELECT MAX(id) FROM etl_log;;
#   max_cache_age: "1 hour"
# }
#
# persist_with: post_performance_default_datagroup
#
# explore: post_performance{
#   view_label: "post_performance"
#   label: "post_performance"
# }
#
# explore: post_filters{
#   view_label: "post_filters"
#   label: "post_filters"
# }
#
# explore: post_performance_filter{
#   view_label: "post_performance_filter"
#   label: "post_performance_filter"
# }
#
#
# explore: page_views{
#   view_label: "page_views"
#   label: "page_views"
# }
#
# explore: sponsored_campaigns {
#   view_label: "sponsored_campaigns"
#   label: "sponsored_campaigns"
# }
