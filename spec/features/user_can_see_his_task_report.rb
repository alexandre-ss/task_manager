require 'rails_helper'

feature 'User can see his own task report' do
  scenario 'successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit task_report_path
    expect(current_path).to eq task_report_path
  end

  scenario 'but needs to be logged in' do
    user = create(:user)
    profile = create(:profile, user: user)

    visit task_report_path
    expect(current_path).to eq user_session_path
  ends

end
