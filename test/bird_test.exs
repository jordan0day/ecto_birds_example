defmodule EctoStuff.Db.Models.Bird.Test do
  use ExUnit.Case

  alias EctoStuff.Repo
  alias EctoStuff.Db.Models.Bird

  setup do
    on_exit fn ->
      Repo.delete_all(Bird)
    end
  end

  test "birds are valid without a call type" do
    bird = Bird.new(%{name: "sparrow", size: "small"})

    assert bird.valid?
  end

  test "birds are valid with a call type" do
    bird = Bird.new(%{name: "sparrow", size: "small", call_type: "chirp"})

    assert bird.valid?
  end

  test "bird size must be valid" do
    bird = Bird.new(%{name: "owl", size: "weird"})

    refute bird.valid?
  end

  test "bird call_type must be valid" do
    bird = Bird.new(%{name: "owl", size: "large", call_type: "lousy"})

    refute bird.valid?
  end

  test "valid birds can be inserted" do
    bird = Bird.new(%{name: "owl", size: "large", call_type: "hoot"})

    owl = Repo.insert(bird)

    assert owl != nil
    assert owl.id != nil
  end

  test "birds can be updated" do
    bird = Bird.new(%{name: "ostrich", size: "giant"})
    ostrich = Repo.insert(bird)

    changeset = Bird.changeset(ostrich, %{call_type: "chirp"})

    assert changeset.valid?
    ostrich = Repo.update(changeset)

    assert ostrich != nil
    assert ostrich.id != nil
    assert ostrich.name == "ostrich"
    assert ostrich.size == "giant"
    assert ostrich.call_type == "chirp"
  end

  test "birds can't be updated with invalid data" do
    bird = Bird.new(%{name: "robin", size: "small", call_type: "chirp"})
    robin = Repo.insert(bird)

    updated_robin = Bird.changeset(robin, %{size: "miniscule"})

    refute updated_robin.valid?
  end
end