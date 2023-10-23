# frozen_string_literal: true

# service for loading InfoCard data
class InfoCardLoadingService
  def import
    data_dir = Rails.root.join('data', 'info_files')
    Dir.glob('*.html', base: data_dir).each do |file_name|
      file_path = File.join(data_dir, file_name)
      html = File.read(file_path).strip
      InfoCard.find_or_create_by(path: path_for(file_name), html: fragment_for(html))
    end
  end

  private

  def path_for(file_name)
    "info/#{file_name.chomp('.html')}"
  end

  def fragment_for(html)
    fragment = Nokogiri::HTML.fragment(html)
    if fragment.children.first.name == 'body'
      fragment.search('.//body').first.inner_html.strip
    else
      fragment.to_s.strip
    end
  end
end
