require 'rails_helper'

feature 'User can edit Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit task_path(task)
    
    click_on "Edit Task"

    fill_in 'Task Title', with: 'Testing title'

    click_on 'Update Task'
    expect(current_path).to eq task_path(task)
    expect(page).to have_content('Task was successfully updated')
  end 

  scenario 'And must fill all fields' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit task_path(task)

    click_on 'Edit Task'

    fill_in 'Task Title', with: '..'
    fill_in 'Description', with: 'this is a test description'

    click_on 'Update Task'
    expect(current_path).to eq task_path(task)
    expect(page).to have_content("Title is too short (minimum is 4 characters)")
  end
end
