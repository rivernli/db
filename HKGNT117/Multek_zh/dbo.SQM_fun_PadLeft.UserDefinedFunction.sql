USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[SQM_fun_PadLeft]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[SQM_fun_PadLeft](@num nvarchar(20),@paddingChar VARCHAR(5),@totalWidth int)

returns nvarchar(20) as

begin

declare @curStr nvarchar(20)

select @curStr = isnull(replicate(@paddingChar,@totalWidth - len(isnull(@num ,0))), '') + @num

return @curStr

end


GO
