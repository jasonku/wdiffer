# Remove the header so we can replace it with a link.
README = File.readlines("#{Rails.root}/README.md")[1..-1].join('')
