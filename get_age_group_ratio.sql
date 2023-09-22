CREATE OR REPLACE FUNCTION age_group_ratio(p_age_group CHAR(1))
  RETURNS NUMERIC AS
$$
DECLARE
  total_count INTEGER;
  matching_count INTEGER;
  percentage NUMERIC;
BEGIN
  SELECT COUNT(*) INTO total_count FROM Products;
  SELECT COUNT(*) INTO matching_count FROM Products WHERE age_group = p_age_group;
 
  percentage := (matching_count / total_count) * 100;
  RETURN percentage;
END;
$$
LANGUAGE plpgsql;