defmodule NameBadge do
  def print(id, name, department) do
    id_label = if id == nil do "" else "[#{id}] - " end
    department_label = if department == nil do " - OWNER" else " - #{String.upcase(department)}" end
    id_label <> name <> department_label
  end
end
