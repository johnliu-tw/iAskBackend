json.extract! paper_subject, :id, :title, :title_view, :active, :created_at, :updated_at
json.url paper_subject_url(paper_subject, format: :json)
