-- truncate table
-- load csv file to table

USE bronze;

TRUNCATE TABLE crm_cust_info;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataset/source_crm/cust_info.csv'
INTO TABLE crm_cust_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@cst_id, @cst_key, @cst_firstname, @cst_lastname, @cst_marital_status, @cst_gndr, @cst_create_date)
SET
  cst_id = NULLIF(@cst_id, ''),
  cst_key = NULLIF(@cst_key, ''),
  cst_firstname = NULLIF(@cst_firstname, ''),
  cst_lastname = NULLIF(@cst_lastname, ''),
  cst_marital_status = NULLIF(@cst_marital_status, ''),
  cst_gndr = NULLIF(@cst_gndr, ''),
  cst_create_date = IF(@cst_create_date = '', NULL, STR_TO_DATE(@cst_create_date, '%Y-%m-%d'))
;

TRUNCATE TABLE crm_prd_info;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataset/source_crm/prd_info.csv'
INTO TABLE crm_prd_info
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@prd_id, @prd_key, @prd_nm, @prd_cost, @prd_line, @prd_start_dt, @prd_end_dt)
SET
  prd_id = NULLIF(@prd_id, ''),
  prd_key = NULLIF(@prd_key, ''),
  prd_nm = NULLIF(@prd_nm, ''),
  prd_cost = NULLIF(@prd_cost, ''),
  prd_line = NULLIF(@prd_line, ''),
  prd_start_dt = IF(@prd_start_dt = '', NULL, STR_TO_DATE(@prd_start_dt, '%Y-%m-%d')),
  prd_end_dt = IF(@prd_end_dt = '', NULL, STR_TO_DATE(@prd_end_dt, '%Y-%m-%d'))
;

TRUNCATE TABLE crm_sales_details;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataset/source_crm/sales_details.csv'
INTO TABLE crm_sales_details
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@sls_ord_num, @sls_prd_key, @sls_cust_id, @sls_order_dt, @sls_ship_dt, @sls_due_dt, @sls_sales, @sls_quantity, @sls_price)
SET
  sls_ord_num = NULLIF(@sls_ord_num, ''),
  sls_prd_key = NULLIF(@sls_prd_key, ''),
  sls_cust_id = NULLIF(@sls_cust_id, ''),
  sls_order_dt = NULLIF(@sls_order_dt, ''),
  sls_ship_dt = NULLIF(@sls_ship_dt, ''),
  sls_due_dt = NULLIF(@sls_due_dt, ''),
  sls_sales = NULLIF(@sls_sales, ''),
  sls_quantity = NULLIF(@sls_quantity, ''),
  sls_price = IF(TRIM(@sls_price) REGEXP '^[0-9]+$', CAST(TRIM(@sls_price) AS UNSIGNED), NULL)
;

TRUNCATE TABLE erp_loc_a101;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataset/source_erp/LOC_A101.csv'
INTO TABLE erp_loc_a101
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@cid, @cntry)
SET
  cid = NULLIF(@cid, ''),
  cntry = NULLIF(@cntry, '')
;

TRUNCATE TABLE erp_cust_az12;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataset/source_erp/CUST_AZ12.csv'
INTO TABLE erp_cust_az12
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@cid, @bdate, @gen)
SET
  cid = NULLIF(@cid, ''),
  bdate = IF(@bdate = '', NULL, STR_TO_DATE(@bdate, '%Y-%m-%d')),
  gen = NULLIF(@gen, '')
;

TRUNCATE TABLE erp_px_cat_g1v2;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataset/source_erp/PX_CAT_G1V2.csv'
INTO TABLE erp_px_cat_g1v2
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@id, @cat, @subcat, @maintenance)
SET
  id = NULLIF(@id, ''),
  cat = NULLIF(@cat, ''),
  subcat = NULLIF(@subcat, ''),
  maintenance = NULLIF(@maintenance, '')
;
