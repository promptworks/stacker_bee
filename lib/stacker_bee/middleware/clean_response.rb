module StackerBee
  module Middleware
    class CleanResponse < Base
      def after(env)
        body = env.response.body

        return unless hash?(body)

        if contains_count?(body)
          env.response.body = remove_count(body)
        elsif single_hash?(body)
          env.response.body = first_hash(body)
        end
      end

      def hash?(body)
        body.respond_to?(:keys)
      end

      def contains_count?(body)
        body.size == 2 && body.key?("count")
      end

      def remove_count(body)
        body.reject { |key, _| key == "count" }.values.first
      end

      def single_hash?(body)
        body.size == 1 && body.values.first.respond_to?(:keys)
      end

      def first_hash(body)
        body.values.first
      end

      def content_types
        /javascript/
      end
    end
  end
end
