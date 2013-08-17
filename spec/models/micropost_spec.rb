require 'spec_helper'

describe Micropost do
  ## Make sure that it responds to objects
  let (:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(content: "Lorem ipsum") }
  subject { @micropost } 
  
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }
  it { should be_valid }

  ## Invalid test
  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  ## Blank Content
  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  ## Too Long
  describe "with content that's too long" do
    before { @micropost.content = "a" * 161 }
    it { should_not be_valid }
  end


end
