USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[B2B_OrderIntake]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc  [dbo].[B2B_OrderIntake]
@plnt char(2),
@fdate  nvarchar(30),
@tdate  nvarchar(30)
as
declare @Total float
declare @new float
declare @PriceChange float
declare @OnHold float
declare @Release float
if @plnt = 'al'
	select @new = sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'Order Intake' and T$trdt between @fdate and @tdate   
else
	select @new = sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'Order Intake' and T$plnt = @plnt and T$trdt between @fdate and @tdate   
	
if @plnt = 'al'	
	select @PriceChange = sum(T$mamn)-sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'Price Change'  and T$trdt between @fdate and @tdate 
else	
	select @PriceChange = sum(T$mamn)-sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'Price Change' and T$plnt = @plnt and T$trdt between @fdate and @tdate 

if @plnt = 'al' 
	select @OnHold = sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'MKT-On Hold'  and T$trdt between @fdate and @tdate  
else
	select @OnHold = sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'MKT-On Hold' and T$plnt = @plnt and T$trdt between @fdate and @tdate  
	
if @plnt = 'al' 
	select @Release = sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'MKT-Release'  and T$trdt between @fdate and @tdate  
else
	select @Release = sum(T$mamt)  from  dbo.TFSOLP121180  where T$DESC = 'MKT-Release' and T$plnt = @plnt and T$trdt between @fdate and @tdate  

select isnull(@New,0) as New,isnull(@PriceChange,0) as PriceChange,isnull(@OnHold,0) as OnHold,isnull(@Release,0) as Release,isnull(@New,0)+isnull(@PriceChange,0) - isnull(@OnHold,0) + isnull(@Release,0) as OrderIntake
GO
