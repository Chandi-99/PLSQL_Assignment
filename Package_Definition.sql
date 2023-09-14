/*Course Code: DSCI 32012
 *Student Number: Sathmina-CS18049
 *Individual Assignment Answers*/

/******************************************************************
Program_name : Individual_Assignment
Purpose: to insert given employee details into tab_employee table

Date        Created By        Description
14/07/2023  Udara	      Creation
******************************************************************/
CREATE OR REPLACE PACKAGE Pkg_Multitrade
AS
  PROCEDURE get_Warehousename(product_id IN Product.Product_id%TYPE);
  PROCEDURE calculate_total_profit_no_discount;
  PROCEDURE calculate_total_profit_with_discount(Discount IN NUMBER);
  FUNCTION fun_DiscountedPrice(Product_id IN Product.Product_id%TYPE) RETURN NUMBER;
  FUNCTION fun_DiscountedPrice(Product_id IN Product.Product_id%TYPE, Discount IN NUMBER) RETURN NUMBER;
  G_total_profit_no_discount NUMBER(10,2);
  G_total_profit_with_discount NUMBER(10,2);
  G_discount_percentage NUMBER(0,2);
END Pkg_Multitrade;