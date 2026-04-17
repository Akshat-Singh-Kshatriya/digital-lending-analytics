WITH user_quartiles AS (
    SELECT 
        id,
        int_rate,
        is_defaulted,
        inc_to_installment_ratio,
        NTILE(4) OVER (ORDER BY inc_to_installment_ratio DESC) as affordability_quartile
    FROM accepted_loans
    WHERE inc_to_installment_ratio > 0 -- filter out zero-income edge cases
)
SELECT 
    affordability_quartile,
    MIN(inc_to_installment_ratio) as min_ratio_in_cohort,
    MAX(inc_to_installment_ratio) as max_ratio_in_cohort,
    COUNT(id) as total_users,
    ROUND(AVG(int_rate), 2) as avg_interest_rate,
    ROUND((SUM(is_defaulted)::NUMERIC / COUNT(id)) * 100, 2) as default_rate_pct
FROM user_quartiles
GROUP BY affordability_quartile
ORDER BY affordability_quartile;