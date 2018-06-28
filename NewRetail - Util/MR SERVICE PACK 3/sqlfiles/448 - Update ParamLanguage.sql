UPDATE ParamLanguage
SET
	SrvParameter = 'Vender quantidade em negativo',
	[Description] = 'Um produto pode ser vendido mesmo tendo sua quantidade negativa no estoque.'
WHERE IDLanguage = 2 AND IDParam = 2
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Informar quantidade 1 durante a venda',
	[Description] = 'Os ítens serão incluídos automaticamente com quantidade igual à (=) 1 durante as vendas.'
WHERE IDLanguage = 2 AND IDParam = 3
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Atualizar listagem de venda',
	[Description] = 'Quando os ítens forem inseridos na nota, automaticamente apareceram na listagem de venda.'
WHERE IDLanguage = 2 AND IDParam = 4
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Intervalo de tempo para atualizar itens',
	[Description] = 'Atualizar os itens em um intervalo determinado de tempo.'
WHERE IDLanguage = 2 AND IDParam = 5
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Atualizar listagens de itens no Sistema',
	[Description] = 'Quando os ítens forem inseridos, automaticamente apareceram na listagens do Sistema.'
WHERE IDLanguage = 2 AND IDParam = 6
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Nº Máximo de linhas permitidos na lista',
	[Description] = 'Número máximo permitido de linhas que podem ser mostrado na lista.'
WHERE IDLanguage = 2 AND IDParam = 7
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Modificar valores na compra',
	[Description] = 'Permitir nas compras a opção de modificar os preços de custo, frete, etc.'
WHERE IDLanguage = 2 AND IDParam = 8
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Fundo de caixa',
	[Description] = 'Total de dinheiro que deve ficar no caixa depois de ser fechado.'
WHERE IDLanguage = 2 AND IDParam = 9
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Máximo de dinheiro no caixa',
	[Description] = 'Total de máximo de dinheiro que pode ficar no caixa.'
WHERE IDLanguage = 2 AND IDParam = 11
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Habilitar nº randômico no total caixa',
	[Description] = 'Habilitar geração de número randômico para ocultar o total do sistema no caixa. (Vendas + Fundo de Caixa)'
WHERE IDLanguage = 2 AND IDParam = 12
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Qtd. Máx. na requisição do computador',
	[Description] = 'Qual a quantidade máxima que o sistema pode requerer automaticamente.'
WHERE IDLanguage = 2 AND IDParam = 13
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Qtd. Min. na requisição do computador',
	[Description] = 'Qual a quantidade mínima que o sistema pode requerer automaticamente.'
WHERE IDLanguage = 2 AND IDParam = 14
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Adicionar qtd pré-recebida no estoque',
	[Description] = 'Colocar quantidade pré-recebida como quantidade de estoque para ser vendida.'
WHERE IDLanguage = 2 AND IDParam = 15
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Tempo de deleção de itens do estoque',
	[Description] = 'Em quantos meses você deseja deletar os itens antigos de inventário? Coloque 0 para NÃO deletar nada.'
WHERE IDLanguage = 2 AND IDParam = 17
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Tempo de deleção de notas pendentes',
	[Description] = 'Em quantos dias você deseja deletar as notas pendentes? Coloque 0 para NÃO deletar nada.'
WHERE IDLanguage = 2 AND IDParam = 18
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Tempo de requisições do sistema (Meses)',
	[Description] = 'Em quantos meses você deseja que sejam feitas as requesições do sistema.'
WHERE IDLanguage = 2 AND IDParam = 25
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Valor de requisições do sistema (%Venda)',
	[Description] = 'Valor da porcentagem (%) de venda para as requesições do sistema.'
WHERE IDLanguage = 2 AND IDParam = 26
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Tempo de Logoff automático (Minutos)',
	[Description] = 'Caso o usuário não utilize o sistema nos minutos estabelecidos - Fazer Logoff do usuário.'
WHERE IDLanguage = 2 AND IDParam = 27
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Valor de OP do serviço de level A',
	[Description] = 'O valor da OP para modelos de serviço de level A que estão marcados com ABC.'
WHERE IDLanguage = 2 AND IDParam = 28
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Valor de OP do serviço de level B',
	[Description] = 'O valor da OP para modelos de serviço de level B que estão marcados com ABC.'
WHERE IDLanguage = 2 AND IDParam = 29
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Valor de OP do serviço de level C',
	[Description] = 'O valor da OP para modelos de serviço de level C que estão marcados com ABC.'
WHERE IDLanguage = 2 AND IDParam = 30
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Todos podem usar o caixa',
	[Description] = 'Se for TRUE, todos podem usar o caixa. Se for FALSE, somente o usuário que abriu o caixa poderá usá-lo.'
WHERE IDLanguage = 2 AND IDParam = 31
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador de Venda Rápida',
	[Description] = 'Mostrar o Tabulador de Venda Rápida quando o usuário criar uma nota.'
WHERE IDLanguage = 2 AND IDParam = 32
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Clientes',
	[Description] = 'Mostrar o Tabulador de Clientes quando o usuário criar uma nota.'
WHERE IDLanguage = 2 AND IDParam = 33
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Guias',
	[Description] = 'Mostrar o Tabulador de Guias quando o usuário criar uma nota.'
WHERE IDLanguage = 2 AND IDParam = 34
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Bônus na comissão (%)',
	[Description] = 'Percentual de bônus sobre a comissão.'
WHERE IDLanguage = 2 AND IDParam = 35
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostra Tabulador com dados do cliente',
	[Description] = 'Mostrar o Tabulador de dados do cliente na Guia de Venda quando o usuário criar uma nota.'
WHERE IDLanguage = 2 AND IDParam = 36
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Carga Horária',
	[Description] = 'Número de horas máximas trabalhadas por dia de um usuário.'
WHERE IDLanguage = 2 AND IDParam = 37
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar valores em itens Pré-Recebidos',
	[Description] = 'Mostrar os valores dos itens quando fizer pré-recebimento.'
WHERE IDLanguage = 2 AND IDParam = 38
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar ícones no menu',
	[Description] = 'Mostrar os ícones do programa quando inicializar o sistema.'
WHERE IDLanguage = 2 AND IDParam = 39
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar crediário no Histórico de Notas',
	[Description] = 'Mostrar informação do crediário no histórico de notas.'
WHERE IDLanguage = 2 AND IDParam = 40
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar crediário no Histórico de Caixa',
	[Description] = 'Mostrar informação do crediário no histórico de caixa.'
WHERE IDLanguage = 2 AND IDParam = 41
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Imprimir recibo de Depósito',
	[Description] = 'Imprimir recibo quando fizer um depósito.'
WHERE IDLanguage = 2 AND IDParam = 42
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador de Crediário',
	[Description] = 'Mostrar o Tabulador de Crediário quando o usuário criar uma nota.'
WHERE IDLanguage = 2 AND IDParam = 43
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Exigir nº de série na venda',
	[Description] = 'O usuário deverá incluir um número de série antes de vender o produto.'
WHERE IDLanguage = 2 AND IDParam = 44
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Calcular margem sobre o custo',
	[Description] = 'Se for TRUE, calcular a margem sobre o CUSTO. Se for FALSE, calcular a margem sobre o CUSTO MÉDIO.'
WHERE IDLanguage = 2 AND IDParam = 45
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Imprimir ítens depois que fechar o caixa',
	[Description] = 'Se for TRUE, imprimi um determinado número de ítens quando fechar o caixa.'
WHERE IDLanguage = 2 AND IDParam = 46
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Nº de ítens para imprimir',
	[Description] = 'Quantidade de itens que serão impressos (ítens randomicos do inventário). Zero não imprime nada'
WHERE IDLanguage = 2 AND IDParam = 47
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Vender pré-datado',
	[Description] = 'Mostrar opção de vender pre-datado.'
WHERE IDLanguage = 2 AND IDParam = 48
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Exigir entrega antes de fechar a nota',
	[Description] = 'A nota não pode ser fechada até que a entrega seja informada.'
WHERE IDLanguage = 2 AND IDParam = 49
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Exibir e exigir local do pagto. na venda',
	[Description] = 'Mostrar opção de exibir e exigir o campo local do pagamento quando for receber o dinheiro.'
WHERE IDLanguage = 2 AND IDParam = 50
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Exigir quitação total do pedido',
	[Description] = 'Mostrar opção de exibir e exigir o total de pagamento do pedido antes de fechar o mesmo.'
WHERE IDLanguage = 2 AND IDParam = 51
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Nota - Outros Custos',
	[Description] = 'Exibir o tabulador outros custos na nota.'
WHERE IDLanguage = 2 AND IDParam = 52
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Nota - Pagamentos',
	[Description] = 'Exibir o tabulador de pagamentos na nota.'
WHERE IDLanguage = 2 AND IDParam = 53
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Nota - Agência',
	[Description] = 'Exibir o tabulador de agência na nota.'
WHERE IDLanguage = 2 AND IDParam = 54
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Nota - Entrega',
	[Description] = 'Exibir o tabulador de entrega na nota.'
WHERE IDLanguage = 2 AND IDParam = 55
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Nota - Data Depósito',
	[Description] = 'Exibir o tabualdor de data de depósito na nota.'
WHERE IDLanguage = 2 AND IDParam = 56
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Mostrar Tabulador Nota - Desconto',
	[Description] = 'Exibir o tabulador de desconto na nota.'
WHERE IDLanguage = 2 AND IDParam = 57
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Número máximo de parcelas',
	[Description] = 'Informe o número máximo de parcelas para notas pré-datadas.'
WHERE IDLanguage = 2 AND IDParam = 58
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Habilitar consulta SERASA',
	[Description] = 'Habilitar consulta no SERASA.'
WHERE IDLanguage = 2 AND IDParam = 59
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Nome do banco de dados CEP',
	[Description] = 'Informe o nome do banco de dados de CEP.'
WHERE IDLanguage = 2 AND IDParam = 60
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Máx. de dias para pagamento à vista',
	[Description] = 'Informe o número máximo de dias para validar o recebimento à vista. Entre com -1 para desabilitar a opção.'
WHERE IDLanguage = 2 AND IDParam = 61
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Confirmar entrega depois do fim da venda',
	[Description] = 'Depois de fechar uma venda, confirmar a entrega para fechar o pedido.'
WHERE IDLanguage = 2 AND IDParam = 62
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Tipo da tela de Vendas',
	[Description] = 'Escolhe o tipo da tela de Vendas. 1 = PDV, 2 = Escritório, 3 = Full-POS'
WHERE IDLanguage = 2 AND IDParam = 63
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Isentar impostos do pedido',
	[Description] = 'Sempre isentar impostos no pedido.'
WHERE IDLanguage = 2 AND IDParam = 64
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Habilitar estoque flutuante',
	[Description] = 'Trabalhar com estoque flutuante.'
WHERE IDLanguage = 2 AND IDParam = 65
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Imposto é incluído no preço de custo',
	[Description] = 'Os impostos são incluídos no preço de custo do produto.'
WHERE IDLanguage = 2 AND IDParam = 66
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Exiba opções de loja de ANIMAIS',
	[Description] = 'Exiba opções de loja de ANIMAIS (PetShop).'
WHERE IDLanguage = 2 AND IDParam = 67
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Usar Custo líquido de reposição',
	[Description] = 'Lançar o custo de líquido na reposição do pedido.'
WHERE IDLanguage = 2 AND IDParam = 68
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Delimite o tempo da próxima entrega',
	[Description] = 'Não pode marcar a entrega para o dia seguinte depois da hora informada. Entre -1 para desabilitar.'
WHERE IDLanguage = 2 AND IDParam = 69
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Exibir resumo do cadastro de clientes',
	[Description] = 'Exibir informação resumida no cadastro de cliente.'
WHERE IDLanguage = 2 AND IDParam = 70
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Marcar entrega depois que receber pagtos',
	[Description] = 'Se o local de pagamento for  "Outros", o sistema não permitirá marcar entrega até receber todos os pagamentos.'
WHERE IDLanguage = 2 AND IDParam = 71
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Calcular Margem de Lucro',
	[Description] = 'Se for TRUE, o sistema não incluirá os impostos no cálculo da margem de lucro.'
WHERE IDLanguage = 2 AND IDParam = 72
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Caminho do Server MRPuppyTracker',
	[Description] = 'Entre com o caminho do software de integração MainRetail PuppyTracker.'
WHERE IDLanguage = 2 AND IDParam = 73
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Pedir senha ao abrir sistema',
	[Description] = 'Pedir a senha ao operador antes de abrir o MainRetail.'
WHERE IDLanguage = 2 AND IDParam = 74
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Calcular margem de preço nos itens.',
	[Description] = 'Habilitar opção para calcular margem.'
WHERE IDLanguage = 2 AND IDParam = 75
GO

UPDATE ParamLanguage
SET	SrvParameter = 'Calcula arredondamento no preço de venda',
	[Description] = 'Habilitar opção arredondar o preço de venda.'
WHERE IDLanguage = 2 AND IDParam = 76
GO
