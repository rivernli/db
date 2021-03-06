USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Automatically_Drop_Technics]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Automatically_Drop_Technics]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DROP INDEX Technics ON TFSOLP104180 WITH ( ONLINE = OFF )
	DROP INDEX SitePlantTechnicsSHDate ON TFSOLP104180 WITH ( ONLINE = OFF )
	ALTER TABLE TFSOLP104180 DROP COLUMN Technics 
	DROP INDEX Technics ON TFSOLP105180 WITH ( ONLINE = OFF )
	DROP INDEX SitePlantTechnicsSHDate ON TFSOLP105180 WITH ( ONLINE = OFF )
	ALTER TABLE TFSOLP105180 DROP COLUMN Technics 
	DROP INDEX Technics ON TFSOLP106180 WITH ( ONLINE = OFF )
	DROP INDEX SitePlantTechnicsSHDate ON TFSOLP106180 WITH ( ONLINE = OFF )
	ALTER TABLE TFSOLP106180 DROP COLUMN Technics 
	DROP INDEX Technics ON TFSOLP107180 WITH ( ONLINE = OFF )
	DROP INDEX SitePlantTechnicsSHDate ON TFSOLP107180 WITH ( ONLINE = OFF )
	ALTER TABLE TFSOLP107180 DROP COLUMN Technics 
END
GO
