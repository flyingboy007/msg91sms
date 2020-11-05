# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'msg91sms/version'

Gem::Specification.new do |spec|
  spec.name = "msg91sms"
  spec.version = Msg91sms::VERSION
  spec.authors = ["flyingboy007"]
  spec.email = ["abhilashvr007@gmail.com"]

  spec.summary = "A ruby gem for using the Msg91 REST API"
  spec.description = "Easily send messages using msg91 api"
  spec.homepage = "https://github.com/flyingboy007/msg91sms"
  spec.license = "MIT"


  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) {|f| File.basename(f)}
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "rspec", "~> 3.10.0"
  spec.add_development_dependency "vcr", "~> 6.0.0"
  spec.add_development_dependency "webmock", "~>3.9.3"
  spec.add_development_dependency "guard-rspec", "~>4.7.3"

end
