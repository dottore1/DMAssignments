/*
	This is a 
        multiline comment.
*/

-- this is a single line comment.

-- creating the initial accounts table
CREATE TABLE account(
   user_id serial PRIMARY KEY,
   username VARCHAR (50) UNIQUE NOT NULL,
   password VARCHAR (50) NOT NULL,
   email VARCHAR (355) UNIQUE NOT NULL,
   created_on TIMESTAMP NOT NULL,
   last_login TIMESTAMP
);

-- inserting two users
INSERT INTO account (username, password, email, created_on) 
VALUES ('John', 'myPassW0rd', 'john@acme.com', NOW());

INSERT INTO account (username, password, email, created_on) 
VALUES ('Anne', 'myPassW0rd', 'anne@acme.com', NOW());

-- querying for all rows in the account table
SELECT * FROM account;

-- updating the password of the user Anne
UPDATE account SET password = 'newPassW0rd' WHERE username = 'Anne';

-- showing the password has been changed
SELECT * FROM account;

-- querying for a specific user with a specific email
SELECT username, created_on FROM account WHERE email = 'john@acme.com';

-- querying for a user with an email that contains "anne"
SELECT username, created_on FROM account WHERE email LIKE '%anne%';

-- deleting the John user based on this email
DELETE FROM account WHERE email = 'john@acme.com';

-- confirming deletion of John's account
SELECT * FROM account;