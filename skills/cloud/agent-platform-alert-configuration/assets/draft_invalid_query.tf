resource "google_monitoring_alert_policy" "draft_policy" {
  project      = var.project_id
  display_name = "Draft Policy"
  combiner     = "OR"
  conditions {
    display_name = "Draft Condition"
    condition_prometheus_query_language {
      query = "sum(rate(workload_googleapis_com:gen_ai_invoke_agent_duration_count[5y])) / sum(rate(workload_googleapis_com:gen_ai_invoke_agent_duration_count[5m]"
    }
  }
}
