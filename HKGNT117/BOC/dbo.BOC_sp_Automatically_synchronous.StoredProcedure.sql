USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[BOC_sp_Automatically_synchronous]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ===================================================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/08/6,>
-- Description:	<Description,synchronous Baan Table to HKGNT117 SQL,>
-- ===================================================================
CREATE PROCEDURE [dbo].[BOC_sp_Automatically_synchronous]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	truncate table BOC.dbo.tfsboc004180
	insert into BOC.dbo.tfsboc004180 select * from FactoryLoading.dbo.tfsboc004180

	truncate table BOC.dbo.tfsboc100180
	insert into BOC.dbo.tfsboc100180 select * from FactoryLoading.dbo.tfsboc100180

	truncate table BOC.dbo.tfsboc103180
	insert into BOC.dbo.tfsboc103180 select * from FactoryLoading.dbo.tfsboc103180

	truncate table BOC.dbo.tfsboc104180
	insert into BOC.dbo.tfsboc104180 select * from FactoryLoading.dbo.tfsboc104180

	truncate table BOC.dbo.tfsboc105180
	insert into BOC.dbo.tfsboc105180 select * from FactoryLoading.dbo.tfsboc105180

	truncate table BOC.dbo.tfsboc106180
	insert into BOC.dbo.tfsboc106180 select * from FactoryLoading.dbo.tfsboc106180
	insert into dbo.tfsboc106180(Key_Customer,Serial) values ('Others',0)
	insert into dbo.tfsboc106180(Key_Customer,Serial) values ('Total',0)
	insert into dbo.tfsboc106180(Key_Customer,Serial) values ('Total per Week',0)
	insert into dbo.tfsboc106180(Key_Customer,Serial) values ('Week/Period',0)

	truncate table BOC.dbo.tfsboc107180
	insert into BOC.dbo.tfsboc107180 select * from FactoryLoading.dbo.tfsboc107180
	insert into dbo.tfsboc107180(Product_Type,Serial) values ('Others',0)
	insert into dbo.tfsboc107180(Product_Type,Serial) values ('Total',0)
	insert into dbo.tfsboc107180(Product_Type,Serial) values ('Total per Week',0)
	insert into dbo.tfsboc107180(Product_Type,Serial) values ('Week/Period',0) 

	truncate table BOC.dbo.tfsboc108180
	insert into BOC.dbo.tfsboc108180 select * from FactoryLoading.dbo.tfsboc108180

	truncate table BOC.dbo.tfsboc109180
	insert into BOC.dbo.tfsboc109180 select * from FactoryLoading.dbo.tfsboc109180

	truncate table BOC.dbo.tfsboc110180
	insert into BOC.dbo.tfsboc110180 select * from FactoryLoading.dbo.tfsboc110180

	truncate table BOC.dbo.tfsboc111180
	insert into BOC.dbo.tfsboc111180 select * from FactoryLoading.dbo.tfsboc111180

	truncate table BOC.dbo.tfsboc112180
	insert into BOC.dbo.tfsboc112180 select * from FactoryLoading.dbo.tfsboc112180

	truncate table BOC.dbo.tfsboc113180
	insert into BOC.dbo.tfsboc113180 select * from FactoryLoading.dbo.tfsboc113180

	truncate table BOC.dbo.tfsboc114180
	insert into BOC.dbo.tfsboc114180 select * from FactoryLoading.dbo.tfsboc114180

END

GO
