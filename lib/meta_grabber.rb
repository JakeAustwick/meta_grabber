require 'nokogiri'

class MetaGrabber

	attr_reader :doc, :meta
	
	def initialize(page_source)
		@doc = Nokogiri::HTML::parse(page_source)
		@meta = {}
	end

	def title
		@title ||= @doc.xpath("//title").text rescue nil
	end

	#Some sites do <meta name="title" ... /> for some wierd reason
	def meta_title
		@meta['title'] ||= title
	end

	def grab_meta
		# grab each meta tag
		for i in @doc.xpath("//meta") do
			next if !i[:name] #dont really care about these, http types etc
			@meta[i[:name].to_s.downcase] = i[:content]
		end

		@meta
	end

	def keywords_array
		@meta['keywords'] ? @meta['keywords'].split(",").map{|kw| kw.strip} : nil
	end

end