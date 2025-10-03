# Apple Sales Analysis  

A data analytics project analyzing **600,000+ Apple sales transactions** across stores, products, categories, and warranty claims using **PostgreSQL**.  

This project demonstrates **end-to-end SQL analytics**, starting from database design to answering real-world business questions and deriving actionable insights.  

---

## 📊 Project Overview  

Apple Inc. is a global leader in technology products, but understanding **sales performance, customer behavior, and warranty claims** is key for business growth.  

This project simulates a real-world **Sales Analytics case study** by:  
- Designing a normalized relational schema for Apple sales.  
- Loading and querying **600k+ transaction records**.  
- Answering **20+ business questions** across sales, regions, and warranty claims.  
- Deriving **key insights** to support decision-making.  

---

## 📂 Dataset Information  

- **Size**: 600,000+ rows  
- **Features**:  
  - `store_id` → Apple store location  
  - `product_id`, `category` → Product and category details  
  - `date` → Transaction date  
  - `sales_amount` → Sale value  
  - `warranty_status` → Valid / Void  
- **Format**: CSV (imported into PostgreSQL)  

---

## 🏗️ Database Design  

A normalized relational schema was implemented:  

1. **stores**: Contains information about Apple retail stores.
   - `store_id`: Unique identifier for each store.
   - `store_name`: Name of the store.
   - `city`: City where the store is located.
   - `country`: Country of the store.

2. **category**: Holds product category information.
   - `category_id`: Unique identifier for each product category.
   - `category_name`: Name of the category.

3. **products**: Details about Apple products.
   - `product_id`: Unique identifier for each product.
   - `product_name`: Name of the product.
   - `category_id`: References the category table.
   - `launch_date`: Date when the product was launched.
   - `price`: Price of the product.

4. **sales**: Stores sales transactions.
   - `sale_id`: Unique identifier for each sale.
   - `sale_date`: Date of the sale.
   - `store_id`: References the store table.
   - `product_id`: References the product table.
   - `quantity`: Number of units sold.

5. **warranty**: Contains information about warranty claims.
   - `claim_id`: Unique identifier for each warranty claim.
   - `claim_date`: Date the claim was made.
   - `sale_id`: References the sales table.
   - `repair_status`: Status of the warranty claim (e.g., Paid Repaired, Warranty Void).

This structure ensures **data integrity** and supports efficient querying.  

---

## ❓ Business Questions Solved  

Some of the main questions addressed:  
1. Which **product categories** generate the most revenue?  
2. What is the **year-over-year (YoY) sales growth**?  
3. Which **regions and stores** perform best?  
4. What is the **percentage of warranty claims void**?  
5. Which products have the **highest repeat purchase rate**?  
6. How do **monthly trends** reflect seasonal demand?  

---

## 🚀 Key Insights  

- 📈 **49% average YoY growth** across Apple product categories.  
- 🏆 **iPhones** generated the highest revenue contribution.  
- 🛠️ **Warranty void rate: 24.26%**, highlighting potential after-sales service issues.  
- 🌍 Certain regions consistently outperform others in **sales per store**.  
- 🔎 Delivered **20+ actionable insights** supporting business decisions.  

---

## 🛠️ Tools & Technologies  

- **SQL (PostgreSQL)** → Core analysis and queries  
- **MS Excel** → Validation and quick data checks  
- **Power BI** → Data visualization (optional)  
- **Python (Pandas, Jupyter Notebook)** → Exploratory data analysis (if extended)  

---


👨‍💻 Author

Shivansh Srivastava

📧 Email: shivanshsrivastava42@gmail.com  
🔗 [LinkedIn](https://www.linkedin.com/in/shivansh-srivastava-118b1a1a4)  
🔗 [Portfolio](https://datascienceportfol.io/shivanshsrivastava)
