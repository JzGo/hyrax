require 'spec_helper'

describe "Browse Dashboard" do

  before do
    @fixtures = find_or_create_file_fixtures
    sign_in FactoryGirl.create :user_with_fixtures
  end

  it "should search your files by deafult" do
    visit "/dashboard"
    fill_in "q", with: "PDF"
    click_button "search-submit-header"
    page.should have_content "Fake Document Title"
  end

  context "within my files page" do

    before do
      visit "dashboard/files"
    end

    it "should show me some files" do
      page.should have_content "Edit File"
      page.should have_content "Download File"
    end

    it "should allow you to search your own files" do
      fill_in "q", with: "PDF"
      click_button "search-submit-header"
      page.should have_content "Fake Document Title"
    end

    it "should allow you to browse facets" do
      pending "Issue #428 is causing this"
      click_link "more Subjects"
      click_link "consectetur"
      save_and_open_page
      within("#document_#{@fixtures[1].noid}") do
        click_link "Test Document MP3.mp3"
      end
      page.should have_content "File Details"
    end

    it "should allow me to edit files (from the fixtures)" do
      fill_in "q", with: "Wav"
      click_button "search-submit-header"
      click_button "Select an action"
      click_link "Edit File"
      page.should have_content "Edit Fake Wav File.wav"
    end

  end

  context "within my collections page" do
    before do
      visit "dashboard/collections"
    end
    it "should search within my collections" do
      within(".input-group-btn") do
        page.should have_content("My Collections")
      end
    end
  end

  context "within my highlights page" do
    before do
      visit "dashboard/highlights"
    end
    it "should search within my highlights" do
      within(".input-group-btn") do
        page.should have_content("My Highlights")
      end
    end
  end

  context "within my shares page" do
    before do
      visit "dashboard/shares"
    end
    it "should search within my shares" do
      within(".input-group-btn") do
        page.should have_content("My Shares")
      end
    end
  end

end
