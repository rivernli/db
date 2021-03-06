USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Get_117_Display_Ledger_Data]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Get_117_Display_Ledger_Data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE name='TTFGLD106858' AND XTYPE='U')
		BEGIN
			DROP TABLE TTFGLD106858
		END
		SELECT T$AMTH$1,t$fyer,t$fprd,t$dbcr,t$leac 
	INTO TTFGLD106858 
	FROM HKGNT117.ce3p1179.dbo.TTFGLD106858
	CREATE NONCLUSTERED INDEX [TTFGLD106858AMTH] ON [TTFGLD106858] 
	(
		[T$AMTH$1] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106858FYER] ON [TTFGLD106858] 
	(
		[t$fyer] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106858FPRD] ON [TTFGLD106858] 
	(
		[t$fprd] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106858dbcr] ON [TTFGLD106858] 
	(
		[t$dbcr] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106858leac] ON [TTFGLD106858] 
	(
		[t$leac] ASC
	)
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE name='TTFGLD106888' AND XTYPE='U')
		BEGIN
			DROP TABLE TTFGLD106888
		END
		SELECT T$AMTH$1,t$fyer,t$fprd,t$dbcr,t$leac 
	INTO TTFGLD106888 
	FROM HKGNT117.ce3p1179.dbo.TTFGLD106888
	CREATE NONCLUSTERED INDEX [TTFGLD106888AMTH] ON [TTFGLD106888] 
	(
		[T$AMTH$1] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106888FYER] ON [TTFGLD106888] 
	(
		[t$fyer] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106888FPRD] ON [TTFGLD106888] 
	(
		[t$fprd] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106888dbcr] ON [TTFGLD106888] 
	(
		[t$dbcr] ASC
	)
	CREATE NONCLUSTERED INDEX [TTFGLD106888leac] ON [TTFGLD106888] 
	(
		[t$leac] ASC
	)

	--DBCC SHRINKFILE (N'TestDB_Data' , 0)
	--DBCC SHRINKFILE (N'TestDB_Log' , 0)

END
GO
