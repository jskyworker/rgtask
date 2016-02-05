require 'spec_helper'

describe "todo_lists/show" do
  before(:each) do
    @todo_list = assign(:todo_list, stub_model(TodoList,
      :title => "Title",
      :description => "MyText",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Status/)
  end
end
