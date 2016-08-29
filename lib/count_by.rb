class Module
      def create_count_methods(*attributes)
        attributes.each do |attribute|
          method = %Q{
            def count_by_#{attribute}(vals)
              collect = {}
              vals.each do |val|
                collect[val.#{attribute}] == nil ? collect[val.#{attribute}] = 1 : collect[val.#{attribute}] += 1
              end
              collect
            end
          }
          class_eval(method)
        end
     end
     create_count_methods(:brand, :name)
end
