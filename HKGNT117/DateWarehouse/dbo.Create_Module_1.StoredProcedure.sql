USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[Create_Module_1]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Create_Module_1]
@Module_Name	nvarchar(50),
@Database_Name	nvarchar(50)
AS
	DECLARE	@sqlString	NVARCHAR(MAX)
/*===========  User Login Form  ===========*/

	IF @Module_Name = NULL
		BEGIN
			RAISERROR('The Module is empty !',16,1)
			RETURN
		END

	IF @Database_Name = NULL
		BEGIN
			RAISERROR('The @Database Name is empty !',16,1)
			RETURN
		END

-- Create Table Users

	SET @sqlString = '
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'+''''+'[dbo].['+@Module_Name+'_Users]) AND type in (N'+''''+'U'+''''+'))
	BEGIN
		CREATE TABLE [dbo].['+@Module_Name+'_Users](
			[AutoID] [int] IDENTITY(1,1) NOT NULL,
			[UserID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
			[Region] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
			[Account] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
			[Email] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
			[BDM] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
			[Administrator] [bit] NOT NULL CONSTRAINT [DF_Users_Administrator]  DEFAULT (0),
			[Enable] [bit] NOT NULL CONSTRAINT [DF_Users_Disable]  DEFAULT (1),
		 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
		(
			[UserID] ASC
		)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [UK_Users] UNIQUE NONCLUSTERED 
		(
			[Account] ASC,
			[Region] ASC
		)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	END
		'
	PRINT @sqlString
	--EXECUTE(@sqlString)
GO
