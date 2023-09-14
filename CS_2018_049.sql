/*Course Code: DSCI 32012
 *Student Number: Sathmina-CS18049
 *Individual Assignment Answers*/

/******************************************************************
Program_name : Individual_Assignment
Purpose: to insert given employee details into tab_employee table

Date        Created By        Description
14/07/2023  Udara	      Creation
******************************************************************/
-- initialize variables
product_id_count NUMBER := 0;

-- create table Product
CREATE TABLE Product (
    Product_id VARCHAR2(10) NOT NULL PRIMARY KEY,
    Product_name VARCHAR2(20) NOT NULL,
    Warranty_period NUMBER(2, 1) NOT NULL,
    Supplier_code VARCHAR2(10),
    List_price NUMBER(10, 2) NOT NULL
);


--create table warehouse
CREATE TABLE Warehouse(
    Warehouse_id VARCHAR2(10) NOT NULL PRIMARY KEY,
    Warehouse_name VARCHAR2(20) NOT NULL,
    Location  VARCHAR2(20) NOT NULL
);

--create table inventory
CREATE TABLE Inventory (
    Product_id VARCHAR2(10) NOT NULL,
    Warehouse_id VARCHAR2(10) NOT NULL,
    Qty_on_hand  NUMBER NOT NULL,
    CONSTRAINT pk_inventory PRIMARY KEY (Product_id, Warehouse_id),
    CONSTRAINT fk_product_id FOREIGN KEY (Product_id)
        REFERENCES Product (Product_id),
    CONSTRAINT fk_warehouse_id FOREIGN KEY (Warehouse_id)
        REFERENCES Warehouse (Warehouse_id)
);

END;

DECLARE
BEGIN

INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD01', 'Air cooler', 5, 'SW_00101', 25990.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD02', 'Celing fan', 2, 'IN_20034',  6690.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD03', 'Dry iron', 0.5, 'IN_20034', 2750.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD04', 'Floor polisher', 1, '', 2750.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD05', 'Stand fan', 0.5, 'SG_34023', 18590.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD06', 'Steam iron', 0.5, '', 2190.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD07', 'Vaccum cleaner', 1.5, 'SG_34023', 9990.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD08', 'Water heater', 2, 'TW_90846', 18890.00);
INSERT INTO Product (product_id, product_name, Warranty_period, Supplier_code, List_price) VALUES ('PRD09', 'Water purifier', 2, 'US_56798', 11850.00);

INSERT INTO Warehouse(Warehouse_id, Warehouse_name, Location) VALUES ('ST001', 'Shop Warehouse', 'Colombo');
INSERT INTO Warehouse(Warehouse_id, Warehouse_name, Location) VALUES ('ST002', 'Large Zone', 'Rathmalana');
INSERT INTO Warehouse(Warehouse_id, Warehouse_name, Location) VALUES ('ST003', 'Retail Zone', 'Kiribathgoda');
INSERT INTO Warehouse(Warehouse_id, Warehouse_name, Location) VALUES ('ST004', 'Whole Supply', 'Colombo');

INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD01', 'ST001', 30);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD02', 'ST001', 45);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD02', 'ST002', 20);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD02', 'ST003', 10);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD03', 'ST002', 50);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD03', 'ST004', 50);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD06', 'ST002', 75);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD07', 'ST001', 15);
INSERT INTO Inventory (product_id, Warehouse_id, Qty_on_hand) VALUES ('PRD07', 'ST003', 10);

END;

CREATE OR REPLACE PACKAGE Pkg_Multitrade
AS
  PROCEDURE get_Warehousename(product_id IN Product.Product_id%TYPE);
  PROCEDURE calculate_total_profit_no_discount;
  PROCEDURE calculate_total_profit_with_discount(Discount IN NUMBE);
  FUNCTION fun_DiscountedPrice(Product_id IN Product.Product_id%TYPE) RETURN NUMBER;
  FUNCTION fun_DiscountedPrice(Product_id IN Product.Product_id%TYPE, Discount IN NUMBER) RETURN NUMBER;
  G_total_profit_no_discount NUMBER(10,2);
  G_total_profit_with_discount NUMBER(10,2);
  G_discount_percentage NUMBER(0,2);
END Pkg_Multitrade;
/***First Procedure***/
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
/***First Function***/
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
/***Second Function***/
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
/***Second Procedure***/
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
/***Third Procedure***/
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



/***Print Values***/
dbms_output.put_line(Pkg_Multitrade.G_total_profit_no_discount);
dbms_output.put_line(Pkg_Multitrade.G_total_profit_with_discount(0.1));
dbms_output.put_line(Pkg_Multitrade.fun_DiscountedPrice('PRD01'));
dbms_output.put_line(Pkg_Multitrade.fun_DiscountedPrice('PRD01', 0.20));




