require 'spec_helper'

describe "Creating todo items" do
  let!(:todo_list) { TodoList.create(title: "New list", description: "New description 33", status: "Open") }

  def visit_todo_list(list)
  	visit "/todo_lists"
  	within "#todo_list_#{list.id}" do
  	  click_link "List Items"
  	end
  end


  it "successful with a valid content" do
  	visit_todo_list(todo_list)
  	click_link "New Todo Item"
  	fill_in "Content", with: "Cow"
  	click_button "Save"
  	expect(page).to have_content("Added todo list item.")
  	within "ul.todo_items" do
      expect(page).to have_content("Cow")
  	end
  end


  it "displays an error with no content" do
  	visit_todo_list(todo_list)
  	click_link "New Todo Item"
  	fill_in "Content", with: ""
  	click_button "Save"
  	within "div.flash" do
      expect(page).to have_content("Failed to add todo list item.")
  	end
  	expect(page).to have_content("Content can't be blank")
  end


  it "displays an error with content less than 3 characters" do
  	visit_todo_list(todo_list)
  	click_link "New Todo Item"
  	fill_in "Content", with: "XY"
  	click_button "Save"
  	within "div.flash" do
      expect(page).to have_content("Failed to add todo list item.")
  	end
  	expect(page).to have_content("Content is too short")
  end

end