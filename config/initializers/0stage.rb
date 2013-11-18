STAGE = ENV['STAGE'].try(:to_sym) || (Rails.env.test? ? :test : :sandbox)
puts "Running in stage: #{STAGE.to_s}"
