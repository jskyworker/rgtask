require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { TodoList.create(title: "New list", description: "New description 33", status: "Open") }

  def visit_todo_list(list)
  	visit "/todo_lists"
  	within "#todo_list_#{list.id}" do
  	  click_link "List Items"
  	end
  end

#  before do
#  	visit "/todo_lists"
#  	within "#todo_list_#{todo_list.id}" do
#  	  click_link "List Items"
#  	end
#  end

  it "displays the title of the todo list" do
  	visit_todo_list(todo_list)
  	within("h1") do 
	  expect(page).to have_content(todo_list.title)
	end
  end


  it "displays no todo items when todo list is empty" do
  	visit_todo_list(todo_list)
  	expect(page.all("ul.todo_items li").size).to eq(0)
  end

  it "displays item content when a todo list have an item" do
  	todo_list.todo_items.create(content: "Crazy staff")
  	todo_list.todo_items.create(content: "Cow")
  	visit_todo_list(todo_list)
  	expect(page.all("ul.todo_items li").size).to eq(2)
  	within("ul.todo_items") do
	  expect(page).to have_content("Crazy staff")
	  expect(page).to have_content("Cow")
	end
  end
	
end