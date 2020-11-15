require 'rails_helper'

feature 'Sections page', :js do
  it 'shows title on All' do
    visit catalog_path

    expect(page).to have_text(I18n.t('variants.all.title'))
  end
end
