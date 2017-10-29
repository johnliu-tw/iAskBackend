json.array! @papers, partial: 'papers/paper', as: :paper
json.extract! paper, :id, :public_date