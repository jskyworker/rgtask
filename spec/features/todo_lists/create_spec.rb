require 'spec_helper'

RSpec.configure do |c|
  c.expose_current_running_example_as :example
end

describe "Creating todo lists" do
  it "redirects to the todo lists index page on success" do
    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "2 list"
    fill_in "Description", with: "Description of 2 list"
    fill_in "Status", with: "open"
    click_button "Create Todo list"

    expect(page).to have_content("2 list")
  end

  it "displays an error in case todo list has no title" do
  	expect(TodoList.count).to eq(0)

  	visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: ""
    fill_in "Description", with: "Description of 2 list"
    fill_in "Status", with: "open"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Description of 2 list")
  end


  it "displays an error in case todo list has a title less than 3 characters" do
  	expect(TodoList.count).to eq(0)

  	visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Yo"
    fill_in "Description", with: "Description of 2 list"
    fill_in "Status", with: "open"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Description of 2 list")
  end


  it "displays an error in case todo list has no Description" do
  	expect(TodoList.count).to eq(0)

  	visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Some title"
    fill_in "Description", with: ""
    fill_in "Status", with: "open"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Some title")
  end


  it "displays an error in case todo list has a Description less than 3 characters" do
  	expect(TodoList.count).to eq(0)

  	visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: "Yo sdfkhdf"
    fill_in "Description", with: "Yo"
    fill_in "Status", with: "open"
    click_button "Create Todo list"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Yo sdfkhdf")
  end

end
