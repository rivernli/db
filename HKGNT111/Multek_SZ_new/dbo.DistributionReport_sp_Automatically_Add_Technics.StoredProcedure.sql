USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Add_Technics]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Add_Technics]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	ALTER TABLE TFSOLP104180 ADD Technics CHAR(1) 
	ALTER TABLE TFSOLP105180 ADD Technics CHAR(1) 
	ALTER TABLE TFSOLP106180 ADD Technics CHAR(1) 
	ALTER TABLE TFSOLP107180 ADD Technics CHAR(1) 
END
GO
