/*Course Code: DSCI 32012
 *Student Number: Sathmina-CS18049
 *Individual Assignment Answers*/

/******************************************************************
Program_name : Individual_Assignment
Purpose: to insert given employee details into tab_employee table

Date        Created By        Description
14/07/2023  Udara	      Creation
******************************************************************/
/***Question 3F ***/
dbms_output.put_line(Pkg_Multitrade.G_total_profit_no_discount);
dbms_output.put_line(Pkg_Multitrade.G_total_profit_with_discount(0.1));
dbms_output.put_line(Pkg_Multitrade.fun_DiscountedPrice('PRD01'));
dbms_output.put_line(Pkg_Multitrade.fun_DiscountedPrice('PRD01', 0.20));