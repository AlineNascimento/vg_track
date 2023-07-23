# Possibilidade de Fluxos do VgTrack

## User_Game

### Validação Inicial nos fluxos de GET

- [x] Validação se o usuário existe: user_id valida se ele existe em users 
- [ ] Validação se o jogo existe: game_id valida de ele existe em games (Não necessário no momento)
- [x] Criar user_game
- [x] Deletar user_game
- [ ] Update user_game (Não necessário no momento)
- [ ] Buscar user_game (Não necessário no momento)
- [x] Listar user_games

 ** Usuário tenta acessar um jogo diretamente pelo link (ainda não existe relação usuário-jogo)
 
 	exemplo endpoint: https://vgtrack.com/user_id/console_id/game_id
 	
 ** Deveriar interromper (backend) (1), já que não existe relação usuário-jogo e retorna a mensagem perguntando se o usuário quer jogar o jogo (2) e (3). 
	
	(1) Validação se existe relação usuário-jogo, se não houver, o backend retorna uma mensagem de que não existe essa relação no banco. 
		
	(2) Se sim. cria a relação
		
	(3) Volta pra url anterior do frontend
	
#### Recebemos:
``` 
$	{
$	"user_id": integer,
$	"console_id": integer,
$	"game_id": integer
$	}
``` 

#### Respondemos:
``` 
$	{
$	"Não existe essa relação no banco."
$	}
``` 
 * Faz login -> Lista de consoles -> lista de jogos -> procurar por essa lista e adicionar o jogo à sua lista. 

 	* Play 1
		```
		crash  (botão de adicionar à lista de jogos)
		mario
		```
	* Xbox
		```
		need for speed
		doom
		```
	
	(1) Endpoint usuário get_user retorna dados de um unico usuario

	(2) Endpoint consoles list_consoles retorna lista de todos os consoles

	(3) Endpoint games list_games retorna a lista de todos os jogos daquele console

	(4) Endpoint user_game create_user_game adiciona o jogo para o usuário (não existe)

#### Recebemos:
``` 
$	{
$		"email": email,
$		"senha": senha
$	}
``` 
#### Retorna
* List_consoles
``` 
$	{
$		consoles:[
$			{ "id":,
$			"name":},
$			{ "id":,
$			"name":}]	
$	}
``` 

* List_games
``` 
$	{
$		games:[
$			{ "id":,
$			"name":,
$			"console_id"},
$			{ "id":,
$			"name":,
$			"console_id"}]	
$	}
``` 
	
 * Faz login -> Algum jogo de recomendação ou jogo default.

	(1) Endpoint do login session (não existe)

	(2) Endpoint user_game list_user_game, se não houver, mostra o default e recomendação monetário.

	(3) Endpoint user_game list_user_game, se houver, mostra recomendações baseados nos que ja existe.
	

 * Faz login -> Lista de consoles -> lista de jogos que a pessoa adicionou à sua conta
	
	(1) Endpoint do login session (não existe)

	(2) Endpoint consoles list_consoles retorna lista de todos os consoles

	(3) Endpoint user_game list_user_games lista de jogos que o usuário joga

		(a) função: a partir do game_id, acessar tabela games e pegar o nome, ano do jogo. 
		(b) a partir do console_id da tabela desse game_id, pegaremos o nome do Console do jogo.
	
	
	`(++mais)` endpoint games list_games retorna a lista de todos os jogos daquele console

	(traz os jogos que já nao estão na lista de jogados (games_id))

		função: todos os game_id da tabela de games que não estão na tabela de user_game para aquele user_id enviado. (fazer isso na query do banco)

 * Play 1
	```
		crash (já jogo)
		++mais
	```

 * Xbox
	```
		need for speed (já jogo)
		doom (já jogo)
		
		++mais
	```
	
#### Recebemos:
```
$	{
$		"user_id"
$	}
```

#### Retornar:
```
$	{
$		games: [
$			{
$			"name",
$			"console_id",
$			"game_id"
$			},
$			{
$			"name",
$			"console_id",
$			"game_id"
$			}
$		]
$	}
```
	
 * Faz login -> tela de lista -> Acessa um jogo específico

	(1) Endpoint do login session (não existe)

	(2) Endpoint consoles list_consoles retorna lista de todos os consoles

	(3) Endpoint user_game list_user_games lista de jogos que o usuário joga

	(4) Endpoint user_game get_game trará todas as informações do console, jogo e do usuário com o jogo.

		função: pegar o game_id da tabela de user_game, usar para pegar os dados da tabela game, usar o console_id para pegar os dados do console. E aí fim.
	
#### Recebemos:
```
$	{
$		"user_id",
$		"game_id"
$	}
```

#### Retornar:
```
$	{
$		{
$		"name",
$		"console_id",
$		"game_id",
$		"completed",
$		"level",
$		"completed_at",
$		"personal_notes",
$		"modified_at",
$		"title",
$		"year",
$		"console_name"
$		}
$		
$	}
```	

## Particularidades do FrontEnd mostrou necessário: 
	
- [ ] Login
- [ ] Create jogo , acontece criação dos dados de user_game. Feito
- [ ] List jogos (games e de user_games) 

### Feito

 * Na criacao do jogo tem a disponibilizacao da lista de consoles (não altera na app)  e é usado na criação do jogo

 * A fazer
	 * Filtrar o nome do jogo e alguns campos de user_game
	 * Ordenação da listagem pela data de finished_at	
