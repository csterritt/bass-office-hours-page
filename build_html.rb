#!/usr/bin/env ruby
require 'json'

SUFFIX = <<EOF
  </body>
</html>
EOF

def build_list_of_bohs
  output = "<ul>"
  data = JSON.parse(File.read("data.json"))
  data.each do |map|
    output << "<li>\n"
    output << "  <a href=\"#{map['url']}\" rel=\"nofollow\">\n"
    output << "    <span>#{map['name']}</span> on <span>#{map['date']}</span>\n"
    output << "  </a>\n"
    output << "</li>\n"
    output << "\n"
  end
  output << "</ul>"

  output
end

def build_html(content)
  File.open("index.html", "w") do |outf|
    File.open("prefix.html", "r") do |inf|
      inf.each_line do |line|
        outf.puts line
      end
    end

    outf.puts content

    outf.puts SUFFIX
  end
end

# ----------------------------------------------------------------
# Main
build_html(build_list_of_bohs)
