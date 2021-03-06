require 'rails_helper'

RSpec.describe 'Items API' do
  
  let!(:todo) {create(:todo)}
  let!(:items) {create_list(:item, 20, todo_id: todo_id)}

  let(:todo_id) { todo_id }
  let(:id) { items.first.id }

  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items" }

    context 'when todo exists' do
      expect(response).to have_http_status(200)
    end

    it 'returns all todo items' do 
      expect(json.size).to eq(20)
    end
  end

  context 'when todo does not exists' do 
    let(:todo_id) {0}

    it 'returns status code 404' do 
      expect(response).to have_http_status(404)
    end

    it 'returns a not found message' do
      expect(response.body).to match(/Coundn't find a Todo/) 
    end
  end
end