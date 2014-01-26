require 'spec_helper'

describe "signups/new" do
  before(:each) do
    assign(:signup, stub_model(Signup,
      :email => "MyString",
      :imdb => "MyString",
      :linkedin => "MyString",
      :photo => "MyString"
    ).as_new_record)
  end

  # it "renders new signup form" do
  #   render
  # 
  #   # Run the generator again with the --webrat flag if you want to use webrat matchers
  #   assert_select "form[action=?][method=?]", signups_path, "post" do
  #     assert_select "input#signup_email[name=?]", "signup[email]"
  #     assert_select "input#signup_imdb[name=?]", "signup[imdb]"
  #     assert_select "input#signup_linkedin[name=?]", "signup[linkedin]"
  #     assert_select "input#signup_photo[name=?]", "signup[photo]"
  #   end
  # end
end
