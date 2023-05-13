/*##########################################################################################################################################################################################################*/
--Obrigado pelo seu download!
--Gilberto Shimokawa Falcão - 12/05/2023 - Versão 1.0 - Deep Search SQL Server 
--Linkedin:https://www.linkedin.com/in/gilberto-shimokawa-falcão-253427100/
--Git Hub: https://github.com/GilbertoShimokawaFalcao
--Curriculum: https://gilbertoshimokawafalcao.github.io/Curriculum/Curriculum.html
--Email: contato.gilberto.shk.falcao@gmail.com
/*##########################################################################################################################################################################################################*/
USE master
DECLARE --Use essas variáveis para adaptar sua pesquisa!
@PalavraOuFraseDesejada VARCHAR(MAX) = 'create',
@QuantidadePorLote INT = 100, --Expressa quantidade de dados que deve ser procurado por cada sessão da estrutura abaixo.
@fracaoPorPesquisa INT = 6 --Divida pesquisa em blocos - Quanto menor o valor, mais traz informações.
/*##########################################################################################################################################################################################################*/
/*SOBRE OS PARAMETROS
@PalavraOuFraseDesejada
É aqui que você procura o que deseja na base de dados.
Dica - Quando quiser procurar de forma absoluta a palavra que se quer ou a frase, use espaço entre as aspas.
ex: para encontrar absolutamente a palavra 'teste' use: ' teste '.

@QuantidadePorLote
Quantidade de retornos que deseja por cada categoria de query criada.
Atualmente temos 6 categorias de busca:
1 - Objetos gerais
2 - Colunas
3 - Variáveis ou parametros
4 - Bancos de dados
5 - Backups
6 - Linha de comando em código interno.
No padrão @QuantidadePorLote = 100 e @fracaoPorPesquisa = 6 devolvemos em media 16 resultado de cada categoria

@fracaoPorPesquisa
Usamos para apoiar e limitar a quantidade de objetos retornados
no padrão @QuantidadePorLote = 100 e @fracaoPorPesquisa = 6 garantimos o retorno de até 100 resultados
Se @QuantidadePorLote = 100 e @fracaoPorPesquisa = 1 -> Aumentamos o retorno para 600 resultados.
Você pode usar @fracaoPorPesquisa é inversamente proporcional ou seja, se diminuir, aumenta o retorno, se aumentar, diminui a quantidade de retorno de dados por categoria. */
/*##########################################################################################################################################################################################################*/
/*##########################################################################################################################################################################################################*/
/*##########################################################################################################################################################################################################*/
/*##########################################################################################################################################################################################################*/
/*NOTAS:

EXTENDED_STORED_PROCEDURE
Tipo especial de store procedure criada usando linguagem de programação diferente da linguagem para criar procedure regulares. 
Implementadas como DLLs, geralmente usadas para executar funções de baixo nível do sistema operacional ou para integrar com outros aplicativos e serviços externos.
São usadas em casos especiais onde as stored procedures regulares não são suficientes para atender requisitos do sistema.

SQL_INLINE_TABLE_VALUED_FUNCTION
Função definida pelo usuário, retorna uma tabela de valores.
É definida dentro de uma instrução SELECT e é usada como tabela virtual dentro da consulta.
Isso permite definir funções personalizadas que podem ser usadas em consultas SQL como se fossem tabelas reais.

SQL_TABLE_VALUED_FUNCTION
Função definida pelo usuário, retorna uma tabela como resultado.
Permite usar clausulas FROM, JOIN, etc.
Essa função pode ser criada para encapsular lógica de negócios complexa e reutilizar em consultas SQL.

AGGREGATE_FUNCTION
Função usada para calcular um único valor a partir de um conjunto de valores.
Comumente usada com a cláusula GROUP BY em uma instrução select para realizar cálculos em grupo de dados.
Ex: soma, média, máximo de um conjunto de valores numa coluna de uma tabela.

CLR_SCALAR_FUNCTION
Função definida pelo usuário com código escrito em .NET (C#) compilada em DLL e registrada no SQL SERVER como assembly.
Tal função é executada dentro do ambiente SQL SERVER e pode ser usada como qualquer outra função escalável no SQL SERVER.

CLR_STORED_PROCEDURE
Procedimento armazenado que é escrito em uma linguagem de programação gerenciada pela Common Language Runtime (CLR) da plataforma .NET
Ao contrário dos procedimentos armazenados regulares, escritos em T-SQL, os CLRs podem ser escritos em várias linguagens: C#, Visual basic

TABELA DE SISTEMA
Tabela especial usada internamente pelo sistema onde armazena metadados como:
informações do próprio banco de dados, estruturas, objetos, permissões, etc (Aqui usamos algumas)
Essas tabelas não devem ser modificadas pelo usuário, pois podem causar graves erros e até corromper o banco de dados PERMANENTEMENTE.

TABELA INTERNA
Tabela temporária criada internamente pelo sistema durante a execução de uma consulta.
Tais tabelas não são acessíveis diretamente pelo usuário.
Somente pelo sistema para armazenar temporáriamente resultados intermediários de uma consulta complexa antes de serem apresentadas para o usuário.
Tais tabelas são criadas com nomes aleatórios pelo sistema e começam com o prefíxo #.

SERVICE_QUEUE
Permite que as mensagens sejam armazenadas numa fila para serem processadas posteriormente por um serviço ou aplicativo.
É uma fila de serviço que pode ser usada para implementar comunicação assíncrona entre diferentes aplicativos ou processos.
SERVICE_QUEUE é um exemplo de tabela de sistema do SQL Server.
*/
/*##########################################################################################################################################################################################################*/
/*##########################################################################################################################################################################################################*/
/*##########################################################################################################################################################################################################*/
/*##########################################################################################################################################################################################################*/
/*##########################################################################################################################################################################################################*/
SELECT  TOP (@QuantidadePorLote / @fracaoPorPesquisa)   o.name as 'Encontrado',   CASE    WHEN o.type = 'P' THEN 'PROCEDURE'    WHEN o.type = 'V' THEN 'VIEW'    WHEN o.type = 'X' THEN 'EXTENDED_STORED_PROCEDURE'
WHEN o.type = 'FN' THEN 'FUNÇÃO'    WHEN o.type = 'IF' THEN 'SQL_INLINE_TABLE_VALUED_FUNCTION'    WHEN o.type = 'TF' THEN 'SQL_TABLE_VALUED_FUNCTION'    WHEN o.type = 'AF' THEN 'AGGREGATE_FUNCTION'    WHEN 
o.type = 'FS' THEN 'CLR_SCALAR_FUNCTION'    WHEN o.type = 'U' THEN 'TABELA CRIADA POR USUARIO'    WHEN o.type = 'PC' THEN 'CLR_STORED_PROCEDURE'    WHEN o.type = 'S' THEN 'TABELA DE SISTEMA'    WHEN o.type = 'IT' 
THEN 'TABELA INTERNA'    WHEN o.type = 'SQ' THEN 'SERVICE_QUEUE'    WHEN o.type = 'UQ' THEN 'UNIQUE CONSTRAINT'    WHEN o.type = 'C' THEN 'CHECK CONSTRAINT'    WHEN o.type = 'F' THEN 'FOREIGN KEY CONSTRAINT'    
WHEN o.type = 'PK' THEN 'PRIMARY KEY CONSTRAINT'    WHEN o.type = 'D' THEN 'DEFAULT CONSTRAINT'    WHEN o.type = 'TR' THEN 'TRIGGER'    ELSE 'Não catalogado na pesquisa'    END as 'Tipo de objeto',    CASE    
WHEN o.type IN ('PK','F','UQ') THEN (    SELECT TOP 1 'Coluna: ' + (SELECT STUFF((SELECT ', ' + multiColunas.name       FROM(        SELECT c.name        FROM sys.indexes i         JOIN sys.index_columns ic 
ON i.object_id = ic.object_id AND i.index_id = ic.index_id         JOIN sys.all_columns c ON ic.object_id = c.object_id AND c.column_id = ic.column_id        WHERE i.name = o.name     ) multiColunas      
FOR XML PATH('')),1,2, ''))      + ' Tabela: ' + t.name       FROM sys.indexes i        JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id        JOIN sys.all_columns c ON ic.object_id = 
c.object_id AND c.column_id = ic.column_id        JOIN sys.tables t ON t.object_id = c.object_id       WHERE i.name = o.name)     WHEN o.type = 'C' THEN (      SELECT 'Coluna: ' + ac.name + ' / Tabela: ' + t.name      
FROM sys.check_constraints cc       LEFT OUTER JOIN sys.objects ox       ON cc.parent_object_id = ox.object_id       LEFT OUTER JOIN sys.all_columns ac ON cc.parent_column_id = ac.column_id AND cc.parent_object_id = ac.object_id  
JOIN sys.tables t       ON t.object_id = ac.object_id      WHERE cc.name = o.name)      WHEN o.type = 'D' THEN (      SELECT 'Coluna: ' + c.name + ' / Tabela: ' + t.name      FROM sys.default_constraints as d       
JOIN sys.all_columns AS c ON d.parent_object_id = c.object_id AND d.parent_column_id = c.column_id       JOIN sys.tables t ON t.object_id = c.object_id      WHERE d.name = o.name)     WHEN o.type = 'TR' THEN (      
SELECT 'Tabela Alvo: ' + t.name + ' / Foi criada em: ' + CAST(o.create_date AS VARCHAR(100)) + ' Modificada em: ' + CAST(o.modify_date AS VARCHAR(100))      FROM sys.triggers r       JOIN sys.tables t ON r.parent_id = t.object_id  
WHERE r.name = o.name)   ELSE 'Criada em: ' + CAST(o.create_date as VARCHAR(100)) + ' / Modificada em: ' + CAST(o.modify_date AS VARCHAR(100))   END as 'Deep Explore - Curiosidades',     CASE    WHEN o.type IN('P','V','TR','FN')
THEN 'EXEC SP_HELPTEXT ' + o.name    WHEN o.type IN('PK','F','UQ') THEN 'EXEC SP_PKEYS ' + (SELECT TOP 1 t.name FROM sys.indexes i JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id JOIN 
sys.all_columns c ON ic.object_id = c.object_id AND c.column_id = ic.column_id JOIN sys.tables t ON t.object_id = c.object_id WHERE i.name = o.name) + ' / EXEC SP_HELPCONSTRAINT ' + (SELECT TOP 1 t.name FROM sys.indexes i 
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id JOIN sys.all_columns c ON ic.object_id = c.object_id AND c.column_id = ic.column_id JOIN sys.tables t ON t.object_id = c.object_id WHERE 
i.name = o.name)    WHEN o.type = 'C' THEN 'EXEC SP_PKEYS ' + (SELECT TOP 1 t.name FROM sys.check_constraints cc LEFT OUTER JOIN sys.objects ox ON cc.parent_object_id = ox.object_id LEFT OUTER JOIN sys.all_columns ac ON 
cc.parent_column_id = ac.column_id AND cc.parent_object_id = ac.object_id JOIN sys.tables t ON t.object_id = ac.object_id WHERE cc.name = o.name) + ' / EXEC SP_HELPCONSTRAINT ' + (SELECT TOP 1 t.name FROM sys.check_constraints 
cc LEFT OUTER JOIN sys.objects ox ON cc.parent_object_id = ox.object_id LEFT OUTER JOIN sys.all_columns ac ON cc.parent_column_id = ac.column_id AND cc.parent_object_id = ac.object_id JOIN sys.tables t ON t.object_id = 
ac.object_id WHERE cc.name = o.name)    WHEN o.type = 'D' THEN 'EXEC SP_PKEYS ' + (SELECT TOP 1 t.name FROM sys.default_constraints as d JOIN sys.all_columns AS c ON d.parent_object_id = c.object_id AND d.parent_column_id = 
c.column_id JOIN sys.tables t ON t.object_id = c.object_id WHERE d.name = o.name)    WHEN o.type = 'U' THEN 'EXEC SP_HELP ' + o.name   ELSE ''   END as 'Comandos úteis relacionados (Explore mais)'    FROM sys.all_objects o  
WHERE UPPER(o.name) LIKE UPPER('%' + @PalavraOuFraseDesejada + '%')    UNION ALL    SELECT   TOP (@QuantidadePorLote / @fracaoPorPesquisa)  c.name as 'Encontrado',  'Coluna' as 'Tipo de objeto',  'Da Tabela: ' + t.name 
as 'Deep Explore - Curiosidades',  'EXEC SP_HELP ' + t.name as 'Comandos úteis relacionados (Explore mais)'    FROM  sys.all_columns c JOIN   sys.objects o ON c.object_id = o.object_id  JOIN sys.tables t ON t.object_id = 
c.object_id  WHERE UPPER(c.name) LIKE UPPER('%' + @PalavraOuFraseDesejada + '%')    UNION ALL    SELECT  TOP (@QuantidadePorLote / @fracaoPorPesquisa)   a.name as 'Encontrado',   'Variável ou Entrada de parâmetro' as 
'Tipo de objeto',   'Pertence ao objeto: ' + o.name + ' Criado em: ' + CAST(o.create_date AS VARCHAR(100)) AS 'Deep Explore - Curiosidades',   'EXEC SP_HELP ' + o.name + ' / EXEC SP_HELPTEXT ' + o.name as 
'Comandos úteis relacionados (Explore mais)'  FROM    sys.all_parameters a   JOIN sys.all_objects o   ON a.object_id = o.object_id  WHERE UPPER(o.name) LIKE UPPER('%' + @PalavraOuFraseDesejada + '%')    UNION ALL    
SELECT  TOP (@QuantidadePorLote / @fracaoPorPesquisa)   d.name as 'Encontrado',   'Banco de dados' as 'Tipo de objeto',   'Criado em: ' + CAST(d.crdate as VARCHAR(100)) AS 'Deep Explore - Curiosidades',   'Local database: ' + 
d.filename as 'Comandos úteis relacionados (Explore mais)'  FROM   sys.sysdatabases d  WHERE UPPER(d.name) LIKE UPPER('%' + @PalavraOuFraseDesejada + '%')    UNION ALL    SELECT  TOP (@QuantidadePorLote / @fracaoPorPesquisa)  
a.name as 'Encontrado',   'Backup - ' + a.type_desc as 'Tipo de objeto',   'Local do Backup: ' + a.physical_name as 'Deep Explore - Curiosidades',   
'https://learn.microsoft.com/en-us/sharepoint/administration/best-practices-for-backup-and-restore' as 'Comandos úteis relacionados (Explore mais)'  FROM sys.backup_devices a  WHERE UPPER(a.name) LIKE UPPER('%' + @PalavraOuFraseDesejada 
+ '%')    UNION ALL    SELECT  TOP (@QuantidadePorLote / @fracaoPorPesquisa)  definition as 'Encontrado',  'Conteúdo de código interno' as 'Tipo de objeto',  'Bem vindo(a) ao Deep Search' as 'Deep Explore - Curiosidades',  
'<<<Copie o código OU use algum comando >>> SP_HELP / SP_HELPTEXT' as 'Comandos úteis relacionados (Explore mais)'  FROM sys.all_sql_modules a  JOIN sys.all_objects o  ON a.object_id = o.object_id  WHERE UPPER(definition) LIKE 
UPPER('%' + @PalavraOuFraseDesejada + '%')