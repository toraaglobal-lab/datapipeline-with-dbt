
  create view "demo"."public"."stg_orders__dbt_tmp"
    
    
  as (
    select
  "ID" as order_id,
        "USER_ID" as customer_id,
        "ORDER_DATE" as order_date,
        "STATUS" as status 

from "demo"."public"."orders"
  );