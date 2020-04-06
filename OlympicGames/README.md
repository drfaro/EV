# README

# OlympicGames
Com a chegada dos jogos olímpicos, fomos designados para construir uma API REST em Ruby para o COB (Comitê Olímico Brasileiro), que será responsável por marcar e dizer os vencedores das seguintes modalidades:

  - 100m rasos: Menor tempo vence
  - Lançamento de Dardo: Maior distância vence


### Installation

Gerar container

```sh
$ docker-compose build
$ docker-compose run --rm --service-ports ruby_dev
```

Dentro do container, iniciar o projeto.

```sh
$ cd OlympicGames
$ bundle install
$ rails db:setup
$ rails server -p $PORT -b 0.0.0.0
```

Dentro do container, rodar os testes.

```sh
$ cd OlympicGames
$ rails test
```

Funcoes da API
- Atletas 
	- Criar
	- Listar
- Competições 
	- Criar
	- Listar
	- Iniciar
	- Encerrar
- Partidas 
	- Criar
	- Placar

# Postmam
Importar o arquivo de dentro do projeto na diretorio raiz
 ```sh
 OlympicGames/OlympicGames.postman_collection.json 
```
ou link download da collection
 ```sh
https://www.getpostman.com/collections/0a9808841537eb9da692
```
