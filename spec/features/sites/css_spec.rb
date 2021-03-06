require 'rails_helper'

RSpec.feature 'Site CSS' do
  let(:css) { 'body{background-color: red}' }

  before do
    login_as site_admin
    navigate_via_topbar menu: 'Site', title: 'CSS', icon: 'file'
  end

  scenario 'adding custom CSS' do
    expect(find('pre textarea')['autofocus']).to eq 'autofocus'

    fill_in 'site_css', with: css
    click_button 'Update Site'

    expect(page).to have_content 'Site successfully updated'
    expect(page).to have_selector "link[href=\"#{site.reload.stylesheet.url}\"]", visible: false

    navigate_via_topbar menu: 'Site', title: 'CSS', icon: 'file'

    expect(find('pre textarea').text).to eq css
  end

  scenario 'clicking Cancel' do
    click_link 'Cancel'
    expect(current_path).to eq '/home'
  end
end
