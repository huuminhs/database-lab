-- This function search for products whose names match given words.
-- This function is not case-sensitive 
CREATE OR REPLACE FUNCTION search_products(input_string text)
RETURNS TABLE (
    product_id INT,
    brand VARCHAR(50),
    price INT,
    category VARCHAR(20),
    color VARCHAR(20),
    product_size VARCHAR(3),
    age_group CHAR(1),
    approved BOOLEAN,
    buyer_id VARCHAR(50),
    mod_id VARCHAR(50),
    seller_id VARCHAR(50),
    product_name VARCHAR(100),
    create_date DATE,
    order_date DATE,
    discount SMALLINT
) AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM products
    WHERE LOWER(products.product_name) LIKE '%' || REPLACE(LOWER(input_string), ' ', '%') || '%' AND products.approved = TRUE;
END;
$$ LANGUAGE plpgsql;