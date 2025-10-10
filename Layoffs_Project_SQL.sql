SELECT* ,

ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
FROM layoffs_staging;

with dup_cte as 
(
SELECT* ,

ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions ) as rown
FROM layoffs_staging
)

select*
from dup_cte
where rown > 1;

select*
from layoffs_staging
where company like 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `rown` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*
from layoffs_staging2;

INSERT INTO layoffs_staging2
select *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as rown
FROM layoffs_staging;

SET SQL_SAFE_UPDATES = 0;
delete 
from layoffs_staging2
where rown =2 ;
-- Standardization
 
select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
SET company = trim(company);

select distinct INDUSTRY
from layoffs_staging2;

update layoffs_staging2
set industry = 'Crypto'
WHERE INDUSTRY LIKE'Crypto%' ;

select distinct INDUSTRY
from layoffs_staging2;

select distinct country
from layoffs_staging2;

update layoffs_staging2
set country = 'United States'
WHERE country LIKE'%United States%' ;

select distinct country
from layoffs_staging2
order by 1;

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` DATE;


-- 1. Check data for a specific company
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- 2. Normalize blank industries to NULL
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- 3. Preview which industries can be updated
SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- 4. Update missing industries using known values
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;
  
  select *
  from layoffs_staging2




