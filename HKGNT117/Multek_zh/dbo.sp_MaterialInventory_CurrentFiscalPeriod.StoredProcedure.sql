USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_CurrentFiscalPeriod]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<当前Fiscal Period >
-- =============================================
CREATE PROCEDURE [dbo].[sp_MaterialInventory_CurrentFiscalPeriod]
	
AS
BEGIN
	SELECT  [FiscalPeriod]
    FROM [DataWarehouse].[dbo].[DW_DIM_Calender]
	where [calenderDate]=(convert(varchar(10),   getdate(),120))
	
	
END
GO
