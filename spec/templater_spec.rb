require 'rspec'
require './templater.rb'

# TODO:
# key value substitution
# loop over lists of values

# Questions:
# what happens if there is a string that contains the symbols for a template tag?  " <* not a template tag? *> "
# what am I doing about error handling?  invalid input?

# Assumptions:



describe "templater" do
	it "returns the template without modifications if it contains no tags" do
		template = "<h1> Pure HTML </h1> \n <p> This has no template tags </p>"
		expected_result = template
		expect(templater(template, nil)).to eq expected_result
	end
end





