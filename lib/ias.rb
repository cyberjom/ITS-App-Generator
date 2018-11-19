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
    
    def self.show(data)
      path = "/"+data.class.to_s.pluralize.downcase
      attrs = data.attribute_names
      
      out = "#{link_to " Add ", path+'/new'}"
      out << "#{link_to " Edit ", path+'/'+data[:id].to_s+'/edit'}"
      out << "#{link_to " Delete ", path}"
      out << '<br>'
      out << '<table class="table table-sm table-striped table-bordered table-hover">'
        out << '<thead class="thead-light">'
          out << '<tr>'
            out << '<th scope="col">'+"#"+'</th>'          
            out << '<th scope="col">'+"Field"+'</th>'
            out << '<th scope="col">'+"Value"+'</th>'
          out << '</tr>'
        out << '</thead>'
        out << '<tbody>'
        i = 1
        attrs.each do |a|
          out << '<tr>'
            out << "<td>#{i.to_s}</td>"
            out << "<td>#{a.to_s}</td>"
            out << '<td>'
            if data[a]
              out << data[a].to_s
            else
              out << ""
            end
            out << '</td>'
          out << '</tr>'
          i += 1
        end
        out << '</tbody>'
      out << '</table>'
      return out      
    end
    
    def self.table(data)
      patch_row = data.limit_value-data.count
      path = "/"+data.model.to_s.pluralize.downcase
      prevp = data.prev_page || 1
      lastp = data.total_pages
      nextp = data.next_page || lastp
      
      attrs = data[0].attribute_names-["created_at", "updated_at", "created_by_id", "updated_by_id"]
      
      out = '<table class="table table-sm table-striped table-bordered table-hover">'
        out << '<thead class="thead-light">'
          out << '<tr>'
            attrs.each do |a|
              if a=="id"
                out << '<th scope="col">'+'#'+'</th>'
              else
                out << '<th scope="col">'+data.human_attribute_name(a.to_s)+'</th>'
              end
            end
          out << '</tr>'
        out << '</thead>'
        out << '<tbody>'
          data.each do |rec|
            out << '<tr>'
              attrs.each do |a|
                out << '<td>'
                if rec[a]
                  if a=="id"
                    out << "#{link_to rec[a].to_s, path+'/'+rec[a].to_s}"
                  else
                    out << rec[a].to_s
                  end
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

