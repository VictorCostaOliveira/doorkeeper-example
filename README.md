# README

- Adicionei a gem Doorkeper no gemfile
- Rodei os comandos de setup da gem `rails generate doorkeeper:install`
- Rodei rails db:migrate
- Rodei o comando paga gerar o token e o secret do proprio Doorkeper
  ```
    Doorkeeper::Application.create(
      name: "Client Application",
      redirect_uri: "https://client-app.com/callback",
      scopes: "public"
    )
  ```
- O client_id é o Doorkeeper::Application.last.uid e o client_secret é o Doorkeeper::Application.last.secret
- No arquivo initializers/doorkeeper.rb adicionei isso:
  ```ruby
    default_scopes :public
    optional_scopes :write

    # Lista de fluxos de concessão suportados
    grant_flows %w[authorization_code client_credentials]
  ```
- No controller users_controller adicionei o metodo `before_action :doorkeeper_authorize!`
- Para testar: 
  ```
    curl --location 'http://localhost:3000/oauth/token' \
    --header 'Content-Type: application/json' \
    --data '{
        "grant_type": "client_credentials",
        "client_id": "CLIENT_ID_GERADO_PELO_DOORKEEPER",
        "client_secret": "CLIENT_SECRET_GERADO_PELO_DOORKEEPER"
    }'
   ```
   - A Resposta: 
   ```
    {
        "access_token": "FRDQJe6iB2VBPy8ffCmWlzdafuW5ZlTIdpR2kuv-LTY",
        "token_type": "Bearer",
        "expires_in": 7200,
        "scope": "public",
        "created_at": 1719937941
    }
   ```
- Dai só fazer a request que voce adicionou o before_action
  ```
    curl --location 'http://localhost:3000/api/v1/users' \
    --header 'Authorization: Bearer oMEX5_dA2Xuf-Jb6n_aVdStzERrDTNx42u_vBnt2XEw'
  ```