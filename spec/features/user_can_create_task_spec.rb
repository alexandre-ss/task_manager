require 'rails_helper'

feature 'User can Create Task' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit task_path(task)

    expect(user.tasks.count).to eq 1
    expect(current_path).to eq task_path(task)
    
  end

  scenario 'And must be loged in' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)

    visit task_path(task)
    expect(current_path).to eq user_session_path
  end

  scenario 'And Title must have more than 4 characters' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit new_task_path

    fill_in 'Task Title', with: ''
    fill_in 'Description', with: 'This is a test description'

    click_on 'Create Task'

    expect { Task.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  scenario 'And Title must have less than 20 characters' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit new_task_path

    fill_in 'Task Title', with: 'Titlewithmorethantwentycharacters'
    fill_in 'Description', with: 'this is a test description'

    click_on 'Create Task'

    expect { Task.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end 

  scenario 'And Description Can\'t be blank' do 
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit new_task_path

    fill_in 'Task Title', with: 'Normal title'
    fill_in 'Description', with: ' '

    click_on 'Create Task'

    expect { Task.create! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end

