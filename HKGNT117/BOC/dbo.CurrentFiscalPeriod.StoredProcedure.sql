USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[CurrentFiscalPeriod]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<当前Fiscal Period >
-- =============================================
CREATE PROCEDURE [dbo].[CurrentFiscalPeriod]
	
AS
BEGIN
	SELECT  [FiscalPeriodDesc]
    FROM [DataWarehouse].[dbo].[DW_DIM_Calender]
	where [calenderDate]=(convert(varchar(10),   getdate(),120))
	
	
END

GO
