USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_sync_Baan_data]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_sync_Baan_data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--===================================================================================================
-- Update TABLE TFSOLP104180
----===================================================================================================
--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE id = OBJECT_ID(N'Multek_ZH.dbo.TFSOLP104180') AND TYPE = 'U')
--		BEGIN
--			TRUNCATE TABLE TFSOLP104180
--			INSERT INTO TFSOLP104180 
--			SELECT * FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP104180')
--		END
--	ELSE
--		BEGIN
--			SELECT * INTO TFSOLP104180 FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP104180')
--		END

--===================================================================================================
-- Update Table TFSOLP122180 Issue convert datetime error
--===================================================================================================
	--SELECT * INTO TFSOLP122180 FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP122180') -- 
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE id = OBJECT_ID(N'Multek_ZH.dbo.TFSOLP122180') AND TYPE = 'U')
		BEGIN
			TRUNCATE TABLE TFSOLP122180
			INSERT INTO TFSOLP122180 
			SELECT * FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP122180')
		END
	ELSE
		BEGIN
			SELECT * INTO TFSOLP122180 FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP122180')
		END

--===================================================================================================
--Update Table TFSOLP130180
--===================================================================================================
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE id = OBJECT_ID(N'Multek_ZH.dbo.TFSOLP130180') AND TYPE = 'U')
		BEGIN
			TRUNCATE TABLE TFSOLP130180
			INSERT INTO TFSOLP130180 
			SELECT * FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP130180')
		END
	ELSE
		BEGIN
			SELECT * INTO TFSOLP130180 FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP130180')
		END

--===================================================================================================
--Update Table TFSOLP130180   -- 22:56
--===================================================================================================
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE id = OBJECT_ID(N'Multek_ZH.dbo.TFSOLP114180') AND TYPE = 'U')
		BEGIN
			TRUNCATE TABLE TFSOLP114180
			INSERT INTO TFSOLP114180 
			SELECT * FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP114180')
		END
	ELSE
		BEGIN
			SELECT * INTO TFSOLP114180 FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP114180')
		END

--===================================================================================================
--
--===================================================================================================
--	SELECT * INTO TFSOLP100180_new FROM OPENQUERY(as1p1,'SELECT * FROM baan.TFSOLP100180') 
--===================================================================================================
--
--===================================================================================================
END

GO
