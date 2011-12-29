#Meta Grabber Ruby

Meta Grabber is Ruby gem that parses the source of a page, and returns useful meta information such as title, keywords, description etc.

The usage is extremely simple and straight forward, and anybody should be able to use it without too much trouble.

###Installation

```ruby
gem install meta_grabber

```

###Usage

```ruby
require 'meta_grabber'
require 'open-uri'


grabber = MetaGrabber.new(open('http://www.ebay.com'))

p grabber.grab_meta
#=> {"keywords"=>"ebay, electronics, cars, clothing, apparel, collectibles, sporting goods, digital cameras, antiques, tickets, jewelry, online shopping, auction, online auction", "description"=>"Buy and sell electronics, cars, clothing, apparel, collectibles, sporting goods, digital cameras, and everything else on eBay, the world's online marketplace. Sign up and begin to buy and sell - auction or buy it now - almost anything on eBay.com", "verify-v1"=>"j6ZKbG61n+f9pUtbkf69zFRBrRSeUqyfEJ2BjiRxWDQ=", "y_key"=>"acf32e2a69cbc2b0", "msvalidate.01"=>"31154A785F516EC9842FC3BA2A70FB1A"}

puts grabber.meta_title
#=> eBay | Electronics, Cars, Clothing, Collectibles and More Online Shopping

p grabber.keywords_array
#=> ["ebay", "electronics", "cars", "clothing", "apparel", "collectibles", "sporting goods", "digital cameras", "antiques", "tickets", "jewelry", "online shopping", "auction", "online auction"]


```

Theres a few more functions, check the code. Its only 35 lines long.