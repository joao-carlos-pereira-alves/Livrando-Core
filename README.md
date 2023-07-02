# API de Catálogo de Filmes

Esta é uma API de serviço do catálogo de filmes que permite ler um arquivo CSV e criar registros no banco de dados, além de listar todos os filmes cadastrados em formato JSON. A API foi desenvolvida em Ruby utilizando o framework Rails junto com o banco de dados PostgreSQL, e para a conteinerização, foi usado o Docker. A API segue o padrão RESTful e possui funcionalidades de ordenação, filtragem e garantia de não duplicidade de registros.

# 1. Endpoints

A API possui os seguintes endpoints:

# Importação de Filmes

```Endpoint: POST /api/v1/movies/import```

Essa rota é responsável por importar os filmes a partir de um arquivo CSV.

# Listagem de Filmes

```Endpoint: GET /api/v1/movies```

A listagem de filmes pode ser filtrada por diversos critérios, como ano de lançamento, gênero, país, etc. Para isso, é possível utilizar parâmetros na URL do endpoint para aplicar os filtros desejados. Por exemplo:

```
GET /api/v1/movies?year=2000: Lista todos os filmes lançados no ano de 2000.
GET /api/v1/movies?genre=Movie: Lista todos os filmes do gênero Movie.
GET /api/v1/movies?country=Indonesia&genre=Movie: Lista todos os filmes do país "Indonesia" e do gênero "Movie".
```

Os filtros podem ser combinados para refinar a busca de acordo com as necessidades do usuário.

# 2. Garantia de Não Duplicidade de Registros

A API garante que não haja duplicidade de registros ao importar filmes a partir do arquivo CSV. Caso sejam encontrados registros duplicados no arquivo, a API irá identificá-los e não irá importá-los novamente no banco de dados.

# 3. Configuração, Execução e Testes do Projeto

Para configurar, executar e testar o projeto em seu ambiente local, siga os passos abaixo:

* Clone o repositório do projeto do GitHub em seu ambiente local.
* Certifique-se de ter o Ruby e o Rails instalados ou se preferir, utilize o Docker com o docker-compose.
* Acesse a pasta do projeto clonado e instale as dependências do Rails usando o comando bundle install.
* Execute as migrações do banco de dados usando o comando rails db:migrate.
* Inicie o servidor Rails usando o comando rails s.
* A API estará disponível em http://localhost:3000/api/v1/movies, substitua a porta e o caminho de acordo com a configuração do seu ambiente.

# 4. Testes

Os testes automatizados com RSpec garantem a qualidade e a integridade do código, permitindo identificar e corrigir possíveis problemas antes de implantar a API em produção.

* Execute os testes RSpec usando o comando "rspec" na raiz do projeto.
