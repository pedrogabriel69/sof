ThinkingSphinx::Index.define :answer, with: :active_record do
  # fields
  indexes body
  indexes user.name, as: :author_name, sortable: true
  indexes user.email, as: :author_email, sortable: true

  # attributes
  has user_id, question_id, created_at, updated_at
end