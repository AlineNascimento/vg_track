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

  def get_session!(%{"id" => id}) do
    Repo.get!(Session, id)
  end

  def delete_session(%{"id" => id}) do
    session = Repo.get!(Session, id)
    Repo.delete(session)
  end

  def list_session() do
    Repo.all(Session)
  end

  def update_session(attrs) do
    session =
      Repo.get(Session, attrs["id"])
      |> Session.changeset(attrs)
      |> Repo.update()
  end
end
