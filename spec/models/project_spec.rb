require 'rails_helper'

RSpec.describe Project, type: :model do

  def valid_project
    Project.new(title: "ABC", description: "a" * 100, )
  end

  def invalid_project
    Project.new(title: "", description: "", due_date: "2017")
  end
  describe "validations" do


    it "should have a title" do
      p = invalid_project
      p.valid?
      expect(p.errors).to have_key(:title)
    end

    it "should be unique" do
      p = valid_project
      p.save
      q = valid_project
      q.valid?
      expect(q.errors).to have_key(:title)
    end

    it "duedate needs to be in future" do
      p = Project.new due_date: 3.day.ago
      p.valid?
      expect(p.errors).to have_key(:due_date)
    end
  end
end
