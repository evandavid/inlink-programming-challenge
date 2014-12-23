require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe "class active for" do
    def set_controller_name_and_action_name
      helper.stub(:controller_name).and_return('posts')
      helper.stub(:action_name).and_return('index')
    end

    it "return active for given controller name match controller_name" do
      set_controller_name_and_action_name
      expect(helper.active_for("posts")).to eq("active")
    end

    it "return active for match controller name and action name " do
      set_controller_name_and_action_name
      expect(helper.active_for("posts", "index")).to eq("active")
    end

    it "return nil for match controller name and not match action_name" do
      set_controller_name_and_action_name
      expect(helper.active_for("posts", "new")).to eq(nil)
    end

    it "return nil for not match controller name and match action_name" do
      set_controller_name_and_action_name
      expect(helper.active_for("categories", "index")).to eq(nil)
    end

    it "return nil for not match controller name and not match action_name" do
      set_controller_name_and_action_name
      expect(helper.active_for("categories", "new")).to eq(nil)
    end
  end
end
