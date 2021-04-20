# frozen_string_literal: true

module RuboCop
  module Cop
    module Performance
      # Warns when calling #find_each when we could use #find_each or #find_in_batches
      #
      # @example
      #
      #   # bad
      #   array.each_slice { |slice| puts slice.first }
      #
      #   # bad
      #   users = User.where(cool: true)
      #   users.each_slice do |user|
      #     puts user.first_name
      #   end
      #
      #   # good
      #   User.all.find_each do |user|
      #     puts user.first_name
      #   end
      #
      #   # good
      #   User.find_in_batches do |batch|
      #     puts batch.size
      #   end
      #
      class NoEachSlice < Base
        MSG = 'Use `#find_each` or `find_in_batches instead of `#each_slice`.'
        RESTRICT_ON_SEND = %i[each_slice].freeze

        def_node_matcher :bad_method?, <<~PATTERN
          (send $_ :each_slice)
        PATTERN

        def on_send(node)
          return unless bad_method?(node)

          add_offense(node)
        end
      end
    end
  end
end
