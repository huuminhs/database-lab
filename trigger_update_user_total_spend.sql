-- This trigger updates the user's total_spend attribute 
-- whenever that user places an order.
CREATE OR REPLACE FUNCTION update_total_spend()
RETURNS TRIGGER AS $$
DECLARE
    x INTEGER;
BEGIN
    IF OLD.buyer_id IS NOT NULL THEN
        UPDATE users
        SET total_spend = total_spend - OLD.price * (100 - OLD.discount) / 100
        WHERE user_id = OLD.buyer_id;
    END IF;
    SELECT total_spend
    INTO x
    FROM users
    WHERE user_id = NEW.buyer_id;


    UPDATE users
    SET total_spend = total_spend + OLD.price * (100 -
        CASE
            WHEN x >= 1000000 AND x < 5000000 THEN 1
            WHEN x >= 5000000 AND x < 10000000 THEN 2
            WHEN x >= 10000000 THEN 3
            ELSE 0
        END
    ) / 100
    WHERE user_id = NEW.buyer_id;


    UPDATE products
    SET discount =
        CASE
            WHEN x >= 1000000 AND x < 5000000 THEN 1
            WHEN x >= 5000000 AND x < 10000000 THEN 2
            WHEN x >= 10000000 THEN 3
            ELSE 0
        END
    WHERE product_id = OLD.product_id;


    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER update_total_spend_trigger
BEFORE UPDATE OF buyer_id ON products
FOR EACH ROW
EXECUTE FUNCTION update_total_spend();