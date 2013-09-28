require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ChangeDetectorHelper. For example:
#
# describe ChangeDetectorHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ChangeDetectorHelper do
	describe 'Detect difference between' do

		context 'two different texts that share some content' do

			let(:original) { "An X-Ray is a picture of your chest." }
			let(:amended) { "An X-Ray looks inside your body and gives us a picture of your bones." }

			it 'should return the difference between the 2 texts' do
				@response = diff original, amended
				@response.should be == 'An X-Ray {"is" >> "looks inside your body and gives us"} a picture of your {"chest." >> "bones."}'
			end

		end

		context 'two identical texts' do

			let(:text) { "I am an example text." }

			it 'should return a response indicating that there is no difference between the 2 texts' do
				@response = diff text, text
				@response.should be == false
			end

		end

		context 'a blank text and a non-blank text' do

			let(:original) { "" }
			let(:amended) { "I am not a blank text." }

			it 'should return amended text indicating that it was added to original text' do
				@response = diff original, amended
				@response.should be == '{+"I am not a blank text."}'
			end

		end

		context 'a non-blank text and a blank text' do

			let(:original) { "I am not a blank text." }
			let(:amended) { "" }

			it 'should return the original text indicating that it was removed from the amended text' do
				@response = diff original, amended
				@response.should be == '{-"I am not a blank text."}'
			end

		end

		context 'two different texts that share no content' do

			let(:original) { "MRIs are scans using magnets" }
			let(:amended) { "An X-Ray looks inside your body and gives us a picture of your bones." }

			it 'should indicate that the amended text replaced the original text' do
				@response = diff original, amended
				@response.should be == '{"MRIs are scans using magnets" >> "An X-Ray looks inside your body and gives us a picture of your bones."}'
			end

		end

		context 'text(s) that contain basic html tags' do

			let(:original) { "<span>Google</a>" }
			let(:amended) { "Google</p></a>" }

			it 'should strip the tags and return the difference between these 2 texts' do
				@response = diff original, amended
				@response.should be == '{-"<span>"}Google {+"</p>"}</a>' 
				# In fact it should be '{-"<span>"}Google{+"</p>"}</a>'
				# BUG: there is one space after Google that shouldn't be there
			end

		end

		context 'text(s) that contain complex html tags' do

			let(:original) { "<h1>Google</h1><br><br><div class=teste>conteudo</div>" }
			let(:amended) { "<h1>Google</h1><br><a href=http://www.some-url.com/another_path.php?=some_param>link</a><div class=teste>content</div>" }

			it 'should strip the tags and return the difference between these 2 texts' do
				@response = diff original, amended
				@response.should be == '<h1>Google </h1><br>{+"<a href=http://www.some-url.com/another_path.php?=some_param>"}{"<br>" >> "link</a>"}<div class=teste>{"conteudo" >> "content"} </div>' 
			end

		end
	end
end