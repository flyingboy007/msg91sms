# Msg91sms

A ruby gem for using the Msg91 REST API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'msg91sms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install msg91sms
    
In the initialiser add authkey:

You can find your authkey here
https://control.msg91.com/user/index.php#api
```ruby
Msg91sms.configure do |config|
  config.authkey = "Put your msg94 authkey here"
end
```

## Usage

_**Transactional sms**_
```ruby
     Msg91sms::TransactionalSms.deliver(sender, country_code, mobile, message)  
```
_sender:_ 6 digit sender name eg:`"PTSHOP"`

_country_code:_ country code without + or zeros EG: `"91"` for india

_mobile:_ mobile number without starting zeros or country code eg: `"7234567891"`

_message:_ message, eg: `"hi"`

**Example**

    
     #returns response in json format
     response=Msg91sms::TransactionalSms.deliver("91", "7234567891", "message", "RDTEST")
    

     #success response
     #if type=='success' message will contain just an id from msg91
     {"message"=>"37666d6d4b4a364443303836", "type"=>"success"}
     
     #error response
     #if type=='error' message will contain the reason for error
     {"message":"Please Enter Valid Sender ID","type":"error"}

// send express otp, returns otp code

// verify express otp, returns boolean

// send transactional message

## Development
We hope that you will consider contributing to Msg91sms. Please read this short overview for some information about how to get started:

* provide tests and documentation whenever possible. It is very unlikely that we will accept new features or functionality into Msg91sms without the proper testing and documentation. When fixing a bug, provide a failing test case that your patch solves.

* open a GitHub Pull Request with your patches and we will review your contribution and respond as quickly as possible. Keep in mind that this is an open source project, and it may take me some time to get back to you. Your patience is very much appreciated.



You will usually want to write tests for your changes. To run the test suite, go into top-level directory and run "bundle install" and "bundle exec rspec".

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/flyingboy007/msg91sms. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

