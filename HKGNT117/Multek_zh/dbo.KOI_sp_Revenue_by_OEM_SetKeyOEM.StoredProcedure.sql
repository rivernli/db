USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[KOI_sp_Revenue_by_OEM_SetKeyOEM]  

@Plant NVARCHAR(20),
@Sale NVARCHAR(20) 
as

declare @SQLString VARCHAR(MAX),@QuertString VARCHAR(MAX)	

IF @Plant='All'
		BEGIN
		SET @QuertString = ' T$PLNT<>''HK'' '
		END
	ELSE 
	IF @Plant='Allexclude2F'
		BEGIN
		SET @QuertString=' T$PLNT<>''HK'' and T$PLNT<>''2F'' '
		END
	ELSE 
		BEGIN
		SET @QuertString=' T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) '
		END


IF @Sale='FGIn'
BEGIN
	SET @SQLString='select T$CSGS as OEM from TFSOLP107180 where '+@QuertString+'  group by T$CSGS order by T$CSGS '
END

IF @Sale='FGOut'
BEGIN
	SET @SQLString='select T$CSGS as OEM from TFSOLP105180 where '+@QuertString+' group by T$CSGS order by T$CSGS '
END

IF @Sale='Invoice'
BEGIN
	SET @SQLString='select T$CSGS as OEM from TFSOLP106180 where '+@QuertString+' group by T$CSGS order by T$CSGS '
END

exec(@SQLString)

GO
