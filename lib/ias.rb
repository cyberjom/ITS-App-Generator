require "ias/version"

module Ias
  class View
    def self.table(data)
      out = '<table class="table">'
        out << '<thead class="thead-light">'
          out << '<tr>'
            data[:headers].each do |h|
              out << '<th scope="col">'+h.to_s+'</th>'
            end
          out << '</tr>'
        out << '</thead>'
        out << '<tbody>'
        out << '</tbody>'
      out << '</table>'
      return out
    end
  end
end
