USE [DataWarehouse]
GO
/****** Object:  StoredProcedure [dbo].[Create_Module]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Create_Module]
@Module_Name	nvarchar(50),
@Database_Name	nvarchar(50)
AS
	DECLARE	@sqlString	NVARCHAR(MAX)
	DECLARE	@checkExis  NVARCHAR(500)
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
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'+''''+@Database_Name+'.[dbo].['+@Module_Name+'_Users]'+''''+') AND type in (N'+''''+'U'+''''+'))
	BEGIN
		CREATE TABLE '+@Database_Name+'.[dbo].['+@Module_Name+'_Users](
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
	EXECUTE(@sqlString)

-- Used SP sp_Check_UserID
	SET @sqlString = '
		CREATE PROCEDURE '+@Database_Name+'.[dbo].['+@Module_Name+'_sp_Check_UserID]   
				@Domain VARCHAR(50),
				@Account VARCHAR(50)
		AS
		SET NOCOUNT ON
		DECLARE @UserID VARCHAR(50)
		SET @UserID=LTRIM(RTRIM(@Domain))+'+''''+'\'+''''+'+LTRIM(RTRIM(@Account))
		IF NOT EXISTS(SELECT * FROM '+@Module_Name+'_Users WHERE UserID=@UserID)
			BEGIN
				RAISERROR('+''''+'Sorry, you have not authority to access the system!'+''''+',16,1)
				RETURN
			END
		IF EXISTS(SELECT * FROM '+@Module_Name+'_Users WHERE UserID=@UserID AND Enable=0)
			BEGIN
				RAISERROR('+''''+'Sorry, you have not authority to access the system!'+''''+',16,1)
				RETURN
			END'

	SET @checkExis = '	
		IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'+''''+@Database_Name+'.[dbo].['+@Module_Name+'_sp_Check_UserID]'+''''+') AND type in (N'+''''+'U'+''''+'))
			BEGIN
				EXEC dbo.sp_executesql @statement = N'+''''+@sqlString+''''+'
			END
			'
	--print @sqlString
	EXECUTE(@sqlString)

GO
