/*Course Code: DSCI 32012
 *Student Number: Sathmina-CS18049
 *Individual Assignment Answers*/

/******************************************************************
Program_name : Individual_Assignment
Purpose: to insert given employee details into tab_employee table

Date        Created By        Description
14/07/2023  Udara	      Creation
******************************************************************/

/**Question 01**/
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

/**Question 02**/
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