-- Remove a tuple based on a password
DELETE FROM accounts
  WHERE password = AES_ENCRYPT('hbomaxpw', @key_str, @init_vector);
