USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[Create_Module]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Create_Module]
@Module_Name	nvarchar(50),
@Database_Name	nvarchar(50)
AS
	DECLARE	@sqlString	NVARCHAR(MAX)
/*===========  User Login Form  ===========*/
-- Used Table 
	SET @sqlString = 'USE '+@Database_Name	
	EXECUTE(@sqlString)

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

	SET @sqlString = 'CREATE TABLE [dbo].['+@Module_Name+'_Users](
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
		'

	EXECUTE(@sqlString)

-- Used SP
	SET @sqlString = 'use '+@Database_Name+'
	CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Check_UserID]   
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
	EXECUTE(@sqlString)

-- LOG TABLE 
	SET @sqlString = 'CREATE TABLE [dbo].['+@Module_Name+'_Log](
		[AutoID] [bigint] IDENTITY(1,1) NOT NULL,
		[UserID] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
		[Operation] [varchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
		[OperatedDate] [datetime] NOT NULL CONSTRAINT [DF_'+@Module_Name+'_Log_OperatedDate]  DEFAULT (getdate()),
		[Remark] [varchar](500) COLLATE Chinese_PRC_CI_AS NULL,
		 CONSTRAINT [PK_'+@Module_Name+'_Log] PRIMARY KEY CLUSTERED 
		(
			[AutoID] ASC
		)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]'
	EXECUTE(@sqlString)

-- INSERT LOG SP
	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_Insert_Log] 
			-- Add the parameters for the stored procedure here
			@UserID VARCHAR(50),
			@Operation VARCHAR(50),
			@Remark	VARCHAR(200)
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;

			-- Insert statements for procedure here
			IF CHARINDEX(@UserID,'+''''+'asia\lgzjzhan;asia\hkg10369;asia\MCN00318;asia\admin_hkg10369'+''''+')=0
				BEGIN
					INSERT INTO '+@Module_Name+'_Log (UserID,Operation,Remark)
						VALUES(@UserID,@Operation,@Remark)
				END
		END'

	EXECUTE(@sqlString)

/*========================== Menu & Authority ====================================================*/
-- ShipmentReport_Menu
	SET @sqlString = 'CREATE TABLE [dbo].['+@Module_Name+'_Menu](
			[ID] [varchar](50) NOT NULL,
			[Description] [varchar](500) NULL,
			[Page] [varchar](500) NULL,
		 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
		(
			[ID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]'
	EXECUTE(@sqlString)

--ShipmentReport_Authority
	SET @sqlString = 'CREATE TABLE [dbo].['+@Module_Name+'_Authority](
			[UserID] [varchar](50) NOT NULL,
			[MenuID] [varchar](50) NOT NULL,
			[CanSee] [bit] NOT NULL CONSTRAINT [DF_Authority_CanSee]  DEFAULT (0),
			[CanAdd] [bit] NOT NULL CONSTRAINT [DF_Authority_CanAdd]  DEFAULT (0),
			[CanModify] [bit] NOT NULL CONSTRAINT [DF_Authority_CanModify]  DEFAULT (0),
			[CanDelete] [bit] NOT NULL CONSTRAINT [DF_Authority_CanDelete]  DEFAULT (0),
		 CONSTRAINT [PK_Authority] PRIMARY KEY CLUSTERED 
		(
			[UserID] ASC,
			[MenuID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

		SET ANSI_PADDING OFF
		
		ALTER TABLE [dbo].['+@Module_Name+'_Authority]  WITH CHECK ADD  CONSTRAINT [FK_Authority_Menu] FOREIGN KEY([MenuID])
		REFERENCES [dbo].['+@Module_Name+'_Menu] ([ID])
		ON UPDATE CASCADE
		ON DELETE CASCADE

		ALTER TABLE [dbo].['+@Module_Name+'_Authority] CHECK CONSTRAINT [FK_Authority_Menu]'
	EXECUTE(@sqlString)

-- Function Shipment_fun_GetParentMenuName
	SET @sqlString = 'Create FUNCTION [dbo].['+@Module_Name+'_fun_GetParentMenuName]
			(
				@MenuID VARCHAR(50) 
			)  
		RETURNS VARCHAR(8000) AS  
		BEGIN 
			DECLARE @MenuName VARCHAR(8000),@SourceMenuID VARCHAR(50),@i INT
			
			SET @MenuName=''	
			SET @SourceMenuID=''
			SET @i=1

			WHILE  @i<=LEN(@MenuID)/5
				BEGIN
					SET @SourceMenuID= LEFT(@MenuID,@i*5)
					SET @MenuName=@MenuName+'+''''+' -> '+''''+'+(SELECT Description FROM '+@Module_Name+'_Menu WHERE ID=@SourceMenuID)
					SET @i=@i+1
				END
			RETURN (RIGHT(@MenuName,LEN(@MenuName)-4))
		END'
	EXECUTE(@sqlString)

-- SP Shipment_sp_Query_User_Authority
	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Query_User_Authority]
			@UserID VARCHAR(50)
		AS

		SET NOCOUNT ON

		--Get user menus
		SELECT a.MenuID ,
			dbo.'+@Module_Name+'_fun_GetParentMenuName (a.MenuID) AS MenuName,
			m.Description AS ChildMenuName, 
			a.CanSee,
			 m.Page AS NavigateUrl,
			 (
				SELECT ID FROM '+@Module_Name+'_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
			 ) AS ParentMenuID
		INTO #Temp
		FROM '+@Module_Name+'_Authority a left join '+@Module_Name+'_Menu m
		on a.MenuID = m.ID
		WHERE a.UserID = @UserID
		ORDER BY a.MenuID

		IF CHARINDEX(@UserID,'+''''+'asia\lgzjzhan;asia\hkg10369;asia\MCN00318;asia\admin_hkg10369'+''''+')=0
			BEGIN
				IF EXISTS(SELECT * FROM #Temp WHERE MenuID='+''''+'0000200001'+''''+' AND CanSee=1)
					BEGIN
						DELETE #Temp WHERE MenuID IN ('+''''+'0000200002'+''''+','+''''+'0000200003'+''''+')
					END

				DELETE #Temp WHERE MenuID IN ('+''''+'0000200000'+''''+')
			END

		SELECT * FROM #Temp WHERE CanSee=1 ORDER BY MenuID'
	EXECUTE(@sqlString)

/*========================== User Setting ====================================================*/
--ShipmentReport_sp_Judge_User_Page_Authority
	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Judge_User_Page_Authority]
			@UserID VARCHAR(50)=NULL,
			@Page VARCHAR(200)=NULL,
			@HaveAuthority BIT=NULL OUTPUT
		AS

		SET NOCOUNT ON

		SET @Page=RIGHT(@Page,LEN(@Page)-CHARINDEX('+''''+'/'+''''+',@Page,2)+1)
		SET @Page='+''''+'~'+''''+'+@Page

		SET @HaveAuthority=0
		IF EXISTS(SELECT a.* FROM '+@Module_Name+'_Authority a,'+@Module_Name+'_Menu m WHERE a.MenuID=m.ID AND a.UserID=@UserID AND m.Page=@Page AND a.CanSee=1)
			BEGIN
				SET @HaveAuthority=1
			END'
	EXECUTE(@sqlString)

--ShipmentReport_sp_Query_User
	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Query_User]
			@Domain VARCHAR(50)=NULL,
			@Account VARCHAR(50)=NULL,
			@BDMGAM	VARCHAR(50)=NULL,
			@Email	VARCHAR(50)=NULL
		AS

		SET NOCOUNT ON

		SET @Domain=ISNULL(@Domain,'+''''+''''+')
		SET @Domain='+''''+'%'+''''+'+RTRIM(LTRIM(@Domain))+'+''''+'%'+''''+'
		SET @Account=ISNULL(@Account,'+''''+''''+')
		SET @Account='+''''+'%'+''''+'+RTRIM(LTRIM(@Account))+'+''''+'%'+''''+'
		SET @BDMGAM=ISNULL(@BDMGAM,'+''''+''''+' )
		SET @BDMGAM='+''''+'%'+''''+'+RTRIM(LTRIM(@BDMGAM))+'+''''+'%'+''''+'
		SET @Email=ISNULL(@Email,'+''''+''''+')
		SET @Email='+''''+'%'+''''+'+RTRIM(LTRIM(@Email))+'+''''+'%'+''''+'

		SELECT *,BDM+'+''''+' ('+''''+'+Account+'++''''+')'+''''+' AS UserName 
		FROM '+@Module_Name+'_Users 
		WHERE Region LIKE @Domain
			AND Account LIKE @Account
			AND BDM LIKE @BDMGAM
			AND Email LIKE @Email
		ORDER BY UserID ASC'
	--print @sqlString
	EXECUTE(@sqlString)
--
-- sp ShipmentReport_sp_InsertUpdateDelete_User
	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_InsertUpdateDelete_User]
			@AutoID INT=NULL,
			@Domain VARCHAR(50)=NULL,
			@Account VARCHAR(50)=NULL,
			@BDM VARCHAR(50)=NULL,
			@Email VARCHAR(100)=NULL,
			@Administrator BIT=NULL,
			@Enable BIT=NULL,
			@Operation VARCHAR(10)
		AS

		SET NOCOUNT ON

		DECLARE @UserID VARCHAR(50) 

		SET @Domain=LTRIM(RTRIM(@Domain))
		SET @Account=LTRIM(RTRIM(@Account))
		SET @BDM=LTRIM(RTRIM(@BDM))
		SET @Email=LTRIM(RTRIM(@Email))

		IF @Operation='+''''+'Insert'+''''+' OR @Operation='+''''+'Update'+''''+'
			BEGIN
				IF @Domain IS NULL OR @Domain='+''''+''''+'
					BEGIN
						RAISERROR('+''''+'Sorry, [domain] can not be empty!'+''''+',16,1)
						RETURN
					END
				IF @Account IS NULL OR @Account='+''''+''''+'
					BEGIN
						RAISERROR('+''''+'Sorry, [account] can not be empty!'+''''+',16,1)
						RETURN
					END
				IF @BDM IS NULL OR @BDM='+''''+''''+'
					BEGIN
						RAISERROR('+''''+'Sorry, [Name] can not be empty!'+''''+',16,1)
						RETURN
					END
				IF @Email IS NULL OR @Email='+''''+''''+'
					BEGIN
						RAISERROR('+''''+'Sorry, [Eamil] can not be empty!'+''''+',16,1)
						RETURN
					END
				SET @UserID=@Domain+'+''''+'\'+''''+'+@Account
			END
		IF @Operation='+''''+'Insert'+''''+' 
			BEGIN
				INSERT INTO '+@Module_Name+'_Users (UserID,Region,Account,BDM,Email,Administrator,Enable)
					VALUES(@UserID,@Domain,@Account,@BDM,@Email,@Administrator,@Enable)
			END
		IF @Operation='+''''+'Update' +''''+'
			BEGIN
				UPDATE '+@Module_Name+'_Users
				SET UserID=@UserID,Region=@Domain,Account=@Account,BDM=@BDM,Email=@Email,Administrator=@Administrator,Enable=@Enable
				WHERE AutoID=@AutoID
			END
		IF @Operation='+''''+'Delete'+''''+'
			BEGIN
				DELETE '+@Module_Name+'_Users
				WHERE AutoID=@AutoID
			END

		IF @Operation='+''''+'Insert'+''''+' OR @Operation='+''''+'Update'+''''+'
			BEGIN
				--Initial users menus
				INSERT INTO '+@Module_Name+'_Authority (UserID,MenuID)
				SELECT b.UserID,a.ID
				FROM '+@Module_Name+'_Menu a,'+@Module_Name+'_Users b
				WHERE a.ID+b.UserID NOT IN (
									SELECT MenuID+UserID
									FROM  '+@Module_Name+'_Authority
									   )

				DELETE '+@Module_Name+'_Authority
				WHERE MenuID NOT IN (
								SELECT ID
								FROM '+@Module_Name+'_Menu
							 )

				--Initial Administrator authority
				UPDATE '+@Module_Name+'_Authority
				SET CanSee=1
				WHERE UserID IN
					(SELECT UserID FROM '+@Module_Name+'_Users WHERE Administrator=1)

				UPDATE '+@Module_Name+'_Authority
				SET CanSee=1
				WHERE MenuID IN ('+''''+'00001'+''''+')
			END'
	print @sqlString
	--EXECUTE(@sqlString)
--	
---- sp ShipmentReport_sp_Query_User_Authority_New
--	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Query_User_Authority_New]
--		@UserID			VARCHAR(100)=NULL,
--		@ParentMenuID	 	VARCHAR(200)=NULL
--	AS
--	/*----------------------------------------------------------------------------------------------
--	功能:	动态显示目录层次关系,以便前台用TREEVIEW显示目录架构.
--	时间:	2007-05-15
--	----------------------------------------------------------------------------------------------*/
--	SET NOCOUNT ON
--
--	IF @ParentMenuID IS NOT NULL AND @ParentMenuID <>'+''''+''''+'
--		BEGIN
--			SELECT f.ID AS NodeCode,
--				 f.Description AS NodeName,
--				 (
--					@ParentMenuID
--				 ) AS ParentNodeCode,
--				 (
--					SELECT COUNT (*)
--					FROM '+@Module_Name+'_Authority aa
--					WHERE aa.UserID=@UserID
--						AND aa.CanSee=1
--						AND LEN(aa.MenuID)=LEN(@ParentMenuID)+10
--						AND aa.MenuID LIKE  f.ID+'+''''+'%'+''''+'
--				) AS ChildNodeCount,
--				 a.CanSee
--			FROM '+@Module_Name+'_Authority a,'+@Module_Name+'_Menu f
--			WHERE a.UserID=@UserID
--				AND a.MenuID=f.ID
--				AND f.ID LIKE @ParentMenuID+'+''''+'%'+''''+'
--				AND LEN(f.ID)=LEN(@ParentMenuID)+5
--				--AND a.CanSee=1
--			ORDER BY f.ID
--		END
--	ELSE
--		BEGIN
--			SELECT f.ID AS NodeCode,
--				 f.Description AS NodeName,
--				 NULL AS ParentNodeCode,
--				 (
--					SELECT COUNT (*)
--					FROM '+@Module_Name+'_Authority aa
--					WHERE aa.UserID=@UserID
--						AND aa.CanSee=1
--						AND LEN(aa.MenuID)=10
--						AND aa.MenuID LIKE f.ID+'+''''+'%'+''''+'
--				) AS ChildNodeCount,
--				 a.CanSee
--			FROM '+@Module_Name+'_Authority a,'+@Module_Name+'_Menu f
--			WHERE a.UserID=@UserID
--				AND a.MenuID=f.ID
--				AND LEN(f.ID)=5
--				--AND a.CanSee=1
--			ORDER BY f.ID
--		END'
--	EXECUTE(@sqlString)
--
---- sp ShipmentReport_sp_Update_User_Authority
--	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Update_User_Authority]
--			@UserID VARCHAR(50),
--			@MenuID VARCHAR(50),
--			@CanSee BIT
--		AS
--
--		SET NOCOUNT ON
--
--		UPDATE '+@Module_Name+'_Authority
--		SET CanSee=@CanSee
--		WHERE UserID=@UserID
--			AND MenuID=@MenuID
--
--		UPDATE '+@Module_Name+'_Authority
--		SET CanSee=1
--		FROM '+@Module_Name+'_Authority a,'+@Module_Name+'_Users b
--		WHERE a.UserID=b.UserID
--			AND b.Administrator=1'
--	EXECUTE(@sqlString)
--
---- sp ShipmentReport_sp_Query_Role_Matrix
--
--	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Query_Role_Matrix] 
--			@Domain VARCHAR(50)=NULL,
--			@Account VARCHAR(50)=NULL,
--			@BDMGAM	VARCHAR(50)=NULL,
--			@Email	VARCHAR(50)=NULL
--		AS
--		BEGIN
--
--			SET NOCOUNT ON
--
--			SET @Domain=ISNULL(@Domain,'+''''+''''+')
--			SET @Domain='+''''+'%'+''''+'+RTRIM(LTRIM(@Domain))+'+''''+'%'+''''+'
--			SET @Account=ISNULL(@Account,'+''''+''''+')
--			SET @Account='+''''+'%'+''''+'+RTRIM(LTRIM(@Account))+'+''''+'%'+''''+'
--			SET @BDMGAM=ISNULL(@BDMGAM,'+''''+''''+')
--			SET @BDMGAM='+''''+'%'+''''+'+RTRIM(LTRIM(@BDMGAM))+'+''''+'%'+''''+'
--			SET @Email=ISNULL(@Email,'+''''+''''+')
--			SET @Email='+''''+'%'+''''+'+RTRIM(LTRIM(@Email))+'+''''+'%'+''''+'
--
--			-- Insert statements for procedure here
--			DECLARE @UserID VARCHAR(50),@UserBDM VARCHAR(200),@SQLString VARCHAR(5000)
--
--			SELECT ID,Description AS Roles
--			INTO #Temp
--			FROM '+@Module_Name+'_Menu
--			ORDER BY ID
--
--			DECLARE User_C CURSOR FOR
--			SELECT UserID,BDM+'+''''+'('+''''+'+UserID+'+''''+')'+''''+' AS UserBDM
--			FROM '+@Module_Name+'_Users
--			WHERE Region LIKE @Domain
--					AND Account LIKE @Account
--					AND BDM LIKE @BDMGAM
--					AND Email LIKE @Email
--
--			OPEN User_C
--			FETCH NEXT FROM User_C INTO @UserID,@UserBDM
--			WHILE @@FETCH_STATUS=0
--				BEGIN
--					SET @SQLString='+''''+'ALTER TABLE #Temp ADD ['+''''+'+@UserBDM+'+''''+']  BIT NULL'+''''+'
--					EXECUTE (@SQLString)
--					SET @SQLString='+''''+'UPDATE #Temp SET ['+''''+'+@UserBDM+'+''''+']=b.CanSee FROM #Temp a,'+@Module_Name+'_Authority b WHERE b.UserID='+''''+'+@UserID+'+''''+' AND a.ID=b.MenuID'+''''+'
--					EXECUTE (@SQLString)
--					FETCH NEXT FROM User_C INTO @UserID,@UserBDM
--				END
--
--			CLOSE User_C
--			DEALLOCATE User_C
--
--			SELECT * FROM #Temp
--		END'
--
--	EXECUTE(@sqlString)
--
---- sp ShipmentReport_sp_Update_User_Authority_New
--
--	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Update_User_Authority_New]
--			@UserID VARCHAR(50),
--			@MenuID VARCHAR(50),
--			@CanSee BIT
--		AS
--
--		SET NOCOUNT ON
--
--		UPDATE '+@Module_Name+'_Authority
--		SET CanSee=@CanSee
--		WHERE UserID=@UserID
--			AND MenuID=@MenuID
--
--		UPDATE '+@Module_Name+'_Authority
--		SET CanSee=@CanSee
--		WHERE UserID=@UserID
--			AND MenuID LIKE @MenuID+'+''''+'%'+''''+'
--
--		IF @CanSee=1
--			BEGIN
--				UPDATE '+@Module_Name+'_Authority SET CanSee=@CanSee WHERE UserID=@UserID AND MenuID=LEFT(@MenuID,5)
--				WHILE LEN(@MenuID)>=5
--					BEGIN
--						UPDATE '+@Module_Name+'_Authority
--						SET CanSee=@CanSee
--						WHERE UserID=@UserID
--							AND MenuID =LEFT(@MenuID,LEN(@MenuID)-5)
--
--						IF LEN(@MenuID)-10>0
--							BEGIN
--								SET @MenuID=LEFT(@MenuID,LEN(@MenuID)-10)
--							END
--						ELSE
--							BEGIN
--								SET @MenuID=''
--							END
--					END			
--			END
--
--		IF @CanSee=0
--			BEGIN
--				WHILE LEN(@MenuID)>=5
--					BEGIN
--						IF NOT EXISTS(SELECT * FROM ShipmentReport_Authority WHERE UserID=@UserID AND LEFT(MenuID,LEN(@MenuID)-5)=LEFT(@MenuID,LEN(@MenuID)-5) AND LEN(MenuID)=LEN(@MenuID) AND CanSee=1)
--							BEGIN
--								UPDATE ShipmentReport_Authority
--								SET CanSee=@CanSee
--								WHERE UserID=@UserID
--									AND MenuID =LEFT(@MenuID,LEN(@MenuID)-5)
--								SET @MenuID=LEFT(@MenuID,LEN(@MenuID)-5)
--							END
--						ELSE
--							BEGIN
--								BREAK
--							END
--					END
--			END
--
--		UPDATE ShipmentReport_Authority
--		SET CanSee=1
--		WHERE UserID=@UserID
--			AND MenuID IN ('+''''+'00001'+''''+','+''''+'00005'+''''+','+''''+'00006'+''''+')
--
--		UPDATE ShipmentReport_Authority
--		SET CanSee=1
--		FROM ShipmentReport_Authority a,ShipmentReport_Users b
--		WHERE a.UserID=b.UserID
--			AND b.Administrator=1'
--	EXECUTE(@sqlString)
--
---- sp ShipmentReport__sp_Query_Log
--
--	SET @sqlString = 'CREATE PROCEDURE [dbo].['+@Module_Name+'_sp_Query_Log]
--			@UserID VARCHAR(50),
--			@Operation VARCHAR(50),
--			@Remark VARCHAR(5000)
--		AS
--		BEGIN
--			SET NOCOUNT ON;
--			
--			SET @UserID='+''''+'%'+''''+'+LTRIM(RTRIM(@UserID))+'+''''+'%'+''''+'
--			SET @Operation='+''''+'%'+''''+'+LTRIM(RTRIM(@Operation))+'+''''+'%'+''''+'
--			SET @Remark='+''''+'%'+''''+'+ltrim(rtrim(@Remark))+'+''''+'%'+''''+'
--
--			SELECT a.* ,b.BDM+'+''''+' ('+''''+'+b.Account+'+''''+')'+''''+' AS OperatorName
--			FROM '+@Module_Name+'_Log a,'+@Module_Name+'_Users b
--			WHERE a.UserID=b.UserID
--				AND (a.UserID LIKE @UserID OR b.BDM LIKE @UserID)
--				AND a.Operation LIKE @Operation
--				AND a.Remark LIKE @Remark
--			ORDER BY a.AutoID DESC
--		END'
--	EXECUTE(@sqlString)
GO
