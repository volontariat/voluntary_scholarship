module VoluntaryScholarship
  module Navigation
    def self.code
      Proc.new do |navigation|
        navigation.items do |primary|
          primary.dom_class = 'nav'
        end
      end
    end
  end
end
    