if (not exists(select 1 from syscolumns where id = OBJECT_ID('FIN_LANCAMENTO') and name = 'NumMeioQuitPrevisto')) begin
	alter table FIN_LANCAMENTO add NumMeioQuitPrevisto varchar(255) null
end else if (exists(select 1 from syscolumns where id = OBJECT_ID('FIN_LANCAMENTO') and name = 'NumMeioQuitPrevisto')) begin
        alter table FIN_LANCAMENTO
        alter column NumMeioQuitPrevisto varchar(255)
    end	
go  