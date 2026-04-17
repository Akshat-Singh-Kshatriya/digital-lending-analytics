WITH total_applications AS (
    SELECT emp_length, COUNT(*) as application_count, 'Accepted' as status
    FROM accepted_loans
    GROUP BY emp_length
    UNION ALL
    SELECT emp_length, COUNT(*) as application_count, 'Rejected' as status
    FROM rejected_loans
    GROUP BY emp_length
),
aggregated_funnel AS (
    SELECT 
        emp_length,
        SUM(CASE WHEN status = 'Accepted' THEN application_count ELSE 0 END) as accepted_count,
        SUM(CASE WHEN status = 'Rejected' THEN application_count ELSE 0 END) as rejected_count,
        SUM(application_count) as total_demand
    FROM total_applications
    GROUP BY emp_length
)
SELECT 
    emp_length,
    accepted_count,
    rejected_count,
    total_demand,
    ROUND((accepted_count::NUMERIC / total_demand) * 100, 2) AS approval_rate_pct
FROM aggregated_funnel
ORDER BY approval_rate_pct DESC;