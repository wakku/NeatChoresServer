require 'spec_helper'

describe ChangeDetectorController do

	describe 'RESTful API' do

		let(:text1) 		{ "text1" }
		let(:text2) 		{ "text2" }
		let(:diff)  		{ '{"text1" >> "text2"}' }
		let(:html_diff) { '<del class="differ">text1</del><ins class="differ">text2</ins>' }

		context 'Unformatted request' do

			context 'POST with correct params' do

				before do
					post :detect,
					     :original => text1,
					     :amended => text2
				end

				it 'Should receive a response status 200' do
					@response.status.should be == 200
				end

				it 'Should receive a response with the diff result' do
					@response.body.should == diff
				end
			end

			context 'POST with missing params' do

				before { post :detect }

				it 'Should receive a response status 400' do
					@response.status.should be == 400
				end
				it 'Should receive the response message "2 Inputs expected"' do
					@response.body.should be == "2 Inputs expected"
				end
			end
		end

		context 'HTML output request' do

			before do
				post :detect,
						 :original => text1,
						 :amended => text2,
						 :format => 'html'
			end

			it 'Should receive a response formatted as HTML' do
				@response.body.should be == html_diff
			end

		end

		context 'Invalid output format request' do

			before do
				post :detect,
						 :original => text1,
						 :amended => text2,
						 :format => 'wrong'
			end

			it 'Should receive a response formatted as HTML' do
				@response.status.should be == 400
				@response.body.should be == "Invalid format specified. Please see API documentation for valid format types."
			end

		end
	end
end
