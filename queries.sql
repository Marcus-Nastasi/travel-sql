--- create tables ---
CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    birth DATE NOT NULL
);

ALTER TABLE users MODIFY COLUMN email VARCHAR(255) UNIQUE NOT NULL;

CREATE TABLE destiny(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE reserve(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    id_user INTEGER NOT NULL,
    id_destiny INTEGER NOT NULL,
    reserve_date DATE NOT NULL,
    status VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_destiny) REFERENCES destiny(id)
);

--- user insertions ----
INSERT INTO users(name, email, birth) VALUES ('Jorge', 'jorges@gmail.com', '1990-05-12');
INSERT INTO users(name, email, birth) VALUES ('Megan', 'meg_love@gmail.com', '1998-09-21');
INSERT INTO users(name, email, birth) VALUES ('Nathan', 'nath.crazy@gmail.com', '2001-04-30');
INSERT INTO users(name, email, birth) VALUES ('Penelope', 'pen.chad@gmail.com', '1997-02-1');
INSERT INTO users(name, email, birth) VALUES ('Math', 'mathew_charm@gmail.com', '2003-03-15');
INSERT INTO users(name, email, birth) VALUES ('Marc', 'rlb@gmail.com', '2001-10-26');

--- destiny insertions ----
INSERT INTO destiny(name, description) VALUES ('Rio de Janeiro', 'Beautiful beach city in Brazil.');
INSERT INTO destiny(name, description) VALUES ('São Paulo', 'Business city in Brazil.');
INSERT INTO destiny(name, description) VALUES ('Curitiba', 'Cold city in Brazil.');
INSERT INTO destiny(name, description) VALUES ('Acre', 'No existent city in Brazil.');
INSERT INTO destiny(name, description) VALUES ('Amazonas', 'World\'s biggest rain forest.');

--- reserves insertions ----
INSERT INTO reserve(id_user, id_destiny, reserve_date, status) VALUES (2, 4, '2024-06-10', 'pending');
INSERT INTO reserve(id_user, id_destiny, reserve_date, status) VALUES (1, 3, '2024-05-26', 'confirmed');
INSERT INTO reserve(id_user, id_destiny, reserve_date, status) VALUES (3, 5, '2024-06-12', 'canceled');
INSERT INTO reserve(id_user, id_destiny, reserve_date, status) VALUES (4, 2, '2024-07-01', 'confirmed');
INSERT INTO reserve(id_user, id_destiny, reserve_date, status) VALUES (5, 1, '2024-06-22', 'pending');
INSERT INTO reserve(id_user, id_destiny, reserve_date, status) VALUES (1, 2, '2024-06-22', 'pending');

--- JOINS ---
--- inner ---
SELECT * FROM users u INNER JOIN reserve r ON r.id_user = u.id;
SELECT * FROM users u INNER JOIN reserve r ON r.id_user = u.id INNER JOIN destiny d ON d.id = r.id_destiny;
SELECT * FROM reserve r INNER JOIN destiny d ON d.id = r.id_destiny;

--- left ---
SELECT * FROM users u LEFT JOIN reserve r ON r.id_user = u.id;

--- right ---
SELECT * FROM reserve r RIGHT JOIN users u ON u.id = r.id_user;
SELECT * FROM users u RIGHT JOIN reserve r ON r.id_user = u.id;

--- selects count ---
SELECT COUNT(id_user) FROM reserve;
SELECT id, name, (SELECT COUNT(*) FROM reserve r WHERE r.id_user = u.id) AS total_reserve FROM users u;

---
SELECT id, id_user, id_destiny, reserve_date, status,
(SELECT COUNT(*) FROM destiny d WHERE d.id = r.id_destiny)
AS total_destinys FROM reserve r;

SELECT DISTINCT id_user, (SELECT COUNT(*) FROM destiny d WHERE d.id = r.id_destiny) AS total_destinys FROM reserve r;
SELECT id, name, (SELECT COUNT(*) FROM reserve r WHERE r.id_user = u.id) AS total_reserves FROM users u;

---
SELECT id, name AS destiny, description,
(SELECT COUNT(*) FROM reserve r WHERE r.id_destiny = d.id)
AS total_reserves FROM destiny d;

---
SELECT name AS destiny, description,
(SELECT COUNT(*) FROM reserve r WHERE r.id_destiny = d.id)
AS total_reserves FROM destiny d ORDER BY d.id ASC;

---
SELECT name AS destiny, description,
(SELECT COUNT(*) FROM reserve r WHERE r.id_destiny = d.id)
AS total_reserves FROM destiny d ORDER BY total_reserve DESC;

SELECT DISTINCT u.id, u.name FROM users u INNER JOIN reserve r ON r.id_user = u.id;

---
SELECT u.id, u.name, r.id AS res_id, r.reserve_date
FROM users u
INNER JOIN reserve r ON r.id_user = u.id
ORDER BY r.id ASC;

---
SELECT d.id, d.name AS destiny, description, r.id, r.reserve_date FROM destiny d
INNER JOIN reserve r ON r.id_destiny = d.id
ORDER BY r.id ASC;

---
SELECT d.id AS id_destiny, (SELECT COUNT(*) FROM reserve r WHERE r.id_destiny = d.id) AS occurrences FROM destiny d;

--- selects generics ---
SELECT * FROM users WHERE id NOT IN (SELECT id_user FROM reserve);






