USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_UpTime]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_MSS_UpTime]
AS
BEGIN
	SELECT [UpTime] FROM [Multek_ZH].[dbo].[MSS_UpTime]
	
END

GO
