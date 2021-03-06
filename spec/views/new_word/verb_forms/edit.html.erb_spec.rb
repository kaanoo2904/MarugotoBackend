require 'rails_helper'

RSpec.describe "new_word/verb_forms/edit", type: :view do
  before(:each) do
    @new_word_verb_form = assign(:new_word_verb_form, NewWord::VerbForm.create!(
      :verb_type => 1,
      :dictionary_form => "MyString",
      :nai_form => "MyString",
      :te_form => "MyString"
    ))
  end

  it "renders the edit new_word_verb_form form" do
    render

    assert_select "form[action=?][method=?]", new_word_verb_form_path(@new_word_verb_form), "post" do

      assert_select "input#new_word_verb_form_verb_type[name=?]", "new_word_verb_form[verb_type]"

      assert_select "input#new_word_verb_form_dictionary_form[name=?]", "new_word_verb_form[dictionary_form]"

      assert_select "input#new_word_verb_form_nai_form[name=?]", "new_word_verb_form[nai_form]"

      assert_select "input#new_word_verb_form_te_form[name=?]", "new_word_verb_form[te_form]"
    end
  end
end
