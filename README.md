# WSurvey

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Run tests with `mix test`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000/api/graphiql`](http://localhost:4000/api/graphiql) from your browser and explore the graphql api.

There are also two endpoints exposed. One is a get at [`localhost:4000/api/count`](http://localhost:4000/api/count). The other is a post at ['localhost:4000/api/vote`](http://localhost:4000/vote). This last endpoint should include a body like: {"vote": "agree"} or {"vote": "disagree"}.


Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
