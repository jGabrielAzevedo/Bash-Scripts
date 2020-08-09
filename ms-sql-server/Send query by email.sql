--Declara as variaveis
Declare @HTMLBody nvarchar(max),
	@tableBody nvarchar(max)

--Cria a tabela HTML
SET @tableBody = CONVERT(NVARCHAR(MAX), (SELECT
	(SELECT '' FOR XML PATH(''), TYPE) AS 'caption',
	(SELECT 
		'ID' AS th,
		'Text' AS th,
		'Created At' AS th,
		'Link' AS th
		FOR XML RAW('tr'), ELEMENTS, TYPE) AS 'thead',
	(

	--Inicio da Query
	SELECT 
		id as td,
		nome as td,
		data as td,
		cast('< a href = "http://example.com/?Search=' + cast(id as nvarchar)+ '"  target="_blank">; Ver no Site </a>' as XML) as td
		
	FROM ExampleTable
	--Fim da Query

	FOR XML RAW('tr'), ELEMENTS, TYPE
	) AS 'tbody'
FOR XML PATH(''), ROOT('table')));


--Corpo do HTML
SET @HTMLBody = '<html><head><style>
	table, th, td {
		border: 1px solid black;
	}
	table {
		width: 100%;
		border-collapse: collapse;
	}
	th {
		width: 25%;
		background-color: #99CCFF;
	}
	tr {
		width: 25%;
		background-color: #F1F1F1;
	}
</style><title>Titulo HTML</title></head><body>'
SET @HTMLBody = @HTMLBody + 'Algum texto antes da tabela<br/>' + @tableBody + '</body></html>'

--envia o email
exec msdb.dbo.sp_send_dbmail 
@profile_name = 'ExampleMailProfile', 
@recipients = 'email_2@example.com',
@subject = '[DB Email] Resultado da Query', 
@body = @HTMLBody, 
@body_format = 'HTML'
