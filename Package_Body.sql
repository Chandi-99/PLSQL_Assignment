/*Course Code: DSCI 32012
 *Student Number: Sathmina-CS18049
 *Individual Assignment Answers*/

/******************************************************************
Program_name : Individual_Assignment
Purpose: to insert given employee details into tab_employee table

Date        Created By        Description
14/07/2023  Udara	      Creation
******************************************************************/
/***Question 3A ***/
CREATE OR REPLACE PACKAGE BODY Pkg_Multitrade
AS
  PROCEDURE get_WarehouseName(Warehouse_id IN Warehouse.Warehouse_id%TYPE)
  IS
  v_Warehouse_name Warehouse.Warehouse_name%TYPE;
  BEGIN
    SELECT Warehouse_name
    INTO v_Warehouse_name
    FROM Warehouse
    WHERE Warehouse_id = Warehouse_id;
    dbms_output.put_line('Warehouse name: ' || v_Warehouse_name);
  EXCEPTION
WHEN OTHERS THEN
--display error
v_exception_message := SUBSTR(SQLERRM, 1, 200);
        dbms_output.put_line('Error creating table: ' || v_exception_message);
  END get_WarehouseName;


/***Question 3B ***/
  FUNCTION fun_DiscountedPrice(Product_id IN Product.Product_id%TYPE) RETURN NUMBER
  IS
    v_DiscountedPrice NUMBER(10,2);
    v_Product_price Product.List_price%TYPE;
  BEGIN
  SELECT List_price
  INTO v_Product_price
  FROM Product
  WHERE Product_id = Product_id;
    CASE
    WHEN v_Product_price < 6000 THEN
      v_DiscountedPrice := v_Product_price * 0.88;
    WHEN v_Product_price >= 6000 AND v_Product_price < 12000 THEN
      v_DiscountedPrice := v_Product_price * 0.84;
    ELSE
      v_DiscountedPrice := v_Product_price * 0.76;
  END CASE;
  dbms_output.put_line('Discounted price: ' || v_DiscountedPrice);
  EXCEPTION
WHEN OTHERS THEN
--display error
v_exception_message := SUBSTR(SQLERRM, 1, 200);
        dbms_output.put_line('Error creating table: ' || v_exception_message);
  END fun_DiscountedPrice;


/***Question 3C ***/
  FUNCTION fun_DiscountedPrice(Product_id IN Product.Product_id%TYPE, Discount IN NUMBER(0,2)) RETURN NUMBER
  IS
    v_DiscountedPrice NUMBER(10,2);
    v_Product_price Product.List_price%TYPE;
  BEGIN
  SELECT List_price
  INTO v_Product_price
  FROM Product
  v_DiscountedPrice := (v_Product_price*(1-Discount));
  dbms_output.put_line('Discounted price: ' || v_DiscountedPrice);
  EXCEPTION
WHEN OTHERS THEN
--display error
v_exception_message := SUBSTR(SQLERRM, 1, 200);
        dbms_output.put_line('Error creating table: ' || v_exception_message);
  END fun_DiscountedPrice;

/***Question 3D ***/
  PROCEDURE calculate_total_profit_no_discount
  IS
    -- Cursor to iterate through the inventory.
    CURSOR cur_inventory IS
      SELECT Product_id, Qty_on_hand
      FROM inventory;
    -- Local variable to store the total profit.
    v_total_profit NUMBER(10,2);
    v_List_price Product.List_price%TYPE;
  BEGIN
    -- Initialize the total profit.
    v_total_profit := 0;
    -- Open the cursor.
    OPEN cur_inventory;
    -- Iterate through the cursor and add the list price of each unit to the total profit.
    LOOP
      FETCH cur_inventory INTO v_Product_id, v_Qty_on_hand;
      EXIT WHEN cur_inventory%NOTFOUND;
      SELECT List_price INTO v_List_price FROM Product WHERE Product_id = v_Product_id;
      v_total_profit := v_total_profit + (v_List_price*0.1*v_Qty_on_hand);
    END LOOP;
    -- Close the cursor.
    CLOSE cur_inventory;
    -- Set the public variable to the total profit.
    G_total_profit_no_discount := v_total_profit;
  END calculate_total_profit_no_discount;


/***Question 3E ***/
  PROCEDURE calculate_total_profit_with_discount(Discount IN NUMBER)
  IS
    -- Cursor to iterate through the inventory.
    CURSOR cur_inventory IS
      SELECT Product_id, Qty_on_hand
      FROM inventory;
    -- Local variable to store the total profit.
    v_total_profit NUMBER(10,2);
    v_previous_profit NUMBER(10,2);
    v_List_price Product.List_price%TYPE;
    v_DiscountedPrice NUMBER(10,2);
  BEGIN
    -- Initialize the total profit.
    v_total_profit := 0;
    v_DiscountedPrice := 0;
    -- Open the cursor.
    OPEN cur_inventory;
    -- Iterate through the cursor and add the list price of each unit to the total profit.
    LOOP
      FETCH cur_inventory INTO v_Product_id, v_Qty_on_hand;
      EXIT WHEN cur_inventory%NOTFOUND;
      SELECT List_price INTO v_List_price FROM Product WHERE Product_id = v_Product_id;
      v_previous_profit := v_List_price*0.1;
      v_DiscountedPrice = fun_DiscountedPrice(v_Product_id, Discount);
      v_total_profit := v_total_profit + (v_previous_profit - (v_List_price - v_DiscountedPrice))*v_Qty_on_hand;
    END LOOP;
    -- Close the cursor.
    CLOSE cur_inventory;
    -- Set the public variable to the total profit.
    G_total_profit_no_discount := v_total_profit;
    G_discount_percentage := Discount;
  END calculate_total_profit_with_discount;
 EXCEPTION
    WHEN OTHERS THEN
--display error
	v_exception_message := SUBSTR(SQLERRM, 1, 200);
        dbms_output.put_line('Error creating table: ' || v_exception_message);
END;
END Pkg_Multitrade;
/
