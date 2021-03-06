USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[Thin_ShipmentReport_sp_Get_Frank_Shipped_All_Data]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Thin_ShipmentReport_sp_Get_Frank_Shipped_All_Data] 
	@CatchDate INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @SQLString VARCHAR(MAX),@CatchDateFrom DATETIME,
			@SourceDatabase VARCHAR(50),@SourceTable VARCHAR(50),@SourceDataTextFile VARCHAR(50),
			@SourceDBUserID VARCHAR(50),@SourceDBUserPassword VARCHAR(50),@SourceLinkServer VARCHAR(50),
			@SourceZipFile VARCHAR(50),@SourceZipEXE VARCHAR(50),
			@NetUseDisk CHAR(3),@NetUseIP VARCHAR(100),@NetUseAccount VARCHAR(50),@NetUsePassword VARCHAR(50),@NetUseVDisk CHAR(2),
			@TargetUnZipEXE VARCHAR(50),@TargetFileFolder VARCHAR(50),@TargetDatabase VARCHAR(50),@TargetTable VARCHAR(50),
			@TargetDBUserID VARCHAR(50),@TargetDBUserPassword VARCHAR(50),@TargetLinkServer VARCHAR(50)

	IF @CatchDate IS NULL
		BEGIN
			SET @CatchDateFrom=DATEADD(DAY,-1825,GETDATE()-1)
		END
	ELSE
		BEGIN
			SET @CatchDateFrom=DATEADD(DAY,-@CatchDate,GETDATE()-1)
		END

	SET	@SourceDatabase='ODS_Corp'
	SET @SourceTable='vcr_For_RevenueReport_Shipped_All_New'
	SET @SourceDataTextFile='D:\ShippedAll_New.txt'
	SET @SourceDBUserID='RevenueUser'
	SET @SourceDBUserPassword='XiaGuangMary1!'
	SET @SourceLinkServer='[10.10.8.226]'
    SET @SourceZipFile='D:\ShippedAll_New.zip'
	SET @SourceZipEXE='D:\TransData\WinZip\WzZip.exe'
	SET @NetUseIP='HKGNT111.asia.ad.flextronics.com'
	SET @NetUseAccount='asia\lgzjzhan'
	SET @NetUsePassword='MaryXiaGuang2@'
	SET @NetUseVDisk='Z:'	
	SET @NetUseDisk='D$'	
	SET @TargetUnZipEXE='D:\TransDBProject\WinZip\WZUNZIP.EXE'
	SET @TargetFileFolder='D:\ShippedAll_New'
	SET @TargetDBUserID='sa'
	SET @TargetDBUserPassword='P@ssw0rd'	
	SET @TargetDatabase='Multek_SZ_New'
	SET @TargetTable='ShipmentReport_Shipped_All'
	--SET @TargetLinkServer='[HKGNT117.ASIA.AD.FLEXTRONICS.COM]'
	SET @TargetLinkServer='HKGNT111'

	SET @SQLString=''
	SET @SQLString=@SQLString+' IF EXISTS(SELECT * FROM SysObjects WHERE  Name ='+''''''+@SourceTable+''''''+')'
	SET @SQLString=@SQLString+'	 BEGIN'
	SET @SQLString=@SQLString+'		DROP VIEW '+@SourceTable
	SET @SQLString=@SQLString+'	 END'
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase+'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=@SQLString+' CREATE VIEW [dbo].['+@SourceTable+']'
	SET @SQLString=@SQLString+' AS'
	SET @SQLString=@SQLString+' SELECT a.Loc, CONVERT(VARCHAR(15),RTRIM(LTRIM(a.SONum))) AS SONum,CONVERT(NUMERIC(18,2),a.SOPos) AS SOPos,CONVERT(DATETIME,a.SHDate) AS SHDate,LTRIM(RTRIM(CONVERT(VARCHAR(15),a.CustNum))) AS CustNum,CONVERT(VARCHAR(100),RTRIM(LTRIM(ISNULL(a.InvCustName,'+''''''''''+')))) AS InvCustName,CONVERT(NUMERIC(18,2),a.ShBrds) AS ShBrds,CONVERT(NUMERIC(18,2),ISNULL(a.ShDols,0)) AS ShDols,CONVERT(VARCHAR(55),a.BaanItemNum) AS BaanItemNum,CONVERT(VARCHAR(100),RTRIM(LTRIM(ISNULL(a.[OEM Name],'+''''''''''+')))) AS [OEM Name],CONVERT(VARCHAR(100),RTRIM(LTRIM(ISNULL(a.[Customer Name],'+''''''''''+')))) AS [Customer Name],a.Lays,ISNULL(a.ShDols_loc,0) AS ShDols_loc,ISNULL(a.CostB_loc,0) AS CostB_loc,CONVERT(NUMERIC(18,2),a.ShipID) AS ShipID,CONVERT(VARCHAR(10),RTRIM(LTRIM(ISNULL(a.Plant,'+''''''''''+')))) AS Plant,a.SOType'
	SET @SQLString=@SQLString+' FROM ODS_Corp.dbo.vcr_Shipped_All a'
	SET @SQLString=@SQLString+' WHERE (a.Loc='+''''''+'Nfd'+''''''+'or a.Loc='+''''''+'Sao'+''''''+') AND a.SHDate>='+''''''+CONVERT(VARCHAR(10),@CatchDateFrom,120)+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase+'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)
	
	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' BCP '+@SourceDatabase+'.dbo.'+@SourceTable +' out '+@SourceDataTextFile+' -c -t -U '+@SourceDBUserID+' -P '+@SourceDBUserPassword+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' DEL '+@SourceZipFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' '+@SourceZipEXE+' '+@SourceZipFile+' '+@SourceDataTextFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''''+'net use * /del /y'+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''''+'net use '+@NetUseVDisk+' \\'+@NetUseIP+'\'+@NetUseDisk+' '+@NetUsePassword+' /user:'+@NetUseAccount+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''''+'Copy '+@SourceZipFile+' '+@NetUseVDisk+'\'+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''+' '+@TargetUnZipEXE+' -O '+@SourceZipFile+' '+@TargetFileFolder+''''
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' TRUNCATE TABLE '+@TargetTable
	EXECUTE (@SQLString)

	DROP TABLE ShipmentReport_Shipped_All

	CREATE TABLE [ShipmentReport_Shipped_All](
		[Loc] [varchar](3) NULL,
		[SONum] [varchar](15) NULL,
		[SOPos] [numeric](18, 4) NULL,
		[SHDate] [datetime] NULL,
		[CustNum] [varchar](15) NULL,
		[InvCustName] [varchar](100) NULL,
		[SHBrds] [numeric](18, 4) NULL,
		[SHDols] [numeric](18, 4) NULL,
		[BaanItemNum] [varchar](55) NULL,
		[OEM Name] [varchar](100) NULL,
		[Customer Name] [varchar](100) NULL,
		[Lays] [int] NULL,
		[SHDols_Loc] [FLOAT] NULL,
		[CostB_Loc] [numeric](18, 4) NULL,
		[ShipID] [numeric](18, 4) NULL,
		[Plant] [varchar](10) NULL,
		[SOType] [varchar](3) NULL)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''+'bcp '+@TargetDatabase+'.dbo.'+@TargetTable+' in '+@TargetFileFolder+'\ShippedAll_New.txt -c -t -U '+@TargetDBUserID+' -P '+@TargetDBUserPassword+''''
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' DEL '+@SourceZipFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' DEL '+@SourceDataTextFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''+' DEL '+@SourceZipFile+''''
	EXECUTE (@SQLString)

	CREATE NONCLUSTERED INDEX [Loc] ON [dbo].[ShipmentReport_Shipped_All] ([Loc] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [UpdateSHDate] ON [dbo].[ShipmentReport_Shipped_All] ([SoNum] ASC,[SOPOS] ASC,[SHIPID] ASC,[LOC] ASC ,[CustNum] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [UpdateRealOEMCustomer] ON [dbo].[ShipmentReport_Shipped_All] ([OEM Name] ASC,[InvCustName] ASC,[LOC] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

	SELECT a.*
	INTO #Temp1
	FROM (
			/*
			SELECT a.Loc,a.SONum,a.SOPos,CONVERT(VARCHAR(10),b.T$INVD,120) AS SHDate,a.CustNum AS CustNum,ISNULL(a.InvCustName,'') AS InvCustName,a.ShBrds,a.ShDols,a.BaanItemNum,RTRIM(LTRIM(ISNULL(a.[OEM Name],''))) AS [OEM Name],RTRIM(LTRIM(ISNULL(a.[Customer Name],''))) AS [Customer Name],a.Lays,a.ShDols_loc,a.CostB_loc,a.ShipID,RTRIM(LTRIM(ISNULL(a.Plant,''))) AS Plant,a.SOType
			FROM ShipmentReport_Shipped_All a,HKGNT117.multekchi_realtime.dbo.TTDSLS045180 b
			WHERE a.SoNum =b.t$orno 
					and a.SOPos = b.t$pono 
					and a.shipID = b.T$SRNB
					AND a.Loc='Chi'
					AND a.CustNum <> 'ATL'
			UNION ALL
			SELECT a.Loc,a.SONum,a.SOPos,CONVERT(VARCHAR(10),b.T$TRDT,120) AS SHDate,a.CustNum AS CustNum,ISNULL(a.InvCustName,'') AS InvCustName,a.ShBrds,a.ShDols,RTRIM(LTRIM(a.BaanItemNum)) AS BaanItemNum,RTRIM(LTRIM(ISNULL(a.[OEM Name],''))) AS [OEM Name],RTRIM(LTRIM(ISNULL(a.[Customer Name],''))) AS [Customer Name],a.Lays,a.ShDols_loc,a.CostB_loc,a.ShipID,RTRIM(LTRIM(ISNULL(a.Plant,''))) AS Plant,a.SOType
			FROM ShipmentReport_Shipped_All a,HKGNT117.multekchi_realtime.dbo.TFHACR051183 b
			WHERE a.SoNum =b.T$SORN 
					and a.SOPos = b.T$SPON 
					and a.shipID = b.T$SRNB
					AND a.Loc='Chi'
					AND a.CustNum = 'ATL'
			UNION ALL
			*/
			/*
			SELECT 'Chi' AS Loc,CONVERT(VARCHAR(15),a.t$orno) AS SONum,a.t$pono	AS SOPos,CONVERT(DATETIME,CONVERT(VARCHAR(10),a.t$invd,120))AS SHDate	,a.t$cuno  AS CustNum ,ISNULL(a.t$cunm,'')  AS InvCustName	,a.t$dqua AS ShBrds	,a.t$amnt AS ShDols	,a.t$item AS BaanItemNum,RTRIM(LTRIM(ISNULL(a.t$endc,'')))	AS [OEM Name],RTRIM(LTRIM(ISNULL(a.t$cunm,'')))	AS [Customer Name]	,
			dbo.ShipmentReport_fun_Get_Layers(a.t$item) AS Lays,	
			a.t$amnt AS	ShDols_loc,	b.T$COPR AS CostB_Loc,t$srnb AS ShipID,	RTRIM(LTRIM(ISNULL(c.T$PLNT,''))) AS Plant,a.t$cotp AS SOType,a.T$Area
			FROM HKGNT117.multekchi_realtime.dbo.tfsolp101180 a,
				 (
					SELECT t$item,T$COPR FROM HKGNT117.FactoryLoading.dbo.TTIITM001180
					--UNION
					--SELECT t$item,T$COPR FROM HKGNT117.FactoryLoading.dbo.TTIITM001183
				 ) b,
				 (
					SELECT t$cwar,T$PLNT FROM HKGNT117.FactoryLoading.dbo.TFSCPP201180 
					UNION 
					SELECT t$cwar,T$PLNT FROM HKGNT117.FactoryLoading.dbo.TFSCPP201183					
				 ) c
			WHERE a.t$item=b.T$ITEM
				AND a.t$cwar=c.t$cwar
			UNION ALL
			*/
			SELECT a.Loc,a.SONum,a.SOPos,CONVERT(VARCHAR(10),a.SHDate,120) AS SHDate,a.CustNum AS CustNum,ISNULL(a.InvCustName,'') AS InvCustName,a.ShBrds,a.ShDols,a.BaanItemNum,RTRIM(LTRIM(ISNULL(a.[OEM Name],''))) AS [OEM Name],RTRIM(LTRIM(ISNULL(a.[Customer Name],''))) AS [Customer Name],a.Lays,a.ShDols_loc,a.CostB_loc,a.ShipID,RTRIM(LTRIM(ISNULL(a.Plant,''))) AS Plant,a.SOType,0 AS T$Area
			FROM ShipmentReport_Shipped_All a
		) a
	CREATE NONCLUSTERED INDEX [Temp1OEMCustomerLoc] ON [dbo].[#Temp1] ([Loc] ASC,[OEM Name] ASC,[InvCustName] ASC )WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		
	SELECT a.*,b.Real_OEM ,b.Real_Customer,IDENTITY(int, 1,1) AS AutoID
	INTO #Temp
	FROM #Temp1 a,
		ShipmentReport_OEM_Customer b
	WHERE a.[OEM Name]*=b.Baan_OEM
	AND a.InvCustName*=b.Baan_Customer
	AND a.Loc*=b.Baan_Loc

	DROP TABLE ShipmentReport_Shipped_All

	CREATE TABLE [ShipmentReport_Shipped_All](
		[Loc] [varchar](3) NULL,
		[SONum] [varchar](15) NULL,
		[SOPos] [numeric](18, 4) NULL,
		[SHDate] [datetime] NULL,
		[CustNum] [varchar](15) NULL,
		[InvCustName] [varchar](100) NULL,
		[SHBrds] [numeric](18, 4) NULL,
		[SHDols] [FLOAT] NULL,
		[BaanItemNum] [varchar](55) NULL,
		[OEM Name] [varchar](100) NULL,
		[Customer Name] [varchar](100) NULL,
		[Lays] [int] NULL,
		[SHDols_Loc] [numeric](18, 4) NULL,
		[CostB_Loc] [numeric](18, 4) NULL,
		[ShipID] [numeric](18, 4) NULL,
		[Plant] [varchar](10) NULL,
		[SOType] [varchar](3) NULL,
		[Area] [numeric](18, 4) NULL,
		[Real_OEM] [varchar](100) NULL,
		[Real_Customer] [varchar](100) NULL,
		[AutoID] [INT] ,
		 CONSTRAINT [PK_ShipmentReport_Shipped_All] PRIMARY KEY CLUSTERED 
		(
			[AutoID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		) ON [PRIMARY]

	INSERT INTO ShipmentReport_Shipped_All
	SELECT * FROM #Temp WHERE SHDate<=CONVERT(VARCHAR(10),GETDATE()-1,120)

	CREATE NONCLUSTERED INDEX [UpdateSHDate] ON [dbo].[ShipmentReport_Shipped_All] ([SoNum] ASC,[SOPOS] ASC,[SHIPID] ASC,[LOC] ASC ,[CustNum] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [UpdateRealOEMCustomer] ON [dbo].[ShipmentReport_Shipped_All] ([OEM Name] ASC,[InvCustName] ASC,[LOC] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [ShDols] ON [ShipmentReport_Shipped_All]([ShDols] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateRealOEM] ON [dbo].[ShipmentReport_Shipped_All] ([ShDate] ASC,[Real_OEM] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateRealCustomer] ON [dbo].[ShipmentReport_Shipped_All] ([ShDate] ASC,[Real_Customer] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateLocPlant] ON [dbo].[ShipmentReport_Shipped_All] ([ShDate] ASC,[Loc] ASC,[Plant] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateLoc] ON [dbo].[ShipmentReport_Shipped_All] ([ShDate] ASC,[Loc] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateLays] ON [dbo].[ShipmentReport_Shipped_All] ([ShDate] ASC,[Lays] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDate] ON [dbo].[ShipmentReport_Shipped_All] ([ShDate] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [OEM] ON [dbo].[ShipmentReport_Shipped_All] ([OEM Name] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [CustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] ([Customer Name] ASC,[Loc] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [RealOEM] ON [dbo].[ShipmentReport_Shipped_All] ([Real_OEM] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [RealCustomer] ON [dbo].[ShipmentReport_Shipped_All] ([Real_Customer] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [Plant] ON [dbo].[ShipmentReport_Shipped_All] ([Plant] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [Loc] ON [dbo].[ShipmentReport_Shipped_All] ([Loc] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [Lays] ON [dbo].[ShipmentReport_Shipped_All] ([Lays] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [invCustomer] ON [dbo].[ShipmentReport_Shipped_All] ([InvCustName] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [CustNum] ON [dbo].[ShipmentReport_Shipped_All] ([CustNum] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateRealCustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] ([Loc] ASC,[Real_Customer] ASC,[SHDate] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateRealCustomerLocPlant] ON [dbo].[ShipmentReport_Shipped_All] ([Loc] ASC,[Plant] ASC,[Real_Customer] ASC,[SHDate] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateRealOEMLoc] ON [dbo].[ShipmentReport_Shipped_All](	[Loc] ASC,[Real_OEM] ASC,[SHDate] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [SHDateRealOEMLocPlant] ON [dbo].[ShipmentReport_Shipped_All]([Loc] ASC,[Plant] ASC,[Real_OEM] ASC,[SHDate] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [LocPlantSHDateSOType] ON [dbo].[ShipmentReport_Shipped_All]([SHDate] ASC,[Loc] ASC,[Plant] ASC,[SOType] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [LocPlantSOTypeSHDateBaanItem] ON [dbo].[ShipmentReport_Shipped_All]([SHDate] ASC,[Loc] ASC,[Plant] ASC,[SOType] ASC,[BaanItemNum] ASC )WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [LocPlantSOTypeSHDateCustomer] ON [dbo].[ShipmentReport_Shipped_All]([Loc] ASC,	[Plant] ASC,	[SOType] ASC,	[SHDate] ASC,	[Real_Customer] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	CREATE NONCLUSTERED INDEX [LocPlantSOTypeSHDateOEM] ON [dbo].[ShipmentReport_Shipped_All]([Loc] ASC,	[Plant] ASC,	[SOType] ASC,	[SHDate] ASC,	[Real_OEM] ASC)WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	
	/*
	ALTER INDEX [PK_ShipmentReport_Shipped_All] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [UpdateSHDate] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [UpdateRealOEMCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [ShDols] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateRealOEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateRealCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateLays] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDate] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [OEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [CustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [RealOEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [RealCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [Plant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [Loc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [Lays] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [invCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [CustNum] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateRealCustomerLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateRealCustomerLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateRealOEMLoc] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [SHDateRealOEMLocPlant] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [LocPlantSHDateSOType] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [LocPlantSOTypeSHDateCustomer] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	ALTER INDEX [LocPlantSOTypeSHDateOEM] ON [dbo].[ShipmentReport_Shipped_All] REBUILD PARTITION = ALL WITH ( PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, ONLINE = OFF, SORT_IN_TEMPDB = OFF )
	*/
	--DBCC SHRINKFILE (N'TestDB_Data' , 0)
	--DBCC SHRINKFILE (N'TestDB_Log' , 0)

END
GO
