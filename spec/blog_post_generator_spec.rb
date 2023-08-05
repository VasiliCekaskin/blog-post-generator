require_relative '../lib/blog_post_generator'

RSpec.describe BlogPostGenerator do
	subject(:blog_post_generator) { BlogPostGenerator.new }

	describe '#generate' do
		expect(blog_post_generator.generate).to be_truthy
	end
end