
module NulloObject
  class Nullo < BasicObject

    # FIXME determine whether create a singleton instance for the nil case.. perhaps no because it accepts another param besides the object

    def initialize(parent_object)
      @parent_object = parent_object
      # FIXME perhaps this variable should not be here
    end

    # FIXME definte methos if_nil(), with the parameter to return when it's nil (string_with_nil)

    # FIXME method for returning the parent object

    def nil?
      @parent_object.nil?
    end

    def blank?
      @parent_object.blank?
    end

    def to_s
      @parent_object.to_s
    end

    def _nullo
      @parent_object
    end

    def _
      @parent_object
    end

    def if_nil(value_when_nil=nil)
      if @parent_object.nil?
        value_when_nil
      else
        @parent_object
      end
    end

    def method_missing(method, *args, &block)
      #::Kernel::puts "#{@parent_object} - #{method}"
      if @parent_object.nil?
        ::NulloObject::Nullo.new(nil)
      else
        ::NulloObject::Nullo.new(@parent_object.send(method, *args, &block))
      end
    end
  end
end
