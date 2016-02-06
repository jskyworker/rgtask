require 'spec_helper'


describe "Editing todo lists" do
  let!(:todo_list) { TodoList.create(title: "New list", description: "New description 33", status: "Open") }

  def update_todo_list(options={})
    options[:title] ||= "New Todo List"
    options[:description] ||= "New Description"
    options[:status] ||= "New"
    todo_list = options[:todo_list]

    visit "/todo_lists"
  	within "#todo_list_#{todo_list.id}" do
  	  click_link "Edit"
  	end

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    fill_in "Status", with: options[:status]
    click_button "Update Todo list"
  end
  

  it "updates todo list successfully with correct info" do     
    update_todo_list todo_list: todo_list, 
					 title: "New title", 
                     description: "New description", 
                     status: "New"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New title")
    expect(todo_list.description).to eq("New description")
    expect(todo_list.status).to eq("New")
  end

  it 'displays an error with no title' do
    update_todo_list todo_list: todo_list, 
					 title: ""
	expect(page).to have_content("error")
  end

  it 'displays an error with too short title' do
    update_todo_list todo_list: todo_list, 
					 title: "Yo"
	expect(page).to have_content("error")
  end

  it 'displays an error with no description' do
    update_todo_list todo_list: todo_list, 
					 description: ""
	expect(page).to have_content("error")
  end

  it 'displays an error with too short description' do
    update_todo_list todo_list: todo_list, 
					 description: "Yo"
	expect(page).to have_content("error")
  end


end