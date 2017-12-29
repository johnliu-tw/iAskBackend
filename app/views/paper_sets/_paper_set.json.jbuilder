json.extract! paper_set, :id, :title, :price, :public_date, :description, :active, :created_at, :updated_at
json.url paper_set_url(paper_set, format: :json)
