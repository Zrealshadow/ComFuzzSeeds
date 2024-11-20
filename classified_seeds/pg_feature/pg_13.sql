DO $$
BEGIN
CREATE TABLE customer_reviews(
    customer_id TEXT,
    review_date DATE,
    review_rating INTEGER,
    review_votes INTEGER,
    review_helpful_votes INTEGER,
    product_id CHAR(10),
    product_title TEXT,
    product_sales_rank BIGINT,
    product_group TEXT,
    product_category TEXT,
    product_subcategory TEXT,
    similar_product_ids CHAR(10)[]
);
FOR n in 2000..2004
LOOP
   EXECUTE 'CREATE TABLE customer_reviews_' || n || ' (check (review_date >= ''' || n || '-01-01'' AND review_date < ''' || n + 1 || '-01-01'')) INHERITS (customer_reviews) ;';
END LOOP;
END
$$ ;

CREATE OR REPLACE FUNCTION title_vs_review_sql(start_date DATE, end_date DATE)
RETURNS TABLE (
   title_length_bucket INTEGER,
   review_average NUMERIC,
   count BIGINT
) AS
$BODY$
SELECT
    width_bucket(length(product_title), 1, 50, 5) title_length_bucket,
    round(avg(review_rating), 2) AS review_average,
    count(*)
FROM
   customer_reviews
WHERE
    product_group = 'Book'
    AND
    review_date BETWEEN start_date AND end_date
GROUP BY
    title_length_bucket
ORDER BY
    title_length_bucket
$BODY$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION title_vs_review_plpgsql(start_date DATE, end_date DATE)
RETURNS TABLE (
   title_length_bucket INTEGER,
   review_average NUMERIC,
   count BIGINT
) AS
$BODY$
BEGIN
RETURN QUERY
        SELECT
            width_bucket(length(product_title), 1, 50, 5) title_length_bucket,
            round(avg(review_rating), 2) AS review_average,
            count(*)
        FROM
           customer_reviews
        WHERE
            product_group = 'Book'
            AND
            review_date BETWEEN start_date AND end_date
        GROUP BY
            title_length_bucket
        ORDER BY
            title_length_bucket;
END;
$BODY$
LANGUAGE PLPGSQL;

SET auto_explain.log_min_duration TO 0;
SET auto_explain.log_nested_statements TO TRUE;

SELECT title_vs_review_plpgsql('2001-01-01', '2001-12-31');
SELECT title_vs_review_sql('2001-01-01', '2001-12-31');
