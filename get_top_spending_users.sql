-- This function select 10 users who has the highest spending during the past 30 days
CREATE OR REPLACE FUNCTION get_top_spending_users()
RETURNS TABLE (
    user_id varchar,
    user_name varchar,
    total_spending bigint
) AS $$
BEGIN
    RETURN QUERY
    SELECT users.user_id, users.user_name, tmp.total_spending
    FROM users
    JOIN (
    SELECT p.buyer_id, CAST(SUM(p.price) AS bigint) AS total_spending
    FROM products p
    WHERE p.order_date >= current_date - INTERVAL '1 month'
    GROUP BY buyer_id
    ORDER BY total_spending DESC
    ) AS tmp ON users.user_id = tmp.buyer_id
LIMIT 10;
END;
$$ LANGUAGE plpgsql;