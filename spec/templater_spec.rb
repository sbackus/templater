require 'rspec'
require './templater.rb'

describe "Templater" do
	it "returns the template without modifications if it contains no tags" do
		template = "<h1> Pure HTML </h1> \n <p> This has no template tags! </p>"
		expected_result = template
		expect(Templater.render(template, nil)).to eq expected_result
	end
	it "substitutes a template tag with data" do
		template = "<h1> <* title *> </h1>"
		data = {"title"=> "substitution works!"}
		expected_result = "<h1> substitution works! </h1>"
		expect(Templater.render(template, data)).to eq expected_result
	end
	it "substitutes multiple template tags with data" do
		template = "<h1> <*title*> </h1> <p> <*body*> </p>"
		data = {"title"=> "substitution works!", "body"=> "for the body too!"}
		expected_result = "<h1> substitution works! </h1> <p> for the body too! </p>"
		expect(Templater.render(template, data)).to eq expected_result
	end
	it "substitutes a template tag using nested data" do
		template = "<h1> <*page.title*> </h1> <p> <*page.body.p1*> </p>"
		data = {"page"=>{"title"=> "title of the page", "body"=> {"p1"=> "first p of the body of the page"}}}
		expected_result = "<h1> title of the page </h1> <p> first p of the body of the page </p>"
		expect(Templater.render(template, data)).to eq expected_result
	end
	it "recognizes the EACH tag" do
		template = "<* EACH students student *><* ENDEACH *>"
		data = {}
		expected_result = ""
		expect(Templater.render(template, data)).to eq expected_result
	end
	it "renders the contents of the EACH tag once for each thing in the list" do
		template = "<* EACH students student *>student<* ENDEACH *>"
		data = {"students" => [1,2,3,4,5]}
		expected_result = "student"*5
		expect(Templater.render(template, data)).to eq expected_result
	end
	it "creates a new context for each item in the list and can use the new context for varible tags" do
		template = "<* EACH students student *><*student.name*>, <* ENDEACH *>"
		data = {"students" => [{"name"=>"Miles Morales"},{"name"=>"kamala khan"},{"name"=>"Barbara Gordon"}]}
		expected_result = "Miles Morales, kamala khan, Barbara Gordon, "
		expect(Templater.render(template, data)).to eq expected_result
	end
	it "handles nested EACH" do
		template = "<* EACH students student *><* EACH student.nicknames nickname *><p><* nickname *></p><* ENDEACH *><* ENDEACH *>"
		data =   {"students"=> [
    { "name"=> "Barbara Gordon", "nicknames"=> ["Bat Girl", "Oracle"] },
    { "name"=> "Miles Morales", "nicknames"=> ["Spidey", "Spiderman", "Spider-Man"] }
  ]}
		expected_result = "<p>Bat Girl</p><p>Oracle</p><p>Spidey</p><p>Spiderman</p><p>Spider-Man</p>"
		expect(Templater.render(template, data)).to eq expected_result
	end
end





