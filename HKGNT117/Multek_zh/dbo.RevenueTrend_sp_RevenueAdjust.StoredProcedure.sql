USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[RevenueTrend_sp_RevenueAdjust]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[RevenueTrend_sp_RevenueAdjust] 	
		@ID INT=NULL,
		@FiscalYear VARCHAR(50),
		@Plant VARCHAR(50),
		@Period VARCHAR(50),
		@sales_Local_sum decimal(18,3)=null,
		@salesOversea_sum decimal(18,3)=null,
		@sales_Total_Consol decimal(18,3)=null,
		@Scrap_Local_sum decimal(18,3)=null,
		@Scrap_Oversea_sum decimal(18,3)=null,
		@Scrap_Total_Consol decimal(18,3)=null,
		@Local_TotalSales decimal(18,3)=null,
		@Oversea_TotalSales decimal(18,3)=null,
		@TotalSales_Consol decimal(18,3)=null,
		@Automatic_posting_Local decimal(18,3)=null,
		@Automatic_posting_Oversea decimal(18,3)=null,
		@DirectPO_Local decimal(18,3)=null,
		@DirectPO_Oversea decimal(18,3)=null,
		@SalesTools_Local decimal(18,3)=null,
		@SalesTools_Oversea decimal(18,3)=null,
		@RMA_Local decimal(18,3)=null,
		@RMA_Oversea decimal(18,3)=null,
		@Hub_Local decimal(18,3)=null,
		@Hub_Oversea decimal(18,3)=null,
		@Manual_Local decimal(18,3)=null,
		@Manual_Oversea decimal(18,3)=null,
		@Sorting_Local decimal(18,3)=null,
		@Sorting_Oversea decimal(18,3)=null,
		@Manual_RMA_Local decimal(18,3)=null,
		@Manual_RMA_Oversea decimal(18,3)=null,
		@RecoveryCost_Local decimal(18,3)=null,
		@RecoveryCost_Oversea decimal(18,3)=null,
		@DDU_CIF_Local decimal(18,3)=null,
		@DDU_CIF_Oversea decimal(18,3)=null,
		@IBMRebate_Local decimal(18,3)=null,
		@IBMRebate_Oversea decimal(18,3)=null,
		@rejectinvoices_Local decimal(18,3)=null,
		@rejectinvoices_Oversea decimal(18,3)=null,
		@DreditNotes_Local decimal(18,3)=null,
		@DreditNotes_Oversea decimal(18,3)=null,
		@Creditcharge_Local decimal(18,3)=null,
		@Creditcharge_Oversea decimal(18,3)=null,
		@Processingcharge_Local decimal(18,3)=null,
		@Processingcharge_Oversea decimal(18,3)=null,
		@AdjRMA_Local decimal(18,3)=null,
		@AdjRMA_Oversea decimal(18,3)=null,
		@ScrapSales_Local decimal(18,3)=null,
		@ScrapSales_Oversea decimal(18,3)=null,
		@ScrapSales_in_Local decimal(18,3)=null,
		@ScrapSales_in_Oversea decimal(18,3)=null,
		@Sales_matchledgers_Local decimal(18,3)=null,
		@Sales_matchledgers_Oversea decimal(18,3)=null,		
		@Initiator NVARCHAR(50), 
		@Operation VARCHAR(10)
AS
IF @Operation='Insert' 
	BEGIN
		INSERT INTO RevenueTrend_RevenueAdjust 
           ([FiscalYear] ,[Plant] ,[Period] ,[sales_Local_sum],[salesOversea_sum],[sales_Total_Consol],[Scrap_Local_sum],[Scrap_Oversea_sum],[Scrap_Total_Consol]
           ,[Local_TotalSales],[Oversea_TotalSales],[TotalSales_Consol],[Automatic_posting_Local],[Automatic_posting_Oversea],[DirectPO_Local],[DirectPO_Oversea]
           ,[SalesTools_Local],[SalesTools_Oversea],[RMA_Local],[RMA_Oversea],[Hub_Local],[Hub_Oversea],[Manual_Local],[Manual_Oversea],[Sorting_Local]
           ,[Sorting_Oversea],[Manual_RMA_Local],[Manual_RMA_Oversea],[RecoveryCost_Local],[RecoveryCost_Oversea],[DDU_CIF_Local],[DDU_CIF_Oversea],[IBMRebate_Local]
           ,[IBMRebate_Oversea],[rejectinvoices_Local],[rejectinvoices_Oversea] ,[DreditNotes_Local],[DreditNotes_Oversea],[Creditcharge_Local],[Creditcharge_Oversea]
           ,[Processingcharge_Local],[Processingcharge_Oversea],[AdjRMA_Local],[AdjRMA_Oversea],[ScrapSales_Local],[ScrapSales_Oversea]
           ,[ScrapSales_in_Local] ,[ScrapSales_in_Oversea],[Sales_matchledgers_Local],[Sales_matchledgers_Oversea],[Initiator])
	    VALUES (@FiscalYear ,@Plant ,@Period ,@sales_Local_sum,@salesOversea_sum,@sales_Total_Consol,@Scrap_Local_sum,@Scrap_Oversea_sum,@Scrap_Total_Consol 
           , @Local_TotalSales,@Oversea_TotalSales,@TotalSales_Consol,@Automatic_posting_Local,@Automatic_posting_Oversea,@DirectPO_Local,@DirectPO_Oversea 
           , @SalesTools_Local,@SalesTools_Oversea,@RMA_Local,@RMA_Oversea,@Hub_Local,@Hub_Oversea,@Manual_Local,@Manual_Oversea,@Sorting_Local 
           , @Sorting_Oversea,@Manual_RMA_Local,@Manual_RMA_Oversea,@RecoveryCost_Local,@RecoveryCost_Oversea,@DDU_CIF_Local,@DDU_CIF_Oversea,@IBMRebate_Local 
           , @IBMRebate_Oversea,@rejectinvoices_Local,@rejectinvoices_Oversea ,@DreditNotes_Local,@DreditNotes_Oversea,@Creditcharge_Local,@Creditcharge_Oversea 
           , @Processingcharge_Local,@Processingcharge_Oversea,@AdjRMA_Local,@AdjRMA_Oversea,@ScrapSales_Local,@ScrapSales_Oversea 
           , @ScrapSales_in_Local ,@ScrapSales_in_Oversea,@Sales_matchledgers_Local,@Sales_matchledgers_Oversea,@Initiator)
	
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE RevenueTrend_RevenueAdjust
		SET  FiscalYear=@FiscalYear ,Plant=@Plant ,Period=@Period ,sales_Local_sum=@sales_Local_sum, salesOversea_sum=@salesOversea_sum, sales_Total_Consol=@sales_Total_Consol, Scrap_Local_sum=@Scrap_Local_sum, Scrap_Oversea_sum=@Scrap_Oversea_sum, Scrap_Total_Consol=@Scrap_Total_Consol 
           , Local_TotalSales=@Local_TotalSales, Oversea_TotalSales=@Oversea_TotalSales, TotalSales_Consol=@TotalSales_Consol, Automatic_posting_Local=@Automatic_posting_Local, Automatic_posting_Oversea=@Automatic_posting_Oversea, DirectPO_Local=@DirectPO_Local, DirectPO_Oversea=@DirectPO_Oversea 
           , SalesTools_Local=@SalesTools_Local, SalesTools_Oversea=@SalesTools_Oversea, RMA_Local=@RMA_Local, RMA_Oversea=@RMA_Oversea, Hub_Local=@Hub_Local, Hub_Oversea=@Hub_Oversea, Manual_Local=@Manual_Local, Manual_Oversea=@Manual_Oversea, Sorting_Local=@Sorting_Local 
           , Sorting_Oversea=@Sorting_Oversea, Manual_RMA_Local=@Manual_RMA_Local, Manual_RMA_Oversea=@Manual_RMA_Oversea, RecoveryCost_Local=@RecoveryCost_Local, RecoveryCost_Oversea=@RecoveryCost_Oversea, DDU_CIF_Local=@DDU_CIF_Local,DDU_CIF_Oversea=@DDU_CIF_Oversea,IBMRebate_Local=@IBMRebate_Local 
           , IBMRebate_Oversea=@IBMRebate_Oversea, rejectinvoices_Local=@rejectinvoices_Local, rejectinvoices_Oversea=@rejectinvoices_Oversea , DreditNotes_Local=@DreditNotes_Local, DreditNotes_Oversea=@DreditNotes_Oversea, Creditcharge_Local=@Creditcharge_Local, Creditcharge_Oversea=@Creditcharge_Oversea 
           , Processingcharge_Local=@Processingcharge_Local, Processingcharge_Oversea=@Processingcharge_Oversea, AdjRMA_Local=@AdjRMA_Local, AdjRMA_Oversea=@AdjRMA_Oversea, ScrapSales_Local=@ScrapSales_Local, ScrapSales_Oversea=@ScrapSales_Oversea 
           , ScrapSales_in_Local=@ScrapSales_in_Local , ScrapSales_in_Oversea=@ScrapSales_in_Oversea, Sales_matchledgers_Local=@Sales_matchledgers_Local, Sales_matchledgers_Oversea=@Sales_matchledgers_Oversea 
		WHERE ID=@ID 	
	return @ID 
	END





















GO
