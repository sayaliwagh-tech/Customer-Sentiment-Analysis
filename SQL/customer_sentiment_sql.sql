
CREATE DATABASE customer_sentiment_db;

USE customer_sentiment_db;

CREATE TABLE customer_reviews (
    customer_id VARCHAR(50),
    gender VARCHAR(20),
    age_group VARCHAR(20),
    region VARCHAR(50),
    product_category VARCHAR(100),
    purchase_channel VARCHAR(50),
    platform VARCHAR(100),
    customer_rating INT,
    review_text TEXT,
    sentiment VARCHAR(20),
    response_time_hours INT,
    issue_resolved VARCHAR(10),
    complaint_registered VARCHAR(10)
);


DESCRIBE customer_reviews;

SELECT COUNT(*) AS total_reviews
FROM customer_reviews;

-- 
SELECT * 
FROM customer_reviews
LIMIT 10;

-- Business Question

-- Q. What is the overall sentiment distribution?
SELECT sentiment, COUNT(*) AS review_count
FROM customer_reviews
GROUP BY sentiment
ORDER BY review_count DESC;

-- Calculate the percentage
SELECT 
	sentiment, 
	COUNT(*) AS review_count,
    ROUND(
		COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM customer_reviews),
        2
	) AS percentage
FROM customer_reviews
GROUP BY sentiment
ORDER BY review_count DESC;


-- Q. Which product categories have the most negative reviews?
SELECT
	product_category,
	COUNT(*) AS negative_reviews
FROM customer_reviews
WHERE sentiment = "negative"
GROUP BY product_category
ORDER BY negative_reviews DESC;

-- Calculate percentage
SELECT 
	product_category,
	COUNT(*) AS total_reviews,
    SUM(
		CASE WHEN sentiment = "negative" THEN 1 ELSE 0 END) AS negative_reviews,
	ROUND(
		SUM(CASE WHEN sentiment = "negative" THEN 1 ELSE 0 END)
		* 100.0 / COUNT(*),
		2
	) AS negative_rate
FROM customer_reviews
GROUP BY product_category
ORDER BY negative_rate DESC;

-- Q. Which platforms have the highest negative-review rate?
SELECT
	platform,
    COUNT(*) AS total_reviews,
    SUM(
		CASE WHEN sentiment = "negative" THEN 1 ELSE 0 END) AS negative_reviews,
	ROUND(
		SUM(CASE WHEN sentiment = "negative" THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
	)AS negative_rate
FROM customer_reviews
GROUP BY platform
ORDER BY negative_rate DESC;

-- Q. Which regions have the most negative-review rate?
SELECT
	region,
    COUNT(*) AS total_reviews,
    SUM(CASE
			WHEN sentiment = "negative" THEN 1
			ELSE 0
		END
	) AS negative_reviews,
    ROUND(
		SUM(
			CASE
				WHEN sentiment = "negative" THEN 1
                ELSE 0
			END
		) * 100.0 / COUNT(*),
        2
	) AS negative_rate
FROM customer_reviews
GROUP BY region
ORDER BY negative_rate DESC;

-- Q. WHICH PLATFORMS HAVE AN AVERAGE CUSTOMER RATING BELOW 3.0?
SELECT 
	platform,
    AVG(customer_rating) AS avg_rating
FROM customer_reviews
GROUP BY platform
HAVING AVG(customer_rating) < 3.0
ORDER BY avg_rating;

-- Q. ARE COMPLAINTS ASSOCIATED WITH NEGATIVE SENTIMENT?
SELECT 
	complaint_registered,
    sentiment,
	COUNT(*) AS review_count
FROM customer_reviews
GROUP BY complaint_registered, sentiment
ORDER BY complaint_registered, review_count DESC;

-- Q. Does issue resolution relate to sentiment?
SELECT
	issue_resolved,
    sentiment,
    COUNT(*) AS review_count
FROM customer_reviews
GROUP BY issue_resolved, sentiment
ORDER BY issue_resolved, sentiment;

-- Calculate Percentage
SELECT
    issue_resolved,
    sentiment,
    COUNT(*) AS review_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY issue_resolved),
        2
    ) AS percentage
FROM customer_reviews
GROUP BY issue_resolved, sentiment
ORDER BY issue_resolved, percentage DESC;

-- Q. Which issues take the longest to resolve?
SELECT 
	issue_resolved,
    COUNT(*) AS review_count,
    ROUND(AVG(response_time_hours), 2) AS avg_response_hours,
    MIN(response_time_hours) AS min_response_hours,
    MAX(response_time_hours) AS max_response_hours
FROM customer_reviews
GROUP BY issue_resolved
ORDER BY avg_response_hours DESC;

-- Q. Does response time differ by sentiment?
SELECT 
	sentiment,
    COUNT(*) AS review_count,
    ROUND(AVG(response_time_hours), 2) AS avg_response_hours,
    MIN(response_time_hours) AS min_response_hours,
    MAX(response_time_hours) AS max_response_hours
FROM customer_reviews
GROUP BY sentiment
ORDER BY avg_response_hours DESC;

-- Q. Which product categories have the highest average rating?
SELECT
	product_category,
    COUNT(*) AS total_reviews,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM customer_reviews
GROUP BY product_category
ORDER BY avg_rating DESC;


-- Q. WHICH PLATFORMS HAVE THE HIGHEST NUMBER OF NEGATIVE REVIEWS?
SELECT
	platform,
    COUNT(*) AS negative_reviews
FROM customer_reviews
WHERE sentiment = "negative"
GROUP BY platform
ORDER BY negative_reviews DESC;

-- Q. WHICH PLATFORMS HAVE THE HIGHEST NUMBER OF POSITIVE REVIEWS?
SELECT 
	platform,
    COUNT(*) AS positive_reviews
FROM customer_reviews
WHERE sentiment = "positive"
GROUP BY platform
ORDER BY positive_reviews DESC;

-- Q. WHICH PLATFORM HAS THE HIGHEST AVERAGE RATING?
SELECT 
	platform,
    COUNT(*) AS total_reviews,
    ROUND(AVG(customer_rating), 2) AS avg_rating
FROM customer_reviews
GROUP BY platform
ORDER BY avg_rating DESC;

-- Q. PLATFORM PERFORMANCE SUMMARY
SELECT
    platform,
    COUNT(*) AS total_reviews,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    SUM(
        CASE
            WHEN sentiment = 'negative' THEN 1
            ELSE 0
        END
    ) AS negative_reviews,
    ROUND(
        SUM(
            CASE
                WHEN sentiment = 'negative' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS negative_rate
FROM customer_reviews
GROUP BY platform
ORDER BY negative_rate DESC;

-- Q. FIND THE HIGHEST-RISK PLATFORMS USING SQL.
SELECT
    platform,
    COUNT(*) AS total_reviews,
    ROUND(AVG(customer_rating), 2) AS avg_rating,
    SUM(
        CASE
            WHEN sentiment = 'negative' THEN 1
            ELSE 0
        END
    ) AS negative_reviews,
    ROUND(
        SUM(
            CASE
                WHEN sentiment = 'negative' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS negative_rate
FROM customer_reviews
GROUP BY platform
HAVING AVG(customer_rating) < 3.0
   AND
   SUM(
       CASE
           WHEN sentiment = 'negative' THEN 1
           ELSE 0
       END
   ) * 100.0 / COUNT(*) > 40
ORDER BY negative_rate DESC;

-- Q. PLATFORM RANKING
WITH platform_metrics AS (
    SELECT
        platform,
        COUNT(*) AS total_reviews,
        ROUND(AVG(customer_rating), 2) AS avg_rating,
        SUM(
            CASE
                WHEN sentiment = 'negative' THEN 1
                ELSE 0
            END
        ) AS negative_reviews,
        ROUND(
            SUM(
                CASE
                    WHEN sentiment = 'negative' THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*),
            2
        ) AS negative_rate
    FROM customer_reviews
    GROUP BY platform
)

SELECT
    platform,
    total_reviews,
    avg_rating,
    negative_reviews,
    negative_rate,
    RANK() OVER (
        ORDER BY negative_rate DESC
    ) AS negative_rate_rank
FROM platform_metrics
ORDER BY negative_rate_rank;

-- Q. RANK PRODUCT CATEGORIES BY NEGATIVE-REVIEW RATE
 WITH category_metrics AS (
    SELECT
        product_category,
        COUNT(*) AS total_reviews,
        ROUND(AVG(customer_rating), 2) AS avg_rating,

        SUM(
            CASE
                WHEN sentiment = 'negative' THEN 1
                ELSE 0
            END
        ) AS negative_reviews,

        ROUND(
            SUM(
                CASE
                    WHEN sentiment = 'negative' THEN 1
                    ELSE 0
                END
            ) * 100.0 / COUNT(*),
            2
        ) AS negative_rate
    FROM customer_reviews
    GROUP BY product_category
)

SELECT
    product_category,
    total_reviews,
    avg_rating,
    negative_reviews,
    negative_rate,
    RANK() OVER (
        ORDER BY negative_rate DESC
    ) AS negative_rate_rank
FROM category_metrics
ORDER BY negative_rate_rank;


-- Q. Which age group has the highest negative-review rate?
SELECT
    age_group,
    COUNT(*) AS total_reviews,
    SUM(
        CASE
            WHEN sentiment = "negative" THEN 1
            ELSE 0
        END
    ) AS negative_reviews,
    ROUND(
        SUM(
            CASE
                WHEN sentiment = "negative" THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS negative_rate
FROM customer_reviews
GROUP BY age_group
ORDER BY negative_rate DESC;


-- Gender based sentiment analysis

-- Q. Which gender has the highest negative-review rate?

SELECT 
	gender,
    COUNT(*) AS total_reviews,
    SUM(
		CASE
			WHEN
				sentiment = "negative" THEN 1
                ELSE 0
			END
		) AS negative_reviews,
	ROUND(
		SUM(
			CASE
				WHEN
					sentiment = "negative" THEN 1
                    ELSE 0
				END
			) * 100.0 / COUNT(*),
		    2 
	) AS negative_rate
FROM customer_reviews
GROUP BY gender
ORDER BY  negative_rate DESC;


-- Response time by region

-- Q. Which region has the highest aveage response time?
SELECT
	region,
    COUNT(*) as total_reviews,
    ROUND(AVG(response_time_hours), 2) AS avg_response_hours,
    MIN(response_time_hours) AS min_response_hours,
    MAX(response_time_hours) AS max_response_hours
FROM customer_reviews
GROUP BY region
ORDER BY avg_response_hours DESC;

-- Q. For each product category, calculate its negative-review rate and assign a rank based on that rate. Also show the overall average negative-review rate across all categories.
WITH category_metrics AS (
SELECT
	product_category,
    COUNT(*) AS total_reviews,
    SUM(
		CASE
			WHEN 
				sentiment = "negative" THEN 1
                ELSE 0
			END
		) AS negative_reviews,
	Round(
		SUM(
			CASE
				WHEN 
					sentiment = "negative" THEN 1
                    ELSE 0
				END
			) * 100.0 /COUNT(*),
            2
		) AS negative_rate
	FROM customer_reviews
	GROUP BY product_category
)

SELECT
	product_category,
    total_reviews,
    negative_reviews,
    negative_rate,
    RANK() OVER(ORDER BY negative_rate DESC) AS negative_rate_rank,
    ROUND(
		AVG(negative_rate) OVER(),
        2
	) AS overall_avg_negative_rate
FROM category_metrics
ORDER BY negative_rate_rank;