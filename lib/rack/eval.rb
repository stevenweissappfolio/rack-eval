module Rack
  class Eval
    VERSION = '0.1.0'

    attr_reader :app, :secret

    def initialize(app, secret:)
      @app = app
      @secret = secret
    end

    def call(env)
      req = Request.new(env)

      if secret == req.params.dig('rack.eval', 'secret').to_s
        eval req.params.dig('rack.eval', 'src').to_s
      end

      app.call(env)
    end
  end
end
