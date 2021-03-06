USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[ReservationTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReservationTable](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Use] [nvarchar](100) NULL,
	[room] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[SubjectTime] [datetime] NULL,
	[Viewed] [bit] NULL,
	[IP] [nvarchar](50) NULL,
	[Start] [datetime] NULL,
	[End] [datetime] NULL,
	[email] [nvarchar](50) NULL,
	[Reply] [bit] NULL,
 CONSTRAINT [PK_ReservationTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
