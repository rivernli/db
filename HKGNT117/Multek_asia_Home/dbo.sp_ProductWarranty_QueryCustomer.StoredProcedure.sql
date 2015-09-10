USE [Multek_AsiaHome]
GO
/****** Object:  StoredProcedure [dbo].[sp_ProductWarranty_QueryCustomer]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Abill Cheng
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProductWarranty_QueryCustomer] 
	@cust VARCHAR(300)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT top 10 Real_OEM FROM vw_ProductWarranty_Customer WHERE Real_OEM LIKE '%'+@cust+'%'
END



GO
