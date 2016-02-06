require 'spec_helper'


describe "Creating todo lists" do

  def create_todo_list(options={})
    options[:title] ||= "New Todo List"
    options[:description] ||= "New Description"
    options[:status] ||= "Open"

    visit "/todo_lists"
    click_link "New Todo list"
    expect(page).to have_content("New Todo List")

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    fill_in "Status", with: options[:status]
    click_button "Create Todo list"
  end


  it "redirects to the todo lists index page on success" do
    create_todo_list title: "2nd list"
    expect(page).to have_content("2nd list")
  end


  it "displays an error in case todo list has no title" do
  	expect(TodoList.count).to eq(0)

    create_todo_list title: ""

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Description of 2 list")
  end


  it "displays an error in case todo list has a title less than 3 characters" do
  	expect(TodoList.count).to eq(0)

  	create_todo_list title: "Yo", description: "Description of 2nd list", status: "In progress"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Description of 2 list")
  end


  it "displays an error in case todo list has no Description" do
  	expect(TodoList.count).to eq(0)

  	create_todo_list title: "Some title", description: "", status: "Open"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Some title")
  end


  it "displays an error in case todo list has a Description less than 3 characters" do
  	expect(TodoList.count).to eq(0)

  	create_todo_list title: "Yo sdfkhdf", description: "Yo", status: "Open"

    expect(page).to have_content("error")
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).not_to have_content("Yo sdfkhdf")
  end

end
