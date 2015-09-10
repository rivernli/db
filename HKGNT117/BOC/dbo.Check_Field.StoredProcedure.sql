USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Check_Field]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Check_Field]
@FieldName nvarchar(50) = null,
@UserName nvarchar(50) =null ,
@Result nvarchar(100) =null output
as
declare @sqlstr varchar(8000)
begin 
		--set @FieldName = '1'
--		set @sqlstr = 'select top 1 @Result = '+@FieldName+ ' from dbo.tfsboc103180_analyse where [user] = '+@UserName  
--		exec(@sqlstr)		
--		select 	@Result
--		select top 1 @Result = BOC_Item1 from dbo.tfsboc103180_analyse where [user] = @UserName

--		set @sqlstr = 'select top 1  @Result = '+@FieldName+ ' from dbo.tfsboc103180_analyse where [user] = '+@UserName  
--		exec(@sqlstr)
--		if @@rowcount > 0 
--			set @Result = @FieldName
--		else
--			set @FieldName = ''
		
	if @FieldName = 'BOC_Item1'
		select top 1 @Result = BOC_Item1 from dbo.tfsboc103180_analyse where [user] = @UserName

	if @FieldName = 'BOC_Item2'
		select top 1 @Result = BOC_Item2 from dbo.tfsboc103180_analyse where [user] = @UserName

	if @FieldName = 'BOC_Item3'
		select top 1 @Result = BOC_Item3 from dbo.tfsboc103180_analyse where [user] = @UserName

	if @FieldName = 'BOC_Item4'
		select top 1 @Result = BOC_Item4 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item5'
		select top 1 @Result = BOC_Item5 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item6'
		select top 1 @Result = BOC_Item6 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item7'
		select top 1 @Result = BOC_Item7 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item8'
		select top 1 @Result = BOC_Item8 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item9'
		select top 1 @Result = BOC_Item9 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item10'
		select top 1 @Result = BOC_Item10 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item11'
		select top 1 @Result = BOC_Item11 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item12'
		select top 1 @Result = BOC_Item12 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item13'
		select top 1 @Result = BOC_Item13 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item14'
		select top 1 @Result = BOC_Item14 from dbo.tfsboc103180_analyse where [user] = @UserName
	if @FieldName = 'BOC_Item15'
		select top 1 @Result = BOC_Item15 from dbo.tfsboc103180_analyse where [user] = @UserName
end






GO
