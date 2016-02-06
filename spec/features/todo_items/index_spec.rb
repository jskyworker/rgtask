require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { TodoList.create(title: "New list", description: "New description 33", status: "Open") }

  it "displays no todo items when todo list is empty" do
  	visit "/todo_lists"
  	within "#todo_list_#{todo_list.id}" do
  	  click_link "List Items"
  	end
  	expect(page).to have_content("TodoItems#index")

  end
	
end