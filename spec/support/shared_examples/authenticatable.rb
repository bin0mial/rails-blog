RSpec.shared_examples 'authenticatable' do |factory_name|
  it "validates has an email" do
    model = build(factory_name, email: nil)
    expect(model).to be_invalid
    expect(model.errors[:email]).to include("can't be blank")
  end

  it "validates has an password" do
    model = build(factory_name, password: nil)
    expect(model).to be_invalid
    expect(model.errors[:password]).to include("can't be blank")
  end

  it "validates email must be a valid format" do
    model = build(factory_name, email: "invalid_data")
    expect(model).to be_invalid
    expect(model.errors[:email]).to include("is invalid")
  end

  it "validates password at least must be 6 characters" do
    model = build(factory_name, password: "123")
    expect(model).to be_invalid
    expect(model.errors[:password]).to include("is too short (minimum is 6 characters)")
  end
end