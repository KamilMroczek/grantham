if Rails.env.production?
  Paperclip::Attachment.default_options[:url] = 'grantham-uploads.s3.amazonaws.com'
  UPLOAD_BASE_PATH = "/film"
else
  Paperclip::Attachment.default_options[:url] = nil
  UPLOAD_BASE_PATH = "/Users/kamilmroczek/workspace/kamil/grantham/tmp"
end
# Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:filename_:style'