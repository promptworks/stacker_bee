module StackerBee
  module Middleware
    class EndpointNormalizer < Base
      def before(env)
        env.request.endpoint_name =
          endpoint_name_for(env.request.endpoint_name)
      end

      def endpoint_name_for(name)
        # TODO: shouldn't this be in the base endpoint?
        fail "API required" unless api
        endpoint_description = api[name]
        endpoint_description.fetch("name") if endpoint_description
      end
    end
  end
end