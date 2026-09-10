# Kimia Farma Business Performance Analytics (2020–2023)

This repository contains the final task submission for the **Big Data Analyst Virtual Internship Experience (VIX) — Kimia Farma x Rakamin Academy**. The project evaluates Kimia Farma's business performance from 2020 to 2023 using **Google BigQuery** for data processing and **Google Looker Studio** for dashboard visualization.

## 📌 About the Project

As a Big Data Analytics Intern at Kimia Farma, the scope of this project includes:
1. Importing 4 raw datasets into Google BigQuery.
2. Joining and aggregating the four datasets into a single analysis table (`tabel_analisa`).
3. Building an interactive Performance Analytics dashboard in Google Looker Studio based on that analysis table.
4. Drawing key insights and business recommendations from the results.

## 📂 Repository Structure

```
├── Dataset/
│   ├── kf_final_transaction.zip
│   ├── kf_inventory.zip
│   ├── kf_kantor_cabang.zip
│   └── kf_product.csv
├── Query/
│   └── Google Big Query Final.sql
└── README.md
```

## 🗂️ Dataset Overview

| Dataset | Columns |
|---|---|
| **kf_final_transaction** | `transaction_id`, `product_id`, `branch_id`, `customer_name`, `date`, `price`, `discount_percentage`, `rating` (transaction rating) |
| **kf_product** | `product_id`, `product_name`, `product_category`, `price` |
| **kf_inventory** | `inventory_ID`, `branch_id`, `product_id`, `product_name`, `opname_stock` |
| **kf_kantor_cabang** | `branch_id`, `branch_category`, `branch_name`, `kota` (city), `provinsi` (province), `rating` (branch rating) |

All four datasets were imported into BigQuery as separate tables under the `kimia_farma` dataset (project `rakamin-kf-analytics-508013`), and then combined into a single aggregated table called **`tabel_analisa`**.

## 🔎 Analysis Table (`tabel_analisa`)

This table is built using the query in [`Google Big Query Final.sql`](https://github.com/afifahnuraaini/Kimia-Farma-Big-Data-Analytics-Project/blob/main/Query/Google%20Big%20Query%20Final.sql).

**How the join works:**

- `kf_final_transaction` → base/fact table (1 row = 1 transaction)
- `LEFT JOIN kf_kantor_cabang` on `branch_id` → adds `branch_name`, `kota`, `provinsi`, `rating_cabang`
- `LEFT JOIN kf_product` on `product_id` → adds `product_name`
- `kf_inventory` is **not used** — different grain (stock per branch/product) and not needed for the required columns
- `LEFT JOIN` is used so no transaction gets dropped even if a match is missing

**Row count:** same as `kf_final_transaction` → **672,458 rows** (matches the "Jumlah Transaksi" scorecard on the dashboard).

## 📊 Dashboard — Kimia Farma Performance Analytics 2020–2023

The dashboard was built in Google Looker Studio, connected directly to `tabel_analisa` in BigQuery. It includes:

- **Dashboard Title** — Kimia Farma Performance Analytics 2020–2023, with a "last updated" date indicator.
- **Filter Controls** — interactive filters by date range, province, city, and branch name.
- **Summary Scorecards** — Total Nett Sales, Total Nett Profit, Total Transactions, and average Transaction Rating, each with a percentage-change indicator.
- **Revenue per Year** — a line chart showing the `nett_sales` trend from 2020 to 2023.
- **Top 10 Total Transactions by Province** — bar chart of the 10 provinces with the highest transaction counts.
- **Top 10 Nett Sales by Province** — bar chart of the 10 provinces with the highest nett sales.
- **Top 5 Branches with Highest Branch Rating but Lowest Transaction Rating** — a table highlighting the gap between overall branch perception and actual customer transaction experience.
- **Geo Map of Total Profit by Province** — a map showing the distribution of total nett profit across Indonesian provinces.
- **Transaction Rating Distribution** — a donut chart showing the proportion of customer transaction ratings.
- **Snapshot Data (Latest)** — a detailed, paginated table of the most recent transactions (transaction ID, date, branch, product, customer, nett sales, nett profit).

🔗 **Looker Studio Dashboard Link:** *[https://datastudio.google.com/reporting/038072fe-077d-4b73-a682-1eb7a70a5c56]*

## 💡 Key Insights

- **West Java (Jawa Barat)** consistently leads in both number of transactions and nett sales, far ahead of other provinces — indicating a strong market concentration in this region.
- Revenue (`nett_sales`) declined from 2020 to 2021, rose significantly in 2022, then slightly dipped again in 2023 — suggesting business growth has not yet stabilized post-2021.
- Several branches show a **high branch rating (>4.7)** but a **lower transaction rating (~3.99–4)** — e.g. branches in Pematangsiantar, Sorong, and Cilacap — indicating a gap between the branch's overall reputation and the customer's actual transaction experience.
- The majority of transaction ratings (54.8%) fall outside the main rating categories shown, indicating a fairly varied rating distribution that would benefit from further breakdown.
- Total profit is still geographically concentrated in a few provinces, suggesting an opportunity for expansion or stronger marketing efforts in provinces with lower profit contribution.


## 🛠️ Tools Used

- **Google BigQuery** — data storage and processing (joins & aggregation)
- **Google Looker Studio** — interactive visualization and dashboard
- **GitHub** — documentation and query storage

## 👩‍💻 Author

**Afifah NurAini Majid**

Big Data Analyst Virtual Internship Experience — Kimia Farma x Rakamin Academy
