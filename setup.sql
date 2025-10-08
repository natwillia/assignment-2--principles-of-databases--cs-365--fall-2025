DROP DATABASE IF EXISTS passwords;

CREATE DATABASE passwords;

USE passwords;

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('my secret passphrase', 512));
SET @init_vector = RANDOM_BYTES(16);

CREATE TABLE IF NOT EXISTS users (
  user_id     INT NOT NULL AUTO_INCREMENT,
  username    VARCHAR(100)     NOT NULL,
  first_name  VARCHAR(100)     NOT NULL,
  last_name   VARCHAR(100)     NOT NULL,
  email       VARCHAR(100)     NOT NULL,

  PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS websites (
  site_id    INT               NOT NULL AUTO_INCREMENT,
  site_name  VARCHAR(100)      NOT NULL,
  site_url   VARCHAR(255)      NOT NULL,

  PRIMARY KEY (site_id)
);

CREATE TABLE IF NOT EXISTS accounts (
  user_id      INT              NOT NULL,
  site_id      INT              NOT NULL,
  password     VARBINARY(512)   NOT NULL,
  comment      VARCHAR(255),
  time_stamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (user_id, site_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (site_id) REFERENCES websites(site_id)
);

INSERT INTO users (username, first_name, last_name, email)
VALUES
  ('eschands', 'Edward', 'Scissorhands', 'ed3@gmail.com'),
  ('fkrueger', 'Freddy', 'Krueger', 'fredkru10@gmail.com'),
  ('edrav', 'Eric', 'Draven', 'edraven321@gmail.com'),
  ('leslion', 'Lestat', 'Lioncourt', 'lestatlion@gmail.com'),
  ('ferbuell', 'Ferris', 'Bueller', 'fbueller80@gmail.com'),
  ('tval', 'Tiffany', 'Valentine', 'tiffvalen6@gmail.com'),
  ('waddams', 'Wednesday', 'Addams', 'wedadd@gmail.com'),
  ('evtreb', 'Evan', 'Treborn', 'evantre@gmail.com'),
  ('gnftz', 'Ginger', 'Fitzgerald', 'gingfitz@gmail.com'),
  ('mmfly', 'Marty', 'McFly', 'mcflymart@gmail.com');

INSERT INTO websites (site_name, site_url)
VALUES
  ('Ebay', 'https://www.ebay.com/'),
  ('MGM Plus', 'https://www.mgmplus.com/'),
  ('Letterboxd', 'https://letterboxd.com/'),
  ('Food Network', 'https://www.foodnetwork.com/'),
  ('Youtube', 'https://www.youtube.com/'),
  ('Starz', 'https://www.starz.com/'),
  ('Paramount Plus', 'https://www.paramountplus.com/'),
  ('HBO Max', 'https://play.hbomax.com/'),
  ('Poshmark', 'https://poshmark.com/'),
  ('ThredUp', 'https://www.thredup.com/');

INSERT INTO accounts (user_id, site_id, password, comment)
VALUES
  (1, 1, AES_ENCRYPT('ebaypass1', @key_str, @init_vector), 'Ebay login'),
  (2, 2, AES_ENCRYPT('mgmsecure', @key_str, @init_vector), 'MGM Plus subscription'),
  (3, 3, AES_ENCRYPT('letterboxd123', @key_str, @init_vector), 'Review movies'),
  (4, 4, AES_ENCRYPT('foodpass', @key_str, @init_vector), 'Recipe ideas'),
  (5, 5, AES_ENCRYPT('yt123', @key_str, @init_vector), 'YouTube login'),
  (6, 6, AES_ENCRYPT('starzwatch', @key_str, @init_vector), 'Starz login'),
  (7, 7, AES_ENCRYPT('paramountpw', @key_str, @init_vector), 'Paramount Plus login'),
  (8, 8, AES_ENCRYPT('hbomaxpw', @key_str, @init_vector), 'HBO Max login'),
  (9, 9, AES_ENCRYPT('poshstyle', @key_str, @init_vector), 'Poshmark closet'),
  (10, 10, AES_ENCRYPT('thredup123', @key_str, @init_vector), 'ThredUp resale');
