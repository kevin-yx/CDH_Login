PDFKit.configure do |config|
  # config.default_options[:quiet] = false
  config.wkhtmltopdf = '/usr/local/bin/wkhtmltopdf'

  config.default_options = {
      :encoding => "UTF-8",
      :page_size => "A4",
      # :zoom => '1',
      :disable_smart_shrinking => false,
      :print_media_type => true
  }
  # config.default_options = {
  #     :encoding=>"UTF-8"
  #
  # }
  # config.default_options = { :page_size => 'Legal', :print_media_type => true }
end

