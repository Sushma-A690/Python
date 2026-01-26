## Data Types

* **Structured data**: Organized in rows and columns (tables). Example: SQL tables.
* **Semi-structured data**: Has structure but not strictly tabular. Example: JSON, XML, logs.
* **Unstructured data**: No predefined structure. Example: videos, images, PDFs, text files.

---

## Database Basics

* A **database** is a collection of processed and organized data, usually stored in **tabular format**.
* Databases are created and stored on a **server** (local or remote).
* Example: **MySQL Server** runs on a system and occupies disk space to store databases and tables.

### Database Server

* Acts as a **storage system**.
* Manages data persistence, security, transactions, and performance.

### Workbench

* A **client tool** used to access the database server.
* Used for **read and write operations** (running SQL queries).

### SQL (Structured Query Language)

* Used to **access and manipulate structured data** stored on a database server.

---

## Database Hierarchy

```
Server
 └── Database
      └── Schema
           └── Tables
```

* This entire setup is managed by a **Database Management System (DBMS)** (e.g., MySQL, PostgreSQL).

### Schema

* Defines the **structure and format of tables**.
* Acts as a logical container inside a database.

---

## SQL Language Categories

### DDL – Data Definition Language

Used to define or modify database structures.

* `CREATE`
* `ALTER`
* `DROP`
* `TRUNCATE`
* `RENAME`
* `COMMENT`

### DML – Data Manipulation Language

Used to manipulate data inside tables.

* `INSERT`
* `UPDATE`
* `DELETE`

### DQL – Data Query Language

Used to retrieve data.

* `SELECT`

### DCL – Data Control Language

Used for access control.

* `GRANT`
* `REVOKE`

### TCL – Transaction Control Language

Used to manage transactions.

* `COMMIT`
* `ROLLBACK`
* `SAVEPOINT`
* `BEGIN TRANSACTION`
* `SET TRANSACTION`
* Triggers are often associated with transactional behavior

---

## Database and Table Creation

```sql
CREATE DATABASE company_db;
```

```sql
CREATE TABLE company_db.test_table (
  id INT,
  name VARCHAR(100)
);
```

---

## Common SQL Operations

* `INSERT` – Add data into a table
* `SELECT` – Retrieve data
* `ALTER` – Modify table structure

  * Add column
  * Rename column
* `DROP TABLE` – Delete a table completely

> **Note:** SQL queries can be written in any order, but **execution order** determines the result.

---

## Drop Table Safely

```sql
DROP TABLE IF EXISTS company_db.persons;
```

* Prevents errors if the table does not exist (important in production).

---

## Create Table with Constraints

```sql
CREATE TABLE company_db.persons (
  ID INT NOT NULL UNIQUE,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT
);
```

```sql
SELECT * FROM company_db.persons;
```

---

## Insert Data Examples

```sql
INSERT INTO company_db.persons (ID, LastName, FirstName, Age)
VALUES (1, 'SA', 'JH', 38);
```

```sql
INSERT INTO company_db.persons (ID, LastName, FirstName, Age)
VALUES (1, 'JA', NULL, NULL); -- Fails (ID must be unique)
```

```sql
INSERT INTO company_db.persons (ID, LastName, FirstName, Age)
VALUES (1, NULL, 'SK', NULL); -- Fails (LastName cannot be NULL)
```

---

## Keys

### Primary Key

* Uniquely identifies each row in a table.
* Cannot be `NULL` or duplicate.

```sql
ALTER TABLE company_db.persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID); ---What changed internally
Before
ID had a UNIQUE constraint
Table had no primary key

After
ID is now the PRIMARY KEY
The old UNIQUE constraint is removed automatically
MySQL creates a clustered index on ID (InnoDB)
```

### Foreign Key

* Used to link tables.
* References the **primary key** of another table.

**Parent table**: Referenced table (Primary Key)

**Child table**: Referencing table (Foreign Key)

---

## Viewing Constraints

```sql
SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_SCHEMA = 'company_db';
```

---

## IF EXISTS (Production Safety)

* Prevents execution failure when an object already exists or does not exist.
* Similar concept to **try–catch** in Python.

---

## Foreign Key Actions

### ON DELETE RESTRICT

* Prevents deleting a primary key if it is referenced in a child table.
* Child records must be deleted first.

### ON UPDATE CASCADE

* Updates foreign key values automatically when the primary key changes.

---

## Constraints Summary

* `NOT NULL`
* `UNIQUE`
* `PRIMARY KEY`
* `FOREIGN KEY`
* `CHECK`
* `DEFAULT`

---

## DELETE vs TRUNCATE vs DROP

* **DELETE**

  * Removes specific rows using `WHERE` clause
  * Can be rolled back

* **TRUNCATE**

  * Removes all data
  * Table structure remains
  * Faster, cannot be rolled back

* **DROP**

  * Deletes the entire table (structure + data)

---

## Safe Update Mode (MySQL)

```sql
SET SQL_SAFE_UPDATES = 0;
```

* Disables safe mode
* Allows `DELETE` or `UPDATE` without a `WHERE` clause

(Default value is `1` – enabled)

---

## Key Scope

* **Primary Key** and **Foreign Key** are applied at the **table level**, not at the database level.

---

## Cardinality

* Represents the **uniqueness of data** in a column.
* Also describes relationships between tables:

  * One-to-One
  * One-to-Many
  * Many-to-Many

    ---------
SELECT CONSTRAINT_NAME
FROM information_schema.TABLE_CONSTRAINTS

WHERE TABLE_SCHEMA = 'company_db' ---to know the constrainsts used 

Even when SQL_SAFE_UPDATES = 1 (safe mode is ON), MySQL still allows DELETE operations if the WHERE clause uses an indexed (KEY) column, such as a PRIMARY KEY. Safe mode is designed to prevent accidental mass deletions, not to block all DELETE statements.

To delete records using non-indexed columns, safe mode must be turned OFF using SET SQL_SAFE_UPDATES = 0, or the query must include a LIMIT clause or an indexed condition.

The SHOW CREATE TABLE and SHOW INDEX commands help identify PRIMARY KEY, UNIQUE, and other indexed columns in a table, which are treated as KEY columns by MySQL.

example ** SHOW CREATE TABLE company_db.Persons;
SHOW INDEX FROM company_db.Persons;**

We can use **DROP INDEX ID ON persons; **to remove a redundant index on the ID column in the persons table when it has multiple indexes.

**TRUNCATE**
SET FOREIGN_KEY_CHECKS = 1 means MySQL enforces foreign key constraints. When this is enabled, you cannot DELETE or TRUNCATE a parent table if it is referenced by a child table, because doing so would break referential integrity.

TRUNCATE therefore does not apply to a parent table that is referenced by a child table when foreign key checks are ON.

If we still need to delete or truncate the parent table, we must temporarily disable foreign key checks using:

SET FOREIGN_KEY_CHECKS = 0;

To verify the current status of foreign key checks, we use:

SELECT @@FOREIGN_KEY_CHECKS;

A value of 1 means foreign key constraints are enforced, and a value of 0 means they are temporarily disabled.

**SQL_SAFE_UPDATES** prevents accidental mass updates or deletes. It allows safe, targeted operations on specific records using a key or indexed column. For intentional mass updates or deletes, the operation will fail unless you temporarily set SQL_SAFE_UPDATES = 0.
