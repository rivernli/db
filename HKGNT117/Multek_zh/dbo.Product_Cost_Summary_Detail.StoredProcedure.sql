USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Summary_Detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[Product_Cost_Summary_Detail]
@Project NVARCHAR(MAX),
@Pnl_sqftValue NVARCHAR(10)

as 
declare @sql_BOM varchar(max), @BOM varchar(max), @sql_EDM varchar(max),@EDM varchar(max) 

--By Panel
	IF @Pnl_sqftValue='Panel'
		BEGIN 
			--BOM
			select @sql_BOM = isnull(@sql_BOM + '],[' , '') + Material from Cost_Sheet_Query_Material_Type WHERE [Type]='BOM' order by [Type],SN ASC  
			set @sql_BOM = '[' + @sql_BOM + ']'
			set @BOM = Replace(Replace(@sql_BOM,'[',''''),']','''') 

			exec ('
			select * into ##temp_BOM from 
			(
			select m_BOM.* , n_BOM.[BOM material Cost] from
			(select * from (select T$PJNO,T$COSP,T$META from vc_Standard_Cost_TFSBOM401180) a pivot (max(T$COSP) for T$META in (' + @sql_BOM + ')) b  '+@Project+') m_BOM , 
			(select T$PJNO , sum(T$COSP) as [BOM material Cost] from vc_Standard_Cost_TFSBOM401180 '+@Project+' AND T$META in (' + @BOM + ') group by T$PJNO) n_BOM
			where m_BOM.T$PJNO = n_BOM.T$PJNO  
			) tbBOM
			') 

			--EDM
			select @sql_EDM = isnull(@sql_EDM + '],[' , '') + Material from Cost_Sheet_Query_Material_Type WHERE [Type]='EDM' order by [Type],SN ASC  
			set @sql_EDM = '[' + @sql_EDM + ']'
			set @EDM = Replace(Replace(@sql_EDM,'[',''''),']','''')  
			set @EDM = replace(@EDM,'EDM MAT''L           ','EDM MAT"L           ')

			exec ('
			select * into ##temp_EDM from 
			(
			select m_EDM.* , n_EDM.[EDM material Cost] from
			(select * from (select T$PJNO,T$COSP,T$META from vc_Standard_Cost_TFSBOM401180) a pivot (max(T$COSP) for T$META in (' + @sql_EDM + ')) b '+@Project+' ) m_EDM , 
			(select T$PJNO , sum(T$COSP) as [EDM material Cost] from vc_Standard_Cost_TFSBOM401180 '+@Project+' AND T$META in (' + @EDM + ') group by T$PJNO) n_EDM
			where m_EDM.T$PJNO = n_EDM.T$PJNO  
			) tbEDM
			') 


			--tfsolp143180 Direct Labor...
			exec ('
			select * into ##temp_143180 from 
			(
			select T$PJNO,
			SUM(T$dlct) as [Direct Labor], SUM(t$ilct) as [Indirect Salaries & Benefit], '''' as [MOH cost], SUM(t$dpam) as [Depreciation & Amortization],
			SUM(t$eqex) as [Equipment Expenses], SUM(t$faut) as [Facilities & Utilities], SUM(t$cmpt) as [Computer Related], SUM(t$supp) as [Supplies],
			SUM(t$tren) as [Travel & Entertainment], SUM(t$oter) as [Other Expenses] 
			from tfsolp143180 '+@Project+' group by T$PJNO 
			) tb143180 
			') 

			select *,[MOH cost]+[Indirect Salaries & Benefit]+[Direct Labor]+[Total Material Cost] as [Total cost] from 
			(
			select 
			a.T$PJNO as [Project No], [BOM material Cost]+[EDM material Cost] as [Total Material Cost], a.[BOM material Cost],[Laminate            ],[Prepreg             ],[Copper Foil         ],[RCC Foil            ],
			[Dry Film            ],[SMCM                ],ISNULL([FCCL                ],0) as FCCL, ISNULL([Coverlay            ],0) as Coverlay, ISNULL([Adhesive            ],0) as Adhesive, 
			ISNULL([Stiffener           ],0) as Stiffener, ISNULL([Sheildling Film     ],0) as [Sheildling Film], ISNULL([Coin                ],0) as Coin, 
			b.[EDM material Cost],[Gold                ],[Drill Bit           ],[Bevelling Tool      ],
			[Countersink         ],[Miling Tool         ],[Router              ],[EDM MAT'L           ],
			[Direct Labor],[Indirect Salaries & Benefit], 
			([Depreciation & Amortization]+[Equipment Expenses]+[Facilities & Utilities]+[Computer Related]+[Supplies]+[Travel & Entertainment]+[Other Expenses]) as [MOH cost], 
			[Depreciation & Amortization],[Equipment Expenses], [Facilities & Utilities], [Computer Related], [Supplies],
			[Travel & Entertainment], [Other Expenses] 
			 from ##temp_BOM a
			LEFT JOIN ##temp_EDM b ON a.T$PJNO=b.T$PJNO
			LEFT JOIN ##temp_143180 c ON a.T$PJNO=c.T$PJNO 
			) temptb

		END

--By Sqft
	IF @Pnl_sqftValue='Sqft'
		BEGIN
			--BOM
			select @sql_BOM = isnull(@sql_BOM + '],[' , '') + Material from Cost_Sheet_Query_Material_Type WHERE [Type]='BOM' order by [Type],SN ASC  
			set @sql_BOM = '[' + @sql_BOM + ']'
			set @BOM = Replace(Replace(@sql_BOM,'[',''''),']','''') 

			exec ('
			select * into ##temp_BOM from 
			(
			select m_BOM.* , n_BOM.[BOM material Cost] from
			(select * from (select T$PJNO,T$COSS,T$META from vc_Standard_Cost_TFSBOM401180) a pivot (max(T$COSS) for T$META in (' + @sql_BOM + ')) b  '+@Project+') m_BOM , 
			(select T$PJNO , sum(T$COSS) as [BOM material Cost] from vc_Standard_Cost_TFSBOM401180 '+@Project+' AND T$META in (' + @BOM + ') group by T$PJNO) n_BOM
			where m_BOM.T$PJNO = n_BOM.T$PJNO  
			) tbBOM
			') 

			--EDM
			select @sql_EDM = isnull(@sql_EDM + '],[' , '') + Material from Cost_Sheet_Query_Material_Type WHERE [Type]='EDM' order by [Type],SN ASC  
			set @sql_EDM = '[' + @sql_EDM + ']'
			set @EDM = Replace(Replace(@sql_EDM,'[',''''),']','''')  
			set @EDM = replace(@EDM,'EDM MAT''L           ','EDM MAT"L           ')

			exec ('
			select * into ##temp_EDM from 
			(
			select m_EDM.* , n_EDM.[EDM material Cost] from
			(select * from (select T$PJNO,T$COSS,T$META from vc_Standard_Cost_TFSBOM401180) a pivot (max(T$COSS) for T$META in (' + @sql_EDM + ')) b '+@Project+' ) m_EDM , 
			(select T$PJNO , sum(T$COSS) as [EDM material Cost] from vc_Standard_Cost_TFSBOM401180 '+@Project+' AND T$META in (' + @EDM + ') group by T$PJNO) n_EDM
			where m_EDM.T$PJNO = n_EDM.T$PJNO  
			) tbEDM
			') 


			--tfsolp143180 Direct Labor...
			exec ('
			select * into ##temp_143180 from 
			(
			select T$PJNO,
			SUM(T$dlct) as [Direct Labor], SUM(t$ilct) as [Indirect Salaries & Benefit], '''' as [MOH cost], SUM(t$dpam) as [Depreciation & Amortization],
			SUM(t$eqex) as [Equipment Expenses], SUM(t$faut) as [Facilities & Utilities], SUM(t$cmpt) as [Computer Related], SUM(t$supp) as [Supplies],
			SUM(t$tren) as [Travel & Entertainment], SUM(t$oter) as [Other Expenses] 
			from tfsolp143180 '+@Project+' group by T$PJNO 
			) tb143180 
			') 

			select *,[MOH cost]+[Indirect Salaries & Benefit]+[Direct Labor]+[Total Material Cost] as [Total cost] from 
			(
			select 
			a.T$PJNO as [Project No], [BOM material Cost]+[EDM material Cost] as [Total Material Cost], a.[BOM material Cost],[Laminate            ],[Prepreg             ],[Copper Foil         ],[RCC Foil            ],
			[Dry Film            ],[SMCM                ],ISNULL([FCCL                ],0) as FCCL, ISNULL([Coverlay            ],0) as Coverlay, ISNULL([Adhesive            ],0) as Adhesive, 
			ISNULL([Stiffener           ],0) as Stiffener, ISNULL([Sheildling Film     ],0) as [Sheildling Film], ISNULL([Coin                ],0) as Coin, 
			b.[EDM material Cost],[Gold                ],[Drill Bit           ],[Bevelling Tool      ],
			[Countersink         ],[Miling Tool         ],[Router              ],[EDM MAT'L           ],
			[Direct Labor],[Indirect Salaries & Benefit], 
			([Depreciation & Amortization]+[Equipment Expenses]+[Facilities & Utilities]+[Computer Related]+[Supplies]+[Travel & Entertainment]+[Other Expenses]) as [MOH cost], 
			[Depreciation & Amortization],[Equipment Expenses], [Facilities & Utilities], [Computer Related], [Supplies],
			[Travel & Entertainment], [Other Expenses] 
			 from ##temp_BOM a
			LEFT JOIN ##temp_EDM b ON a.T$PJNO=b.T$PJNO
			LEFT JOIN ##temp_143180 c ON a.T$PJNO=c.T$PJNO 
			) temptb

		END


drop table ##temp_BOM
drop table ##temp_EDM
drop table ##temp_143180
 


GO
