ThinkingSphinx::Index.define :user, with: :active_record do
  # fields
  indexes name, sortable: true
  indexes email, sortable: true

  # attributes
  has id, created_at, updated_at
end
