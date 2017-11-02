json.extract! paper, :id, :title, :active, :visible, :public_date, :note, :grade, :open_count, :correct_count, :created_at, :updated_at,:title_view
json.url paper_url(paper, format: :json)
