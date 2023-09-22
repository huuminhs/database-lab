
CREATE TABLE Moderators
(
  mod_id VARCHAR(50) NOT NULL,
  mod_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (mod_id),
  UNIQUE (mod_id)
);


CREATE TABLE Users
(
  user_id VARCHAR(50) NOT NULL,
  user_name VARCHAR(50) NOT NULL,
  Email VARCHAR(50) NOT NULL,
  Phone VARCHAR(20) NOT NULL,
  Address VARCHAR(100) NOT NULL,
  total_spend INT DEFAULT 0,
  PRIMARY KEY (user_id),
  UNIQUE (user_id)
);


CREATE TABLE Products
(
  product_id INT GENERATED BY DEFAULT AS IDENTITY,
  Brand VARCHAR(50),
  Price INT NOT NULL,
  Category VARCHAR(20),
  Color VARCHAR(20),
  product_size VARCHAR(3),
  age_group CHAR(1),
  Approved BOOLEAN,
  buyer_id VARCHAR(50),
  mod_id VARCHAR(50),
  seller_id VARCHAR(50) NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  create_date DATE DEFAULT CURRENT_DATE NOT NULL,
  order_date DATE,
  discount SMALLINT,
  PRIMARY KEY (product_id),
  FOREIGN KEY (buyer_id) REFERENCES Users(user_id),
  FOREIGN KEY (mod_id) REFERENCES Moderators(mod_id),
  FOREIGN KEY (seller_id) REFERENCES Users(user_id),


  CONSTRAINT check_different_id CHECK (buyer_id <> seller_id), --ràng buộc buyer_id seller_id khác nhau


  CONSTRAINT check_approved -- ràng buộc approved
  CHECK (
    (Approved IS NULL AND mod_id IS NULL AND buyer_id IS NULL) OR
    (Approved = FALSE AND buyer_id IS NULL AND mod_id IS NOT NULL) OR
    (Approved = TRUE)
  ),


  CONSTRAINT check_product_size
  CHECK (
    product_size IN ('XS', 'S', 'M', 'L', 'XL', '2XL', '3XL')
  ), --ràng buộc về size


  CONSTRAINT check_age_group
  CHECK (
    age_group IN ('K', 'T', 'M', 'E')
  ) --ràng buộc về age_group


);