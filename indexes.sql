CREATE INDEX index1 ON users USING hash (user_id); 
CREATE INDEX index2 ON products USING btree (order_date);