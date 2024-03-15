require_relative './lib/rack/eval'

Gem::Specification.new do |s|
  s.name = 'rack-eval'
  s.version = Rack::Eval::VERSION
  s.summary = 'Evaluates Ruby Code'
  s.description = 'Evaluates Ruby Code'
  s.license = 'MIT'
  s.authors = ['Steven Weiss']
  s.email = ['steven.weiss@appfolio.com']
  s.homepage = 'https://github.com/stevenweissappfolio/rack-eval'
  s.files = `git ls-files`.split('\n')
  s.add_dependency 'rack', '>= 3.0.0'
  s.add_development_dependency 'rack-test'
  s.add_development_dependency 'minitest'
end
