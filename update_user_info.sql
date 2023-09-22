-- This function allows users to update some of their information
-- Usage: SELECT update_user_info('id1', 'James', 'example@email.com', NULL, NULL, NULL)
-- If a parameter is NULL, that attribute will not be updated

CREATE OR REPLACE FUNCTION update_user_info(
    p_user_id VARCHAR(50),
    p_user_name VARCHAR(50),
    p_email VARCHAR(50),
    p_phone VARCHAR(20),
    p_address VARCHAR(100)
) RETURNS BOOLEAN AS $$
BEGIN
    UPDATE Users
    SET
        user_name = COALESCE(p_user_name, user_name),
        Email = COALESCE(p_email, Email),
        Phone = COALESCE(p_phone, Phone),
        Address = COALESCE(p_address, Address)
    WHERE user_id = p_user_id;
   
    IF FOUND THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;