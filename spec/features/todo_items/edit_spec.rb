require 'spec_helper'

describe "Editing todo items" do
  let!(:todo_list) { TodoList.create(title: "New list", description: "New description", status: "Open") }
  let!(:todo_item) { todo_list.todo_items.create(content: "KDE") }

  it "is successfull with valid content" do
  	visit_todo_list(todo_list)
  	within "#todo_item_#{todo_item.id}" do
  	  click_link "Edit"
  	end
  	fill_in "Content", with: "How to patch KDE under FreeBSD"
  	click_button "Save"
  	expect(page).to have_content("Saved todo list item.")
  	todo_item.reload
  	expect(todo_item.content).to eq("How to patch KDE under FreeBSD")
  end

  it "is unsuccessfull with no content" do
  	visit_todo_list(todo_list)
  	within "#todo_item_#{todo_item.id}" do
  	  click_link "Edit"
  	end
  	fill_in "Content", with: ""
  	click_button "Save"
  	expect(page).to_not have_content("Saved todo list item.")
  	expect(page).to have_content("Content can't be blank")
  	todo_item.reload
  	expect(todo_item.content).to eq("KDE")
  end

  it "is unsuccessfull with not enough content" do
  	visit_todo_list(todo_list)
  	within "#todo_item_#{todo_item.id}" do
  	  click_link "Edit"
  	end
  	fill_in "Content", with: "Yo"
  	click_button "Save"
  	expect(page).to_not have_content("Saved todo list item.")
  	expect(page).to have_content("Content is too short")
  	todo_item.reload
  	expect(todo_item.content).to eq("KDE")
  end

end