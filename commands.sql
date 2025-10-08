-- 1: Create a new entry into the database
INSERT INTO users (username, first_name, last_name, email)
VALUES
  ('bwayne', 'Bruce', 'Wayne', 'bruce@batman.com');

INSERT INTO websites (site_name, site_url)
VALUES
  ('Batman News', 'https://batman-news.com/');

INSERT INTO accounts (user_id, site_id, password, comment)
VALUES
  (11, 11, AES_ENCRYPT('batdance123', @key_str, @init_vector),'News about myself, Batman');

-- 2: Get the password associated with the URL of one of your ten entries

-- Using CAST to ensure decrypted eBay password is readable
SELECT CAST(AES_DECRYPT(password, @key_str, @init_vector) AS CHAR) AS decrypted_password
FROM accounts
WHERE site_id = (
  SELECT site_id FROM websites WHERE site_url = 'https://www.ebay.com/');

-- 4: Change the Letterboxd URL associated with a password
UPDATE websites
SET site_url = 'https://letterboxd.com/journal/'
WHERE site_url = 'https://letterboxd.com/';

-- 5: Change the password to any entry
UPDATE accounts
SET password = AES_ENCRYPT('starzstar46', @key_str, @init_vector)
WHERE user_id = 6 AND site_id = 6;

-- 6: Remove a tuple based on a URL for food network
DELETE FROM accounts
WHERE site_id = (
  SELECT site_id FROM websites
  WHERE site_url = 'https://www.foodnetwork.com/');

-- 7: Remove a tuple based on a password for HBO Max
DELETE FROM accounts
WHERE password = AES_ENCRYPT('hbomaxpw', @key_str, @init_vector);
