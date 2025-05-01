CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- ================================
-- USERS TABLE
-- ================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address TEXT,
    birth_date DATE
);

-- ================================
-- CATEGORIES TABLE
-- ================================
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

-- ================================
-- AUTHORS TABLE
-- ================================
CREATE TABLE IF NOT EXISTS authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ================================
-- BOOKS TABLE
-- ================================
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    category_id INT,
    price DECIMAL(8,2) DEFAULT 0.00,
    author_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE SET NULL,
    CHECK (price >= 0)
);

-- ================================
-- BORROW RECORDS TABLE
-- ================================
CREATE TABLE IF NOT EXISTS borrow_records (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    return_date DATE NULL,
    due_date DATE,
    status ENUM('Pending', 'Returned') DEFAULT 'Pending',
    fine_amount DECIMAL(8,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- ================================
-- BOOK COPIES TABLE
-- ================================
CREATE TABLE IF NOT EXISTS book_copies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    status ENUM('Available', 'Borrowed', 'Reserved') DEFAULT 'Available',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- ================================
-- RESERVATIONS TABLE
-- ================================
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Active', 'Cancelled', 'Completed') DEFAULT 'Active',
    UNIQUE (user_id, book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

-- ================================
-- PAYMENTS TABLE
-- ================================
CREATE TABLE IF NOT EXISTS payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_amount DECIMAL(8,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_type ENUM('Fine', 'Purchase') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE INDEX idx_borrow_user ON borrow_records(user_id);
CREATE INDEX idx_borrow_status ON borrow_records(status);
CREATE INDEX idx_reservation_status ON reservations(status);

-- ================================
-- SAMPLE DATA
-- ================================

-- Users
INSERT INTO users (name, email, phone, address, birth_date) VALUES
    ('Abdelrahman Sabry', 'abdosapry@gmail.com', '01054554554', '6th of October', '1998-07-11'),
    ('Ziad Ahmed', 'zyadelbahy@gmail.com', '01095195195', 'Fayoum', '2001-03-24'),
    ('Seif Eldeen Mohamed', 'seifmohamed@gmail.com', '01176476476', 'Giza', '2000-12-09'),
    ('Omar Khaled', 'omarkhaled@gmail.com', '01012345678', 'Cairo', '1997-05-17'),
    ('Nour Hanem', 'nourhanem@gmail.com', '01198765432', 'Alexandria', '2002-10-02'),
    ('Salma Adel', 'salmaadel@gmail.com', '01234567890', 'Aswan', '1999-09-28'),
    ('Mohamed Samir', 'msamir@gmail.com', '01299887766', 'Tanta', '1995-04-12'),
    ('Laila Mostafa', 'lailamostafa@gmail.com', '01033445566', 'Mansoura', '2000-06-22'),
    ('Karim Nabil', 'karimnabil@gmail.com', '01155667788', 'Hurghada', '1998-12-05'),
    ('Hana Tarek', 'hanatarek@gmail.com', '01211223344', 'Luxor', '2002-09-19'),
    ('Youssef Adel', 'youssefadel@gmail.com', '01077889900', 'Minya', '1994-03-15');

-- Categories
INSERT INTO categories (category_name) VALUES
    ('Classic Novel'),
    ('Romance'),
    ('Science'),
    ('Mystery'),
    ('Fantasy'),
    ('Biography'),
    ('History'),
    ('Technology'),
    ('Philosophy');

-- Authors
INSERT INTO authors (name) VALUES
    ('Jane Austen'),
    ('Agatha Christie'),
    ('Stephen Hawking'),
    ('J.K. Rowling'),
    ('George Orwell'),
    ('Yuval Noah Harari'),
    ('Albert Camus'),
    ('Isaac Asimov');

-- Books (using author_id)
INSERT INTO books (title, category_id, price, author_id) VALUES
    ('Pride and Prejudice', 1, 750, 1),
    ('Sense and Sensibility', 1, 750, 1),
    ('Harry Potter and the Sorcerer\'s Stone', 5, 500, 4),
    ('A Brief History of Time', 3, 600, 3),
    ('1984', 1, 680, 5),
    ('Homo Deus', 7, 820, 6),
    ('The Stranger', 8, 450, 7),
    ('Foundation', 3, 700, 8),
    ('Animal Farm', 1, 620, 5),
    ('Outliers', 6, 740, NULL),
    ('The Selfish Gene', 3, 560, NULL);

-- Book Copies
INSERT INTO book_copies (book_id, status) VALUES
    (1, 'Available'), (1, 'Borrowed'),
    (2, 'Available'), (2, 'Available'),
    (3, 'Available'), (3, 'Available'), (3, 'Borrowed'),
    (4, 'Available'), (4, 'Available'),
    (5, 'Available'), (5, 'Available');

-- Borrow Records
INSERT INTO borrow_records (user_id, book_id, borrow_date, due_date, return_date, status, fine_amount) VALUES
    (1, 1, '2025-04-01 10:00:00', '2025-04-10', '2025-04-11', 'Returned', 5.00),
    (2, 3, '2025-04-15 14:00:00', '2025-04-25', NULL, 'Pending', 0.00),
    (3, 5, '2025-03-10 09:00:00', '2025-03-20', '2025-03-18', 'Returned', 0.00),
    (4, 4, '2025-04-20 11:30:00', '2025-04-30', NULL, 'Pending', 0.00),
    (5, 2, '2025-04-05 16:00:00', '2025-04-15', '2025-04-20', 'Returned', 25.00);

-- Reservations
INSERT INTO reservations (user_id, book_id, reservation_date, status) VALUES
    (2, 3, '2025-04-26 12:00:00', 'Active'),
    (1, 4, '2025-04-20 08:30:00', 'Completed'),
    (5, 5, '2025-04-15 15:00:00', 'Cancelled'),
    (6, 1, '2025-04-29 13:45:00', 'Active');

-- Payments
INSERT INTO payments (user_id, payment_amount, payment_date, payment_type) VALUES
    (1, 5.00, '2025-04-12 09:00:00', 'Fine'),
    (5, 25.00, '2025-04-21 11:15:00', 'Fine'),
    (3, 1500.00, '2025-04-01 13:00:00', 'Purchase'),
    (4, 600.00, '2025-04-15 17:00:00', 'Purchase');
