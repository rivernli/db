USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sgp_history]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sgp_history](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[salesman] [nvarchar](50) NULL,
	[rfq] [nvarchar](20) NULL,
	[indate] [varchar](50) NULL,
	[outdate] [varchar](50) NULL,
	[OEM] [nvarchar](50) NULL,
	[CEM] [nvarchar](50) NULL,
	[name] [nvarchar](150) NULL,
	[programme] [nvarchar](150) NULL,
	[PN] [sql_variant] NULL,
	[tPN] [nvarchar](50) NULL,
	[rev] [nvarchar](50) NULL,
	[product] [nvarchar](150) NULL,
	[width] [nvarchar](50) NULL,
	[length] [nvarchar](50) NULL,
	[unit] [nvarchar](50) NULL,
	[arraywidth] [nvarchar](50) NULL,
	[arraylength] [nvarchar](50) NULL,
	[unitperarray] [nvarchar](50) NULL,
	[prodwidth] [nvarchar](50) NULL,
	[prodlength] [nvarchar](50) NULL,
	[unitperprod] [nvarchar](50) NULL,
	[matl_percentage] [nvarchar](50) NULL,
	[layers] [nvarchar](150) NULL,
	[holes] [nvarchar](150) NULL,
	[smallesthole] [nvarchar](50) NULL,
	[matl] [nvarchar](50) NULL,
	[matltype] [nvarchar](150) NULL,
	[thk] [nvarchar](50) NULL,
	[copper] [nvarchar](150) NULL,
	[finishing] [nvarchar](150) NULL,
	[lno] [nvarchar](50) NULL,
	[lni] [nvarchar](50) NULL,
	[imped] [nvarchar](150) NULL,
	[usize] [nvarchar](50) NULL,
	[uqty] [nvarchar](50) NULL,
	[blindsize] [nvarchar](50) NULL,
	[blindqty] [nvarchar](50) NULL,
	[buriesize] [nvarchar](50) NULL,
	[burieqty] [nvarchar](50) NULL,
	[outline] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
	[shipterms] [nvarchar](150) NULL,
	[shiptermadder] [nvarchar](150) NULL,
	[payterms] [nvarchar](50) NULL,
	[leadtime] [nvarchar](150) NULL,
	[currency] [nvarchar](50) NULL,
	[exchangerate] [nvarchar](50) NULL,
	[setupcharge] [nvarchar](50) NULL,
	[Etestcharge] [nvarchar](50) NULL,
	[toolingcharge] [nvarchar](50) NULL,
	[commission] [nvarchar](50) NULL,
	[min_sq_inch] [nvarchar](50) NULL,
	[min_asp] [nvarchar](50) NULL,
	[moq] [nvarchar](50) NULL,
	[period] [nvarchar](50) NULL,
	[qty1] [nvarchar](50) NULL,
	[price1] [nvarchar](50) NULL,
	[remark1] [nvarchar](255) NULL,
	[qty2] [nvarchar](50) NULL,
	[price2] [nvarchar](50) NULL,
	[remark2] [nvarchar](255) NULL,
	[qty3] [nvarchar](50) NULL,
	[price3] [nvarchar](50) NULL,
	[remark3] [nvarchar](255) NULL,
	[qty4] [nvarchar](50) NULL,
	[price4] [nvarchar](50) NULL,
	[remark4] [nvarchar](255) NULL,
	[qty5] [nvarchar](50) NULL,
	[price5] [nvarchar](50) NULL,
	[remark5] [nvarchar](255) NULL,
	[note1] [nvarchar](500) NULL,
	[note2] [nvarchar](500) NULL,
	[targetprice] [nvarchar](50) NULL,
	[targetasp] [nvarchar](50) NULL,
	[targetsqinch] [nvarchar](50) NULL,
	[target_actual] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[cost] [nvarchar](50) NULL,
	[matlcost] [nvarchar](50) NULL,
	[yield] [nvarchar](50) NULL,
	[profit] [nvarchar](50) NULL,
	[FTP] [nvarchar](150) NULL,
	[region] [nvarchar](150) NULL,
	[factory] [nvarchar](150) NULL,
	[UID] [char](20) NULL,
	[DOM] [char](20) NULL,
	[adate] [nvarchar](50) NULL,
	[ssid] [nvarchar](50) NULL,
	[testprice] [nvarchar](50) NULL,
	[flag] [nvarchar](1) NULL,
	[flagu] [nchar](10) NULL,
	[batchflag] [nchar](1) NULL,
	[operator] [nchar](10) NULL,
	[parid] [nvarchar](50) NULL,
	[mdate] [datetime] NULL,
	[building] [nvarchar](20) NULL,
	[model] [nvarchar](100) NULL,
	[sqftarray] [nvarchar](20) NULL,
	[volumepermonth] [nvarchar](20) NULL,
	[expectedlifetime] [nvarchar](20) NULL,
	[panelutilization] [nvarchar](20) NULL,
	[factoryloading] [nvarchar](20) NULL,
	[project] [nvarchar](30) NULL,
	[projectremark] [nvarchar](500) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[sgp_history] ADD  DEFAULT ((0)) FOR [matl_percentage]
GO
ALTER TABLE [dbo].[sgp_history] ADD  DEFAULT ((0)) FOR [flag]
GO
ALTER TABLE [dbo].[sgp_history] ADD  DEFAULT (getdate()) FOR [mdate]
GO
