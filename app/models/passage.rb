require 'net/http'
require 'cgi'

class Passage
  include ActiveModel::Model

  ALLOWED_VERSIONS = %w(esv nasb)

  attr_accessor :query, :version

  def initialize(query, version)
    unless ALLOWED_VERSIONS.include?(version)
      raise "'#{version}' is not a valid version."
    end

    @uri = URI.parse("https://#{version}.literalword.com?q=#{CGI.escape(query)}&format=json&token=#{ENV['LITERAL_WORD_TOKEN']}")
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = true
  end

  def content
    response = @http.get(@uri.request_uri)
    if response.code == "200"
      begin
        JSON.parse(response.body)
      rescue JSON::ParserError => e
        false
      end
    end
  end

end
