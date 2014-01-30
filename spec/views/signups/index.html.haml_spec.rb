require 'spec_helper'

describe "signups/index" do
  before(:each) do
    assign(:signups, [
      stub_model(Signup,
        :email => "Email",
        :imdb => "Imdb",
        :website => "website"
      ),
      stub_model(Signup,
        :email => "Email",
        :imdb => "Imdb",
        :website => "website"
      )
    ])
  end

  it "renders a list of signups" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Imdb".to_s, :count => 2
    assert_select "tr>td", :text => "website".to_s, :count => 2
  end
end
