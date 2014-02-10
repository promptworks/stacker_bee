module StackerBee
  module Middleware
    class Base < OpenStruct
      def call(env)
        before env
        app.call env
        after env
      end

      def before(env)
        env.request.params = params(env.request.params)
      end

      def after(env)
      end

      def params(params)
        params
      end

      def endpoint_name_for(endpoint_name)
        app.endpoint_name_for(endpoint_name)
      end
    end
  end
end
