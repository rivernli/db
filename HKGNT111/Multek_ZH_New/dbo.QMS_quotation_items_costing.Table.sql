USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QMS_quotation_items_costing]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QMS_quotation_items_costing](
	[costId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[quoItemId] [int] NOT NULL,
	[salesConfirmed] [bit] NOT NULL,
	[CostNo] [nvarchar](50) NOT NULL,
	[unit_or_array] [nchar](10) NOT NULL,
	[unitWidth] [decimal](18, 4) NOT NULL,
	[unitLength] [decimal](18, 4) NOT NULL,
	[unit] [nvarchar](50) NOT NULL,
	[arrayWidth] [decimal](18, 4) NOT NULL,
	[arrayLength] [decimal](18, 4) NOT NULL,
	[unitPerArray] [int] NOT NULL,
	[productPerPanelWidth] [int] NOT NULL,
	[productPerPanelLength] [int] NOT NULL,
	[unitPerPanel] [int] NOT NULL,
	[materialPercentage] [decimal](18, 4) NOT NULL,
	[layers] [nchar](10) NOT NULL,
	[holes] [int] NULL,
	[smallestHole] [decimal](18, 4) NULL,
	[material] [nvarchar](50) NULL,
	[materialType] [nvarchar](50) NULL,
	[thk] [decimal](18, 4) NULL,
	[copper] [nvarchar](50) NULL,
	[finishing] [nvarchar](50) NULL,
	[LNo] [nvarchar](50) NULL,
	[LNi] [nvarchar](50) NULL,
	[imped] [nvarchar](50) NULL,
	[uSize] [nvarchar](50) NULL,
	[uQty] [nvarchar](50) NULL,
	[blindSize] [nvarchar](50) NULL,
	[blindQty] [nvarchar](50) NULL,
	[yield] [decimal](18, 4) NULL,
	[plant] [nvarchar](50) NULL,
	[mov] [nvarchar](50) NULL,
	[status] [nchar](10) NULL,
	[MOH_version] [nvarchar](50) NULL,
	[create_date] [datetime] NULL,
	[unit_set] [decimal](18, 4) NULL,
	[set_panel] [decimal](18, 4) NULL,
	[panel_area] [decimal](18, 4) NULL,
	[scrap_rate_being_used] [decimal](18, 4) NULL,
	[laminate] [decimal](18, 4) NULL,
	[prepreg] [decimal](18, 4) NULL,
	[copper_foil] [decimal](18, 4) NULL,
	[rcc_foil] [decimal](18, 4) NULL,
	[coin] [decimal](18, 4) NULL,
	[dry_film] [decimal](18, 4) NULL,
	[smcm] [decimal](18, 4) NULL,
	[fccl] [decimal](18, 4) NULL,
	[coverlay] [decimal](18, 4) NULL,
	[adhesive] [decimal](18, 4) NULL,
	[stiffener] [decimal](18, 4) NULL,
	[sheilding_film] [decimal](18, 4) NULL,
	[gold] [decimal](18, 4) NULL,
	[drill_bit] [decimal](18, 4) NULL,
	[bevelling_tool] [decimal](18, 4) NULL,
	[countersink] [decimal](18, 4) NULL,
	[miling_tool] [decimal](18, 4) NULL,
	[router] [decimal](18, 4) NULL,
	[other_edm_mat] [decimal](18, 4) NULL,
	[total_material_cost] [decimal](18, 4) NULL,
	[direct_labor] [decimal](18, 4) NULL,
	[indirect_salaries_benefit] [decimal](18, 4) NULL,
	[depreciation_amortization] [decimal](18, 4) NULL,
	[equipment_expenses] [decimal](18, 4) NULL,
	[facilities_utilities] [decimal](18, 4) NULL,
	[computer_related] [decimal](18, 4) NULL,
	[supplies] [decimal](18, 4) NULL,
	[travel_entertainment] [decimal](18, 4) NULL,
	[other_expense] [decimal](18, 4) NULL,
	[sga_cost] [decimal](18, 4) NULL,
	[calculate_unit] [nvarchar](50) NULL,
 CONSTRAINT [PK_QMS_quotation_items_costing] PRIMARY KEY CLUSTERED 
(
	[costId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing]  WITH CHECK ADD  CONSTRAINT [FK_QMS_quotation_items_costing_QMS_quotation_items] FOREIGN KEY([quoItemId])
REFERENCES [dbo].[QMS_quotation_items] ([itemId])
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing] CHECK CONSTRAINT [FK_QMS_quotation_items_costing_QMS_quotation_items]
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing] ADD  CONSTRAINT [DF_QMS_quotation_customerPN_items_costing_salesConfirmed]  DEFAULT ((0)) FOR [salesConfirmed]
GO
