-- 1: Create a new entry into the database
INSERT INTO users (username, first_name, last_name, email)
VALUES
  ('bwayne', 'Bruce', 'Wayne', 'bruce@batman.com');

INSERT INTO websites (site_name, site_url)
VALUES ('Batman News', 'https://batman-news.com/');

INSERT INTO accounts (user_id, site_id, password, comment)
VALUES (11, 11, AES_ENCRYPT('batdance123', @key_str, @init_vector),'News about myself, Batman');

-- 7: Remove a tuple based on a password
DELETE FROM accounts
WHERE password = AES_ENCRYPT('hbomaxpw', @key_str, @init_vector);
