USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_UpdateHistory]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SGP_UpdateHistory]
	(
	   @flag varchar(10), 
	   @operator varchar(10),
	   @id int
	)
AS



BEGIN
update SGP_history  set flag = '1' where flag = '0' 

INSERT INTO SGP_history   
(salesman,rfq ,indate ,outdate ,OEM,CEM,name ,programme,PN ,rev ,product,width ,length ,unit ,arraywidth ,arraylength ,unitperarray ,prodwidth ,prodlength ,unitperprod ,matl_percentage ,layers ,holes ,smallesthole ,matl ,thk ,copper ,finishing ,lno ,lni ,imped ,usize ,uqty ,blindsize ,blindqty ,buriesize ,burieqty ,outline ,remark ,shipterms ,shiptermadder ,payterms ,leadtime ,currency, exchangerate ,setupcharge ,Etestcharge ,toolingcharge ,commission ,min_sq_inch ,min_asp ,moq ,period ,qty1 ,price1 ,remark1 ,qty2 ,price2 ,remark2 ,qty3 ,price3 ,remark3 ,qty4 ,price4 ,remark4 ,qty5 ,price5 ,remark5 ,note1 ,note2 ,targetprice , targetasp ,targetsqinch ,target_actual ,status ,cost ,yield,profit,FTP, UID, DOM, adate, ssid,batchflag,parid

	,building,model,sqftarray,volumepermonth,expectedlifetime,factoryloading,panelutilization,project,projectremark
 )
 
 select  salesman, rfq ,indate ,outdate ,OEM,CEM,name ,programme,PN ,rev ,product,width ,length ,unit ,arraywidth ,arraylength ,unitperarray ,prodwidth ,prodlength ,unitperprod ,matl_percentage ,layers ,holes ,smallesthole ,matl ,thk ,copper ,finishing ,lno ,lni ,imped ,usize ,uqty ,blindsize ,blindqty ,buriesize ,burieqty ,outline ,remark ,shipterms ,shiptermadder ,payterms ,leadtime ,currency, exchangerate ,setupcharge ,Etestcharge ,toolingcharge ,commission ,min_sq_inch ,min_asp ,moq ,period ,qty1 ,price1 ,remark1 ,qty2 ,price2 ,remark2 ,qty3 ,price3 ,remark3 ,qty4 ,price4 ,remark4 ,qty5 ,price5 ,remark5 ,note1 ,note2 ,targetprice , targetasp ,targetsqinch ,target_actual ,status ,cost ,yield,profit,FTP,UID, DOM, adate, ssid,batchflag,parid 

	,building,model,sqftarray,volumepermonth,expectedlifetime,factoryloading,panelutilization,project,projectremark
	
from sgp_data where id  = @id
END
BEGIN
	update SGP_history  set flagu =@flag,operator= @operator, mdate= getdate()  where flag = '0'
END
GO
