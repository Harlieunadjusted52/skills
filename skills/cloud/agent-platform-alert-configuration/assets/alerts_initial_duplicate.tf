resource "google_monitoring_alert_policy" "agent_error_rate_fast_burn" {
  project      = var.project_id
  display_name = "Agent Error Rate Fast Burn"
  combiner     = "OR"
  conditions {
    display_name = "Error Rate Fast Burn"
    condition_prometheus_query_language {
      query    = <<-EOT
        (
          sum(rate(workload_googleapis_com:gen_ai_invoke_agent_duration_count{error_type!="", gen_ai_agent_name="my-agent"}[5m]))
          /
          sum(rate(workload_googleapis_com:gen_ai_invoke_agent_duration_count{gen_ai_agent_name="my-agent"}[5m]))
          > (1 - var.slo_target) * 3
        )
      EOT
      duration = "300s"
    }
  }
}
