require 'meta_grabber'
require 'open-uri'


grabber = MetaGrabber.new(open('http://www.ebay.com'))

p grabber.grab_meta

puts grabber.meta_title
puts grabber.title

p grabber.keywords_array