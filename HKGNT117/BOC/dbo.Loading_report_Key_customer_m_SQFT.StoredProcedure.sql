USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_Key_customer_m_SQFT]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Loading_report_Key_customer_m_SQFT]
@User nvarchar(50)
as 
begin
	-- update output percent by ver customer
	update tfsboc103180_analyse set output_percent = output_sqft / (select sum(output_sqft) from tfsboc103180_analyse where customer not like N'Total'+'%')
	where customer not like N'Total'+'%'
	and [User] = @User

	-- Update total SQFT 
	update tfsboc103180_analyse set output_sqft = (select sum(output_sqft) from tfsboc103180_analyse where customer not like N'Total'+'%')
	where customer = 'Total'
	and [User] = @User
end

GO
