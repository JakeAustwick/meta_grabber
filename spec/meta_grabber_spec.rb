require_relative '../lib/meta_grabber'

describe MetaGrabber do

	it "should grab the title tag out of the source when the tag is correctly formatted" do
		source = '<html><head><title>Some Awesome Title</title></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.title.should == "Some Awesome Title"
  end

  it "should grab the title tag out of the source when the tag is CAPITALS" do
		source = '<html><head><TITLE>These tags are captials</TITLE></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.title.should == "These tags are captials"
  end

  it "should grab the title tag out of the source when the tag is MiXeD CaSe" do
		source = '<html><head><TitLe>These tags are captials</tITlE></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.title.should == "These tags are captials"
  end

  it "should return a empty string when there is no title tag" do
		source = '<html><head></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.title.should be_empty
  end

  it "should return over <title> over <meta title... />" do
		source = '<html><head><title>Some title that should be returned</title><meta name="title" content="Meta title" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.title.should == "Some title that should be returned"
  end

  it "should return <meta title... /> over <title>" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="title" content="The page title" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta_title.should == "The page title"
  end

  it "should return meta description" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="description" content="meta description" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_empty
		grabber.meta['description'].should_not be_nil
		grabber.meta['description'].should == "meta description"
  end

  it "should return meta keywords as a string" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="keywords" content="some keyword, and another keyword, one more for good measure" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['keywords'].should be_kind_of(String)
  end


  it "should return nil before grabbing meta" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="keywords" content="some keyword, and another keyword, one more for good measure" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.keywords_array.should be_nil

		grabber.grab_meta
  end

  it "should return meta keywords as an array" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="keywords" content="some keyword, and another keyword, one more for good measure" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.keywords_array.should be_kind_of(Array)
  end

  it "should return nil before meta is collected" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="keywords" content="some keyword, and another keyword, one more for good measure" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.keywords_array.should be_nil

		grabber.grab_meta
  end

  it "should return nil for a meta tag that doesn't exist" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="description" content="meta description" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['dont-exist'].should be_nil
  end

  it "should return ALL meta tags that don't have no name" do
		source = '<html><head><title>Some title that should not be returned</title><meta name="description" content="meta description" /><meta name="another-tag" content="another tag" /><meta content="no name, so shouldn\'t appear" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
		grabber.meta['another-tag'].should_not be_nil

		grabber.meta['dont-exist'].should be_nil
  end

  #Now onto the case insensitive testing

  it "should return tags in all lower case" do
		source = '<html><head><meta name="description" content="meta description" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
  end

  it "should return tags in all capitals" do
		source = '<html><head><META NAME="description" CONTENT="meta description" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
  end

  it "should return tags with mixed case" do
		source = '<html><head><mETa NAMe="description" COntENT="meta description" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
  end

  it "should return tags with some words of each" do
		source = '<html><head><meta name="description" CONTENT="meta description" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
  end

  #Now onto the case wierd syntax, and other tests that don't fit elsewhere

  it "should return tags which dont close" do
		source = '<html><head><meta name="description" content=="meta description" </head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
  end

  it "should return tags aren't inside <head>" do
		source = '<html><body><meta name="description" content=="meta description" /></body></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
  end

  it "should return tags which have other attributes we don't collect" do
		source = '<html><head><meta name="description" content=="meta description" another-attribute="something" another="testing" /></head></html>'
		grabber = MetaGrabber.new(source)
		grabber.grab_meta
		grabber.meta['description'].should_not be_nil
  end

end