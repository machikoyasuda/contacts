require 'spec_helper'

describe Contact do
  it 'has a valid factory' do
    expect(build(:contact)).to be_valid
  end

  it 'is invalid without first name' do
    # Create contact without first name
    # Expect it to have one error, on first name
    expect(build(:contact, firstname: nil)).to have(1).errors_on(:firstname)
    # expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  end

  it 'is invalid without a last name' do
    # expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
    expect(build(:contact, lastname: nil)).to have(1).errors_on(:lastname)
  end

  it 'is invalid with a duplicate email address' do
    # hard code the email address, or else it will be sequenced
    create(:contact, email_address: 'bobsen@gmail.com')
    contact = build(:contact, email_address: 'bobsen@gmail.com')
    expect(contact).to have(1).errors_on(:email_address)
  end

  it "returns a contact's full name as a string" do
    contact = build(:contact, firstname: 'Bob', lastname: 'Bobsen')
    expect(contact.name).to eq('Bob Bobsen')
  end

  describe 'filter last name by letter' do
    before :each do
      @smith = create(:contact, firstname: 'John', lastname: 'Smith', email_address: 'john@gmail.com')
      @jones = create(:contact, firstname: 'Tim', lastname: 'Jones', email_address: 'tim@gmail.com')
      @johnson = create(:contact, firstname: 'John', lastname: 'Johnson', email_address: 'johnson@gmail.com')
    end

    context "matching letters" do
       it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to eq [@johnson, @jones]
      end
    end

    context "non-matching letters" do
      it "returns a sorted array of results that match" do
        expect(Contact.by_letter("J")).to_not include [@smith]
      end
    end
  end

end