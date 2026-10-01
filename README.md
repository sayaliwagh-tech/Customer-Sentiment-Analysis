# Customer Sentiment Analysis

## 📌 Project Overview

Customer Sentiment Analysis is an end-to-end data analytics project that analyzes **25,000 customer reviews** to understand customer sentiment, ratings, complaints, issue resolution, response time, product categories, platforms, and regional patterns.

The project combines:

- Python for data analysis and sentiment analysis
- SQL for business-oriented data analysis
- Excel for pivot analysis and reporting
- Power BI for interactive dashboard development

The objective is to transform raw customer review data into meaningful insights that can support customer experience and business decision-making.

---

## 🎯 Business Problem

Businesses receive large amounts of customer feedback through reviews and complaints. Manually analyzing this feedback can make it difficult to identify:

- Overall customer sentiment
- Product categories with higher negative sentiment
- Platforms with higher negative-review rates
- Regional sentiment patterns
- Customer ratings
- Complaint patterns
- Issue resolution performance
- Response-time patterns

This project analyzes customer feedback from multiple perspectives to identify important patterns and present them through analytical reports and an interactive Power BI dashboard.

---

## 🎯 Project Objectives

The main objectives of this project are to:

1. Analyze overall customer sentiment.
2. Understand customer rating distribution.
3. Analyze sentiment across product categories.
4. Compare sentiment across different platforms.
5. Analyze regional sentiment patterns.
6. Analyze complaint registration patterns.
7. Examine issue resolution and response time.
8. Perform text-based sentiment analysis using VADER.
9. Compare existing sentiment labels with VADER predictions.
10. Build an interactive Power BI dashboard.
11. Generate business-oriented insights from customer feedback.

---

## 📊 Dataset

The dataset contains **25,000 customer reviews** and **13 columns**.

### Dataset Columns

| Column | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `gender` | Customer gender |
| `age_group` | Customer age group |
| `region` | Customer region |
| `product_category` | Product category |
| `purchase_channel` | Purchase channel |
| `platform` | Shopping platform |
| `customer_rating` | Customer rating from 1 to 5 |
| `review_text` | Customer review |
| `sentiment` | Existing sentiment label |
| `response_time_hours` | Response time in hours |
| `issue_resolved` | Whether the issue was resolved |
| `complaint_registered` | Whether a complaint was registered |

### Dataset Size

- **Total records:** 25,000
- **Total columns:** 13
- **Duplicate rows:** 0
- **Missing values:** 0
- **Purchase channel:** Online

---

# 🛠️ Tools & Technologies

## Python

Used for:

- Data loading
- Data cleaning
- Exploratory Data Analysis
- Statistical analysis
- Visualization
- Sentiment analysis
- VADER analysis

### Python Libraries

- Pandas
- NumPy
- Matplotlib
- NLTK / VADER
- Jupyter Notebook

---

## SQL

MySQL was used to perform:

- Aggregations
- GROUP BY analysis
- Filtering
- CASE statements
- CTEs
- Ranking
- Business-question analysis
- Sentiment analysis by category, platform, and region

---

## Excel

Microsoft Excel was used for:

- Pivot tables
- Summary analysis
- Category analysis
- Platform analysis
- Regional analysis
- KPI reporting
- Charts
- Dashboard preparation

---

## Power BI

Power BI was used to create an interactive dashboard containing:

- KPI cards
- Sentiment distribution
- Negative reviews by category
- Average rating by platform
- Regional sentiment analysis
- Slicers for filtering

---

# 🔄 Project Workflow

```text
Raw Customer Data
       ↓
Data Cleaning
       ↓
Exploratory Data Analysis
       ↓
Python Analysis
       ↓
SQL Business Analysis
       ↓
Excel Pivot Analysis
       ↓
Power BI Dashboard
       ↓
Business Insights