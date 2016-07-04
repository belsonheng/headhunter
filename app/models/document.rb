class Document

  include Mongoid::Document
  field :filename, type: String
  field :content_type, type: String
  field :file_contents, type: BSON::Binary
  field :owner_email, type: String

belongs_to :user

  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      self.file_contents = @file.read
    end
  end

  private

    def sanitize_filename(filename)
      return File.basename(filename)
    end

    
end
