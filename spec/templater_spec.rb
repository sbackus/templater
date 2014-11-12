require 'rspec'
require './templater.rb'

# TODO:
# loop over lists of values

# Questions:
# what happens if there is a string that contains the symbols for a template tag?  " <* not a template tag? *> "
# what am I doing about error handling?  invalid input?

# Assumptions:



describe "Templater" do
	it "returns the template without modifications if it contains no tags" do
		template = "<h1> Pure HTML </h1> \n <p> This has no template tags! </p>"
		expected_result = template
		expect(Templater.new(template).render(nil)).to eq expected_result
	end
	it "substitutes a template tag with data" do
		template = "<h1> <* title *> </h1>"
		data = {"title"=> "substitution works!"}
		expected_result = "<h1> substitution works! </h1>"
		expect(Templater.new(template).render(data)).to eq expected_result
	end
	it "substitutes multiple template tags with data" do
		template = "<h1> <*title*> </h1> <p> <*body*> </p>"
		data = {"title"=> "substitution works!", "body"=> "for the body too!"}
		expected_result = "<h1> substitution works! </h1> <p> for the body too! </p>"
		expect(Templater.new(template).render(data)).to eq expected_result
	end
	it "substitutes a template tag using nested data" do
		template = "<h1> <*page.title*> </h1> <p> <*page.body.p1*> </p>"
		data = {"page"=>{"title"=> "title of the page", "body"=> {"p1"=> "first p of the body of the page"}}}
		expected_result = "<h1> title of the page </h1> <p> first p of the body of the page </p>"
		expect(Templater.new(template).render(data)).to eq expected_result
	end
	it "recognizes the EACH tag" do
		template = "<* EACH students student *><* ENDEEACH *>"
		data = nil
		expected_result = ""
		expect(Templater.new(template).render(data)).to eq expected_result
	end
end





