ThinkingSphinx::Index.define :question, with: :active_record do
  # fields
  indexes title, sortable: true
  indexes body
  indexes user.name, as: :author_name, sortable: true
  indexes user.email, as: :author_email, sortable: true

  # attributes
  has user_id, created_at, updated_at
end
