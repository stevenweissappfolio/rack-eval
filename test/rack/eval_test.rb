require_relative '../../lib/rack/eval'

require 'rack'
require 'rack/test'
require 'minitest/autorun'

class Driver
  include Rack::Test::Methods

  def initialize(app)
    @app = app
  end

  def app
    @app
  end
end

module Rack
  class EvalTest < Minitest::Test
    def setup
      app = Rack::Builder.new do
        use Rack::Eval, secret: 'secret'

        run ->(env) { [200, {}, []] }
      end

      @driver = Driver.new(app)
    end

    def test_get
      @driver.get(
        '/',
        {
          'rack.eval' => {
            'secret' => 'secret',
            'src' => "return [200, { 'content-type' => 'text/plain' }, ['GET']]"
          }
        }
      )

      assert_equal 200, @driver.last_response.status
      assert_equal 'text/plain', @driver.last_response['content-type']
      assert_equal 'GET', @driver.last_response.body
    end

    def test_post
      @driver.post(
        '/',
        {
          'rack.eval' => {
            'secret' => 'secret',
            'src' => "return [201, { 'content-type' => 'text/html' }, ['POST']]"
          }
        }
      )

      assert_equal 201, @driver.last_response.status
      assert_equal 'text/html', @driver.last_response['content-type']
      assert_equal 'POST', @driver.last_response.body
    end
  end
end
