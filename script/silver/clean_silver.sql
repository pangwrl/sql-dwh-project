DROP PROCEDURE IF EXISTS silver.load_silver;

DELIMITER //
create procedure silver.load_silver()
begin

-- trim unwanted free space charecter
-- change gender parameter (standardization and fill missing value with n/a)
-- change marital status
-- select last create date record (remove duplicalte data)

truncate table silver.crm_cust_info;
insert into silver.crm_cust_info (
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
)
select 
cst_id,
cst_key,

 trim(cst_firstname) as cst_firtname,
 trim(cst_lastname) as cst_lastname,
 case 
	when upper(trim(cst_marital_status)) = 'S' then 'Single'
	when upper(trim(cst_marital_status)) = 'M' then 'Married'
    else 'n/a'
end as cst_marital_status,
case 
	when upper(trim(cst_gndr)) = 'F' then 'Female'
	when upper(trim(cst_gndr)) = 'M' then 'Male'
    else 'n/a'
end as cst_gndr,
 cst_create_date
from (
 select
 *,
 row_number() over (partition by cst_id order by cst_create_date desc) as flag_last
 from bronze.crm_cust_info
 where cst_id is not null
 ) t where flag_last = 1;
 
-- derive column cat_id from prd_key and replace '-' with '_'
-- derive column cat_id from prd_key
-- replace NULL prd_cost with 0
-- change prd_end_dt of previouse record with prd_start_dt of new record (enrichment)
-- change datetime to just date 
 
 truncate table silver.crm_prd_info;
 insert into silver.crm_prd_info (
	prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt 
 )
select 
prd_id,
replace(substring(prd_key, 1, 5), '-', '_') as cat_id,
substring(prd_key, 7, length(prd_key)) as prd_key,
prd_nm,
ifnull(prd_cost, 0) as prd_cost,
case 
	when upper(trim(prd_line)) = 'M' then 'Mountain'
	when upper(trim(prd_line)) = 'R' then 'Road'
    when upper(trim(prd_line)) = 'S' then 'Other Sales'
    when upper(trim(prd_line)) = 'T' then 'Touring'
    else 'n/a'
end prd_line,
cast(prd_start_dt as date) as prd_start_dt,
cast(lead(prd_start_dt) over (partition by prd_key order by prd_start_dt)-interval 1 day as date) as prd_end_dt
from bronze.crm_prd_info;

truncate table silver.crm_sales_details;
insert into silver.crm_sales_details (
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
select
sls_ord_num, 
sls_prd_key,
sls_cust_id,
case 
	when sls_order_dt =0 or length(sls_order_dt) !=8 then null
	else STR_TO_DATE(sls_order_dt, '%Y%m%d')
end as sls_order_dt,    
case 
	when sls_ship_dt =0 or length(sls_ship_dt) !=8 then null
	else STR_TO_DATE(sls_ship_dt, '%Y%m%d')
end as sls_ship_dt,
case 
	when sls_due_dt =0 or length(sls_due_dt) !=8 then null
	else STR_TO_DATE(sls_due_dt, '%Y%m%d')
end as sls_due_dt,
case 
	when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity * abs(sls_price) 
	then sls_quantity * abs(sls_price) 
    else sls_sales
end as sls_sales,
sls_quantity,
case 
	when sls_price is null or sls_price <=0 
	then sls_sales / nullif(sls_quantity,0)
    else sls_price
end as sls_price 
from 
bronze.crm_sales_details;

truncate table silver.erp_cust_az12;
insert into silver.erp_cust_az12 (
cid,
bdate,
gen
)
select
case 
	when cid like 'NAS%' then substring(cid, 4, length(cid))
	else cid
end as cid,
case 
	when bdate > curdate() then null
	else bdate
end as bdate,
CASE
  WHEN UPPER(TRIM(gen)) LIKE 'F%' THEN 'Female'
  WHEN UPPER(TRIM(gen)) LIKE 'M%' THEN 'Male'
  ELSE 'n/a'
END AS gen
from bronze.erp_cust_az12;

truncate table silver.erp_loc_a101;
insert into silver.erp_loc_a101(
cid,
cntry
)
select
replace(cid,'-','') as cid,
CASE
  WHEN UPPER(TRIM(cntry)) LIKE 'DE%' THEN 'Germany'
  WHEN UPPER(TRIM(cntry)) LIKE 'GERMANY%' THEN 'Germany'
  WHEN UPPER(TRIM(cntry)) LIKE 'US%' then 'United States'
  WHEN UPPER(TRIM(cntry)) LIKE 'AUS%' THEN 'Australia'
  WHEN UPPER(TRIM(cntry)) LIKE 'CAN%' then 'Canada'
  WHEN UPPER(TRIM(cntry)) LIKE 'UNITED KINGDOM%'THEN 'United Kingdom'
  WHEN UPPER(TRIM(cntry)) LIKE 'FRANCE%'THEN 'France'
  ELSE 'n/a'
END AS cntry
from bronze.erp_loc_a101;

truncate table silver.erp_px_cat_g1v2;
insert into silver.erp_px_cat_g1v2 (
id,
cat,
subcat,
maintenance
)
select
id,
cat,
subcat,
case 
	when maintenance like 'Yes%' then 'Yes'
	else maintenance
end as maintenance
from bronze.erp_px_cat_g1v2;
END //

DELIMITER ;