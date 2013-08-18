# Dixon

[![Gem Version](https://badge.fury.io/rb/dixon.png)](http://badge.fury.io/rb/dixon)
[![Travis Build Status](https://api.travis-ci.org/JuanitoFatas/dixon.png)](https://travis-ci.org/JuanitoFatas/dixon)

[Frank] Dixon checks your ID number.

![Frank Dixon checks your ID number.](https://dl.dropboxusercontent.com/u/4708852/img/jZiiuPkCYYnRWQCzCjzLrg-frank-dixon.jpeg)

*Credit: http://www.quotefully.com/*

Dixon now only supports identification number check for Taiwan, more are coming up.

## Requirements

Ruby 2.0+

## Installation

    $ gem install dixon

## API

Provides three instance methods: `checks`, `gender`, and `issued_by`.

* `checks` checks if given ID is a valid Taiwan identification number.

* `gender` returns gender of given ID.

* `issued_by` returns which local agencies issued this ID.

## Usage

    Dixon::Validators::Taiwan.new.checks 'A123456789'
    => true

    Dixon::Validators::Taiwan.new.gender 'A123456789'
    => "male"

    Dixon::Validators::Taiwan.new.issued_by 'A123456789'
    => "Taipei City"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add & Run the test: `$ rake test`
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request

## Author

Juanito Fatas

## License

MIT License