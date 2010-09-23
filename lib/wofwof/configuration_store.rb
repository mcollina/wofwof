
module WofWof
  class ConfigurationStore

    def initialize
      @store = { :default_template => nil }
    end

    def respond_to?(method)
      if @store.has_key? method.to_sym or @store.has_key? method.to_s.gsub(/[=\?]$/, "").to_sym
        return true 
      end
      super
    end

    private
    def method_missing(name, *args, &block)
      if name.to_s =~ /=$/ 
        @store[name.to_s.gsub(/=$/, "").to_sym] = args.first
        return args.first
      else
        raise "the #{name.to_s} method accept zero arguments" if args.size != 0 
        return @store[name.to_s.gsub(/\?$/, "").to_sym]
      end
    end
  end
end
