require "ias/version"
# include ActionView::Helpers::TagHelper

module Ias
  class View
    def self.table(data)
      attrs = data[0].attribute_names
      out = '<table class="table table-sm table-striped table-bordered table-hover">'
        out << '<thead class="thead-light">'
          out << '<tr>'
            attrs.each do |a|
              out << '<th scope="col">'+data.human_attribute_name(a.to_s)+'</th>'
            end
          out << '</tr>'
        out << '</thead>'
        out << '<tbody>'
          data.each do |rec|
            out << '<tr>'
              attrs.each do |a|
                out << '<td>'
                if rec[a]
                  out << rec[a].to_s
                else
                  out << ""
                end
                out << '</td>'     
              end
            out << '</tr>'
          end        
        out << '</tbody>'
      out << '</table>'
      return out
    end
  end
end

