# 🛒 Yanki Ecommerce Data Pipeline

Yanki Ecommerce is a data engineering project designed to extract, clean, and normalize transactional retail data for a fictional ecommerce platform. Starting with a raw CSV dataset, the project transforms it into structured relational tables and loads them into a PostgreSQL database using Python. The final schema supports queries for customer behavior, product insights, and payment tracking.

---

## 📌 Project Overview

This project builds a clean and normalized ecommerce database pipeline from scratch, covering:

✅ Extract raw ecommerce data from CSV  
✅ Clean and transform key entities using pandas  
✅ Split dataset into individual logical tables  
✅ Create PostgreSQL schema and insert transformed data  

---

## ⚙️ Technologies Used

 ⏺ Python (`pandas`, `csv`, `psycopg2`) — ETL and ingestion  
 ⏺ PostgreSQL — relational database setup  
 ⏺ SQL (`DDL`, `DML`) — schema design and inserts  

---

## 🔄 Full ETL Workflow

### 1. Data Extraction and Cleaning

- Read raw CSV file containing transaction data  
- Dropped incomplete records based on key columns  
- Converted `Order_Date` to datetime format  
- Extracted unique entities from the dataset:
  - `customers`
  - `products`
  - `shipping_address`
  - `orders`
  - `payment_method`  

- Saved each cleaned entity into a separate CSV for staging

### 2. PostgreSQL Schema Creation

- Created schema `yanki` using SQL DDL  
- Defined tables:
  - `customers`  
  - `products`  
  - `shipping_address`  
  - `orders`  
  - `payment_method`  

- Enforced data types, primary keys, and foreign key relationships across tables

### 3. Data Loading into PostgreSQL

- Wrote Python functions to load each CSV into its respective PostgreSQL table  
- Used `INSERT INTO` statements with placeholders via `psycopg2` 
- Handled primary key constraints and maintained referential integrity  
- Executed inserts efficiently and committed transaction batches  

---

## 📄 Results & Final Verification

✅ Cleaned and normalized retail dataset  
✅ Five well-structured relational tables created  
✅ PostgreSQL database successfully loaded  
✅ Queries supported for customer activity, order tracking, and payment analysis  

---

## 📝 Notes

 ⏺ Used UUIDs for unique identity columns across customers, products, and orders  
 ⏺ Applied pandas transformations to enforce clean schema formats  
 ⏺ Created reusable ingestion logic with conflict handling and modular inserts  
 ⏺ Database designed for future scaling with additional ecommerce metrics  
