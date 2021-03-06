USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Update_User_Base_Information]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Update_User_Base_Information]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50),
	@Name VARCHAR(100),
	@Title VARCHAR(100),
	@Phone VARCHAR(100),
	@Mail VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE PT_Users
	SET Email=@Mail,Phone=@Phone,Position=@Title,BDM=@Name
	WHERE UserID=@UserID

END
GO
