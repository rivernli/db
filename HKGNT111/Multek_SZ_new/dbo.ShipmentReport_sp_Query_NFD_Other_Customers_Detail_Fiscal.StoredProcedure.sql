USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_NFD_Other_Customers_Detail_Fiscal]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_NFD_Other_Customers_Detail_Fiscal]
	-- Add the parameters for the stored procedure here
	@Year CHAR(4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *,(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) AS Amount
	FROM (
			SELECT a.OracleCustomer,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P01' GROUP BY b.OracleCustomer
				),0) AS M1,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P02' GROUP BY b.OracleCustomer
				),0) AS M2,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P03' GROUP BY b.OracleCustomer
				),0) AS M3,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P04' GROUP BY b.OracleCustomer
				),0) AS M4,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P05' GROUP BY b.OracleCustomer
				),0) AS M5,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P06' GROUP BY b.OracleCustomer
				),0) AS M6,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P07' GROUP BY b.OracleCustomer
				),0) AS M7,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P08' GROUP BY b.OracleCustomer
				),0) AS M8,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P09' GROUP BY b.OracleCustomer
				),0) AS M9,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P10' GROUP BY b.OracleCustomer
				),0) AS M10,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P11' GROUP BY b.OracleCustomer
				),0) AS M11,
				ISNULL((
					SELECT SUM(b.InvoicedDollarsInUSD) FROM NorthfieldSalesData b WHERE b.FlexCustName='Other Customers' AND b.OracleCustomer=a.OracleCustomer AND LEFT(b.RevenueYrMo,8)=@Year+'-P12' GROUP BY b.OracleCustomer
				),0) AS M12
			FROM NorthfieldSalesData a
			WHERE LEFT(a.RevenueYrMo,4)=@Year
				AND a.FlexCustName='Other Customers'
			GROUP BY a.OracleCustomer
		) a
	ORDER BY (M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) DESC
END
GO
