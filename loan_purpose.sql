SELECT 
    purpose,
    COUNT(id) as total_loans_issued,
    ROUND(AVG(loan_amnt), 2) as avg_loan_size,
    ROUND((SUM(is_defaulted)::NUMERIC / COUNT(id)) * 100, 2) as default_rate_pct,
    -- Calculate a simplified risk-adjusted return proxy
    ROUND(AVG(int_rate) - ((SUM(is_defaulted)::NUMERIC / COUNT(id)) * 100), 2) as risk_adjusted_spread
FROM accepted_loans
GROUP BY purpose
HAVING COUNT(id) > 1000 -- filter out statistically insignificant edge cases
ORDER BY risk_adjusted_spread ASC;