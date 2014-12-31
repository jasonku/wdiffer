class Passage
  include ActiveModel::Model

  ALLOWED_VERSIONS = %w(esv nasb)
  TOKEN = '4DeHOMXXefsifxk29w7s8UI9MNKV9BCkipdkUOoZ3'

  attr_accessor :query, :version

  def initialize(query, version)
    unless ALLOWED_VERSIONS.include?(version)
      raise "'#{version}' is not a valid version."
    end

    @uri = URI("http://#{version}.literalword.com")
    @uri.query = URI.encode_www_form(
      q: query,
      format: 'json',
      token: TOKEN,
    )
  end

  def content
    response = Net::HTTP.get_response(@uri)
    begin
      JSON.parse(response.body)
    rescue JSON::ParserError => e
      false
    end
  end

end
