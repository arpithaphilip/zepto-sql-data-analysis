
ALTER TABLE zepto ADD sku_id INT IDENTITY(1,1);
ALTER TABLE zepto ADD CONSTRAINT pk_zepto_sku_id PRIMARY KEY (sku_id);
go


SELECT sku_id, name, category FROM zepto ORDER BY sku_id;

EXEC sp_help zepto;


--checking the null value

select * from zepto where
name is Null
or
Category is null
or
mrp is null
or 
discountedSellingPrice is null
or
availableQuantity is null
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null;

---diffrent product category

select distinct Category FROM zepto ORDER BY Category;

--Products in stock and out of stock
 select outofstock ,count(sku_id) from zepto group by outOfStock;

 --product names present multiple times

 select name, count(sku_id) as "number of skus" from zepto group by name having count(sku_id)>1 order by count(sku_id) desc;

 ---data cleaning

 ---products with price=0

 select *from zepto where mrp=0 or discountedSellingPrice=0;

 delete from zepto where mrp=0;

 ---converting paise to ruppes
 update zepto set mrp=mrp/100.0,discountedSellingPrice=discountedSellingPrice/100.0;

 select mrp,discountedSellingPrice from zepto;

 --q1.find what are the product with high mrp but out of stock

 select distinct TOP 10 name ,mrp,discountpercent from zepto order by discountPercent desc ;

 --Q2 WHAT ARE THE PRODUCTS WITH HIGH MRP BUT OUT OF STOCK

 SELECT DISTINCT name ,mrp from zepto where outofstock=1 and mrp>300 order by mrp desc;

 --q3 calculate estimated revenue for each category

 select Category,sum(discountedSellingPrice*availableQuantity) as total_revenue from zepto group by Category order by total_revenue;

 --q4 find all products where mrp is greater than 500 and discount is less than 10%

 select distinct name,mrp,discountpercent from zepto where mrp>500 and discountPercent<10 order by mrp desc,discountPercent desc;

 --q5 identify the top 5 categories offering the heighest average discount percentage

 select  top 5 category,ROUND(avg(discountpercent),2) as avg_discount from zepto group by category order by avg_discount desc;
  
--q6 find the price per gram for products above 100g and sort by best value.

select distinct name ,weightInGms,discountedSellingPrice,ROUND(discountedSellingPrice/weightInGms,2)  as price_per_gram from zepto where weightInGms>=100 order by price_per_gram;

 --q7 group the products into categories like low , medium ,bulk

 select distinct name , weightInGms,case when weightInGms<1000 then 'low' when weightInGms<5000 then 'medium' else 'bulk' end as weight_category from zepto;

 -- q8 when is the total inventory weight per category
 
 select Category,sum(weightInGms*availableQuantity) as total_weight from zepto group by category order by  total_weight ;