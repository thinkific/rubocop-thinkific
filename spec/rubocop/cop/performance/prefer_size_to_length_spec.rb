# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Performance::PreferSizeToLength do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }
  let(:msg) { RuboCop::Cop::Performance::PreferSizeToLength::MSG }

  def module_example(line, error_snippet, offset = 0)
    <<~RUBY
      module Thing
      array = [1, 2, 3, 4, 5]
        array.each do |item|
          puts item
        end
        #{line}
        #{warning_msg(error_snippet, msg, offset)}
        something_else!
      end
    RUBY
  end

  context 'with an offense' do
    %w[length].each do |meth|
      it "when using `#{meth}`" do
        expect_offense(<<~RUBY)
          array.#{meth}
          #{warning_msg("array.#{meth}", msg)}
        RUBY
      end

      it "when using `#{meth}` in an if block" do
        expect_offense(<<~RUBY)
          if 3
            array.#{meth}
            #{warning_msg("array.#{meth}", msg)}
          end
        RUBY
      end

      it "when sending `#{meth}`" do
        expect_offense(<<~RUBY)
          array.send(:#{meth})
          #{warning_msg("array.send(:#{meth})", msg)}
        RUBY
      end

      it "in a module using `#{meth}`" do
        expect_offense(
          module_example("array.#{meth} unless false", "array.#{meth}")
        )
      end

      it "in a module sending `#{meth}`" do
        expect_offense(
          module_example("array.send(:#{meth}) unless false", "array.send(:#{meth})")
        )
      end
    end
  end

  context 'without an offense' do
    %w[count size].each do |meth|
      it "when using `#{meth}`" do
        expect_no_offenses(<<~RUBY)
          array.#{meth}
        RUBY
      end

      it "when sending `#{meth}`" do
        expect_no_offenses(<<~RUBY, meth: meth)
          array.send(:#{meth})
        RUBY
      end
    end
  end
end
