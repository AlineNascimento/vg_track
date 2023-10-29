defmodule VgTrack.Sessions.Sessions do
  import Ecto.Query, warn: false

  alias VgTrack.Sessions.Session
  alias VgTrack.Repo

  def create_session(attrs \\ %{}) do
    %Session{}
    |> Session.changeset(attrs)
    |> Repo.insert()
  end

  def get_session(%{"id" => id}) do
    case Repo.get(Session, id) do
      %Session{} = session ->
        {:ok, session}

      nil ->
        {:error, :not_found}
    end
  end

  def verify_session(attrs) do
    IO.inspect(attrs)

    case get_session(%{"id" => attrs["id"]}) do
      {:ok, session} ->
        time_diff = NaiveDateTime.diff(NaiveDateTime.utc_now(), session.updated_at)
        time_hours = div(time_diff, 3600)

        case time_hours do
          hours when hours < 24 ->
            # atualizar o updated_at com data atual; retorna o session_id
            update_session(%{"id" => session.id, "updated_at" => NaiveDateTime.utc_now()})
            {:ok, %{id: session.id}}

          hours when hours > 24 and hours < 48 ->
            # cria nova sessão; retorna o session_id novo; exclui sessao antiga
            {:ok, new_session} = create_session(%{"user_id" => attrs["user_id"]})
            delete_session(%{"id" => session.id})
            {:ok, %{id: new_session.id}}

          hours when hours > 48 ->
            # retorna :ok e que sessão expirou; exclusão da sessão; status 401
            delete_session(%{"id" => session.id})
            {:error, :unauthorized}
        end

      {:error, :not_found} ->
        {:error, :unauthorized}
    end
  end

  # test_map = %{"session_id" => 10, "user_id" => 1}
  # VgTrack.Sessions.Sessions.verify_session(test_map)

  def get_session!(%{"id" => id}) do
    IO.inspect(id)
    Repo.get!(Session, id)
  end

  def delete_session(%{"id" => id}) do
    IO.puts("id do delete:")
    IO.inspect(id)
    session = Repo.get!(Session, id)
    Repo.delete(session)
  end

  def list_session() do
    Repo.all(Session)
  end

  def update_session(attrs) do
    IO.puts("attrs update:")
    IO.inspect(attrs)

    session =
      Repo.get(Session, attrs["id"])
      |> Session.changeset(attrs)
      |> Repo.update()
  end
end
