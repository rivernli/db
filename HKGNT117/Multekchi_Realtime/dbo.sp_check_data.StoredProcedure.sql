USE [multekchi_realtime]
GO
/****** Object:  StoredProcedure [dbo].[sp_check_data]    Script Date: 2014/11/12 17:13:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_check_data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.

    -- Insert statements for procedure here
	set nocount on
	select a.*
	into #temp1
	from uvw_jgzhang_test a,
	(
	select a.sonum,a.sopos,a.shipid
	from dbo.uvw_jgzhang_test a,dbo.frank_shipped_all_china b
	where a.sonum=b.sonum
		and a.sopos=b.sopos
		and a.shipid=b.shipid
		and a.shdate between '2008-01-01' and '2012-05-04'
	group by a.sonum,a.sopos,a.shipid
	) b
	where a.sonum=b.sonum
		and a.sopos=b.sopos
		and a.shipid=b.shipid
		and a.shdate between '2008-01-01' and '2012-05-04'
	select a.*
	into #temp2
	from dbo.frank_shipped_all_china a,
	(
	select a.sonum,a.sopos,a.shipid
	from dbo.uvw_jgzhang_test a,dbo.frank_shipped_all_china b
	where a.sonum=b.sonum
		and a.sopos=b.sopos
		and a.shipid=b.shipid
		and a.shdate between '2008-01-01' and '2012-05-04'
	group by a.sonum,a.sopos,a.shipid
	) b
	where a.sonum=b.sonum
		and a.sopos=b.sopos
		and a.shipid=b.shipid
		and a.shdate between '2008-01-01' and '2012-05-04'

	create table #temp3 (num int)
	create table #temp4 (field varchar(50))

	DECLARE @SQLString VARCHAR(8000) ,@FieldName VARCHAR(50),@FieldDataType VARCHAR(50),@FieldIsNullAble BIT,@FieldLength INT
	DECLARE Table_Strcuture_C CURSOR FOR
	SELECT Column_Name FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='uvw_jgzhang_test' 
	OPEN Table_Strcuture_C
	FETCH NEXT FROM Table_Strcuture_C INTO @FieldName
	WHILE @@FETCH_STATUS=0
		BEGIN
			set @FieldName =(case when @FieldName ='oem name' then '[oem name]' when @FieldName ='customer name' then '[customer name]' else @FieldName  end)
			if @FieldName <>'salesman'
				begin
					truncate table #temp3
					SET @SQLString='insert into #temp3 select count(*) from uvw_jgzhang_test a,dbo.frank_shipped_all_china b where a.sonum=b.sonum	and a.sopos=b.sopos	and a.shipid=b.shipid and a.shdate between '+''''+'2008-01-01'+''''+' and '+''''+'2012-05-04'+''''+' and a.'+@FieldName+'<>b.'+@FieldName
					EXECUTE (@SQLSTRING)
					if (select num from #temp3)<>0
						begin
							insert into #temp4 values(@fieldname)
						end
			end
			FETCH NEXT FROM Table_Strcuture_C INTO @FieldName 
		END
	CLOSE Table_Strcuture_C
	DEALLOCATE Table_Strcuture_C

	select * from #temp4
END

GO
