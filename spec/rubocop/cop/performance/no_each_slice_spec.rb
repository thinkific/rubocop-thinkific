# frozen_string_literal: true

MATCHING_METHODS = %w[each_slice].freeze
NON_MATCHING_METHODS = %w[find_each find_in_batches].freeze

RSpec.describe RuboCop::Cop::Performance::NoEachSlice, :config do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }
  let(:msg) { RuboCop::Cop::Performance::NoEachSlice::MSG }

  context 'with an offense' do
    MATCHING_METHODS.each do |meth|
      context "when using `#{meth}`" do
        it 'fails inline' do
          expect_offense(<<~RUBY)
            array.#{meth}
            #{warning_msg("array.#{meth}", msg)}
          RUBY
        end

        it 'fails in an if block' do
          expect_offense(<<~RUBY)
            if 3
              array.#{meth}
              #{warning_msg("array.#{meth}", msg)}
            end
          RUBY
        end

        it 'fails in a block' do
          expect_offense(<<~RUBY)
            User.all.#{meth} do |user|
            #{warning_msg("User.all.#{meth}", msg)}
              puts user.first_name
            end
          RUBY
        end
      end
    end
  end

  context 'without an offense' do
    MATCHING_METHODS.each do |meth|
      context "when using `#{meth}`" do
        it 'passes with send' do
          expect_no_offenses(<<~RUBY)
            array.send(:#{meth})
          RUBY
        end
      end
    end

    NON_MATCHING_METHODS.each do |meth|
      context "when using `#{meth}`" do
        it 'passes inline' do
          expect_no_offenses(<<~RUBY)
            array.#{meth}
          RUBY
        end

        it 'passes with send' do
          expect_no_offenses(<<~RUBY)
            array.send(:#{meth})
          RUBY
        end

        it 'passes in a block' do
          expect_no_offenses(<<~RUBY)
            User.all.#{meth} do |user|
              puts user.first_name
            end
          RUBY
        end
      end
    end
  end
end
