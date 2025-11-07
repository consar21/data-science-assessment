SELECT
    it.investor_id,
    s.sector_name,
    ROUND(
        100.0 * SUM(it.no_of_shares)
        / SUM(SUM(it.no_of_shares)) OVER (PARTITION BY it.investor_id),
        2
    ) AS percentage
FROM investor_transactions AS it
JOIN sectors AS s
  ON s.sector_id = it.sector_id
GROUP BY it.investor_id, it.sector_id, s.sector_name
ORDER BY it.investor_id, percentage DESC, it.sector_id ASC;
