USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSDelinquent]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MSSDelinquent]

as
begin
	--CurrentDate
	DECLARE @CurrentDay DATETIME
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]


	--#Delinquent
	if (select object_ID('tempdb..#Delinquent')) >0 
		DROP TABLE [#Delinquent]
	SELECT 
		[OEM]
		,[Plant]
		,SUM([Amount])AS [Amount]
	INTO [#Delinquent]
	FROM  [MSS_Delinquent]
	WHERE [T$JDAT]= @CurrentDay
	GROUP BY [OEM],[Plant]
	
	--#DelinquentByOEM
	IF (select object_ID('tempdb..#DelinquentByOEM')) >0 
		DROP TABLE [#DelinquentByOEM]
	CREATE TABLE [#DelinquentByOEM] (
		[OEM] VARCHAR(50)
		,[B1] NUMERIC(19,4)
		,[B2F] NUMERIC(19,4)
		,[B3] NUMERIC(19,4)
		,[B4] NUMERIC(19,4)
		,[B5] NUMERIC(19,4)
		,[VVI+SUB] NUMERIC(19,4)
		,[Overall] NUMERIC(19,4)
	)
	
	DECLARE @temp varchar(50)--临时变量，用来保存游标值  
	--申明游标 
	DECLARE order_cursor CURSOR FOR SELECT [OEM] FROM [#Delinquent] GROUP BY [OEM]
	--打开游标  
	OPEN order_cursor 
	 FETCH NEXT FROM order_cursor INTO @temp   
	 WHILE @@FETCH_STATUS = 0 --返回被 FETCH  语句执行的最后游标的状态，而不是任何当前被连接打开的游标的状态。  
	  BEGIN  
		--执行sql操作
		INSERT INTO [#DelinquentByOEM]
		SELECT  
				@temp AS [OEM]
				,SUM(CASE WHEN [Plant] = 'B1' THEN [Amount] ELSE 0 END) AS B1
				,SUM(CASE WHEN [Plant] = '2F' THEN [Amount] ELSE 0 END) AS B2F
				,SUM(CASE WHEN [Plant] = 'B3' THEN [Amount] ELSE 0 END) AS B3
				,SUM(CASE WHEN [Plant] = 'B4' THEN [Amount] ELSE 0 END) AS B4
				,SUM(CASE WHEN [Plant] = 'B5' THEN [Amount] ELSE 0 END) AS B5
				,SUM(CASE WHEN [Plant] = 'HK' THEN [Amount] ELSE 0 END) AS [VVI+SUB]
				,0 AS [Overall]
		FROM [#Delinquent]
		WHERE [OEM]=@temp
		
		
		--开始循环游标变量  
		FETCH NEXT FROM order_cursor INTO @temp  
	   
	  END  

	CLOSE order_cursor--关闭游标  
	DEALLOCATE order_cursor--释放游标
	
	UPDATE [#DelinquentByOEM] SET[Overall]=([B1]+[B2F]+[B3]+[B4]+[B5]+[VVI+SUB])
	
	
	SELECT 
		'Overall' AS [OEM]
		,SUM([B1]) AS [B1]
		,SUM([B2F]) AS [B2F]
		,SUM([B3]) AS [B3]
		,SUM([B4]) AS [B4]
		,SUM([B5]) AS [B5]
		,SUM([VVI+SUB]) AS [VVI+SUB]
		,SUM([Overall]) AS [Overall]
	FROM  [#DelinquentByOEM]
	UNION ALL
	SELECT 
		[OEM]
		,[B1]
		,[B2F]
		,[B3]
		,[B4]
		,[B5]
		,[VVI+SUB]
		,[Overall]
	FROM  [#DelinquentByOEM]
	
	
	--Delete Table
	DROP TABLE [#Delinquent]
	DROP TABLE [#DelinquentByOEM]


	
end









GO
