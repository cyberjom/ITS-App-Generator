require "ias/version"
# include ActionView::Helpers::TagHelper
include ActionView::Helpers::UrlHelper


module Ias
  class View
    
    def self.list(data, &block)
      block.call
      return table(data)
    end
    
    def self.t

    end
    
    def self.table(data)
      patch_row = data.limit_value-data.count
      path = "/"+data.model.to_s.pluralize.downcase
      prevp = data.prev_page || 1
      lastp = data.total_pages
      nextp = data.next_page || lastp
      
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
          ## Patching rows
          # patch_row.times do
          #   out << '<tr>'
          #     attrs.each do |a|
          #       out << '<td> </td>'
          #     end
          #   out << '</tr>'
          # end
        out << '</tbody>'
      out << '</table>'
      out << '<br>'
      out << "#{link_to '<<', path} #{link_to '<', path+'?page='+prevp.to_s}"
      out << "....."
      out << "#{link_to '>', path+'?page='+nextp.to_s} #{link_to '>>', path+'?page='+lastp.to_s} "
      # out << "#{request}"
      
      return out
    end
  end
end

