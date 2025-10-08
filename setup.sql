DROP DATABASE IF EXISTS passwords;

CREATE DATABASE passwords;

USE passwords;

SET block_encryption_mode = 'aes-256-cbc';
SET @key_str = UNHEX(SHA2('my secret passphrase', 512));
SET @init_vector = RANDOM_BYTES(16);

CREATE TABLE IF NOT EXISTS users (
  user_id     INT NOT NULL AUTO_INCREMENT,
  first_name  VARCHAR(100)     NOT NULL,
  last_name   VARCHAR(100)     NOT NULL,
  username    VARCHAR(100)     NOT NULL,
  email       VARCHAR(100)     NOT NULL,

  PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS websites (
  site_id    INT               NOT NULL AUTO_INCREMENT,
  site_url   VARCHAR(255)      NOT NULL,
  site_name  VARCHAR(100)      NOT NULL,

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
