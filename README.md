Concept: Transforming raw data into a more usable and consistent format.

Steps:

1) Remove Duplicates: Identifying and eliminating redundant rows, often using ROW_NUMBER() with PARTITION BY across all relevant columns and inserting into a staging table for deletion.

2) Standardize Data: Fixing inconsistencies like spelling variations, casing, or extra spaces (e.g., using TRIM() for whitespace, UPPER()/LOWER() for casing, REPLACE() or LIKE with UPDATE for content variations like "crypto" vs. "cryptocurrency" or removing trailing periods).

3) Handle Null/Blank Values: Identifying and deciding whether to populate (e.g., based on other rows for the same company using self-joins) or remove missing data.

4) Remove Unnecessary Columns/Rows: Dropping irrelevant columns (ALTER TABLE ... DROP COLUMN) or rows that provide no useful information for analysis.

Staging Tables: The importance of creating copies of raw data (staging tables) to work on, preserving the original data.
Date Conversion: Using STRING_TO_DATE() to convert text dates to a proper DATE data type for time-series analysis and ALTER TABLE ... MODIFY COLUMN to change the column's data type.
