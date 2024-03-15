.PHONY: test

install:
	bundle install

test:
	bundle exec ruby ./test/rack/eval_test.rb
