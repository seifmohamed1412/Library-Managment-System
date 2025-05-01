# Library-Managment-System
Library Management System (Database)
This project is a Library Management System designed to manage the database for a library, utilizing a relational database structure to handle key functions like book management, user records, borrow/return operations, reservations, and payments. The system is structured with various tables representing users, books, authors, categories, borrow records, and more, to ensure seamless tracking of library activities.

Features:
Users Management: Store and manage user information including personal details, contact information, and membership status.

Books Management: Store and manage books with details such as title, author, category, price, and availability.

Categories and Authors: Categorize books into various genres like Fiction, Non-fiction, Science, History, and more. Track authors who contributed to the library collection.

Borrow Records: Keep track of borrow transactions, including borrow dates, return dates, due dates, and fines for late returns.

Reservations: Allow users to reserve books in advance, track the status of these reservations, and ensure the availability of books.

Payments and Fines: Manage payment records for fines or book purchases, ensuring users pay the correct amounts.

Book Copies: Manage the availability status of each individual copy of a book (e.g., Available, Borrowed, Reserved).

Database Schema:
The schema consists of several interrelated tables:

users – Stores user details.

categories – Defines book categories.

authors – Information about authors.

books – Contains book information with references to categories and authors.

borrow_records – Records borrowing details, including overdue fines.

reservations – Manages reservations made by users for books.

payments – Tracks payment history for fines and purchases.

book_copies – Manages individual book copy statuses (e.g., Available, Borrowed).

Sample Data:
The project includes sample data for users, books, borrow records, and reservations to simulate real-world library activities and facilitate testing and development.

Technology:
MySQL / MariaDB for database management.

SQL queries for data manipulation and transaction processing.

This project is perfect for understanding how a database-driven application can be used to manage various real-world operations within a library.
