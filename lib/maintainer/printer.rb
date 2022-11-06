module Maintainer
  class Printer
    def self.members
      Member.all.each do |member|
        puts member.name
      end
    end
  end
end