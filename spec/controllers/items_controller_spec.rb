require 'rails_helper'

describe 'GET #search' do
  it "@itemsに正しい値が入っていること" do
    item = create(:item)
    get :search
    expect(response).to render_search :search
  end
end