class Module

      def create_finder_methods(*attributes)
        attributes.each do |attribute|
          method = %Q{
            def find_by_#{attribute}(val)
              all.find{|item| item.#{attribute} == val }
            end
          }
          class_eval(method)
        end
     end
     create_finder_methods(:brand, :name)
end
