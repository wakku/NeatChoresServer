module Differ
  class Diff
    def initialize
      @raw = []
    end

    def same(*str)
      return if str.empty?
      if @raw.last.is_a? String and !(@raw.last =~ tag)
        @raw.last << sep
      elsif @raw.last.is_a? Change
        if @raw.last.change? and !(@raw.last.to_s =~ tag)
          @raw << sep
        else
          change = @raw.pop
          if change.insert? && @raw.last
            @raw.last << sep if change.insert.sub!(/^#{Regexp.quote(sep)}/, '') and !(@raw.last.to_s =~ tag)
          end
          if change.delete? && @raw.last
            @raw.last << sep if change.delete.sub!(/^#{Regexp.quote(sep)}/, '') and !(@raw.last.to_s =~ tag)
          end
          @raw << change
          
          @raw.last.insert << sep if @raw.last.insert? and !(@raw.last.to_s =~ tag)
          @raw.last.delete << sep if @raw.last.delete? and !(@raw.last.to_s =~ tag)
          @raw << ''
        end
      else
        @raw << ''
      end
      @raw.last << str.join(sep) if !(@raw.last.to_s =~ tag)
    end

    def delete(*str)
      return if str.empty?
      if @raw.last.is_a? Change and !(@raw.last.to_s =~ tag)
        change = @raw.pop
        if change.insert? && @raw.last
          @raw.last << sep if change.insert.sub!(/^#{Regexp.quote(sep)}/, '') and !(@raw.last.to_s =~ tag)
        end
        change.delete << sep if change.delete? and !(@raw.last.to_s =~ tag)
      else
        change = Change.new(:delete => (@raw.empty? || @raw.last.to_s =~ tag) ? '' : sep)
      end

      @raw << change
      if @raw.last.to_s =~ tag
      	@raw.last.delete << str.join('')
      else
      	@raw.last.delete << str.join(sep)
      end
    end

    def insert(*str)
      return if str.empty?
      if @raw.last.is_a? Change
        change = @raw.pop
        if change.delete? && @raw.last
          @raw.last << sep if change.delete.sub!(/^#{Regexp.quote(sep)}/, '')  and !(@raw.last.to_s =~ tag)
        end
        change.insert << sep if change.insert? and !(@raw.last.to_s =~ tag)
      else
        change = Change.new(:insert => (@raw.empty? || @raw.last.to_s =~ tag) ? '' : sep)
      end

      @raw << change
      if @raw.last.to_s =~ tag
      	@raw.last.insert << str.join('')
      else
      	@raw.last.insert << str.join(sep)
      end
    end

    def ==(other)
      @raw == other.raw_array
    end

    def to_s
      @raw.join('')
    end

		def raw
			@raw
		end

    def format_as(f)
      f = Differ.format_for(f)
      @raw.inject('') do |sum, part|
        part = case part
        when String then part
        when Change then f.format(part)
        end
        sum << part
      end
    end

  protected
    def raw_array
      @raw
    end

  private
    def sep
      "#{$;}"
    end
    
    def tag
    	/<\/*[\w "'=\/:\.\-_?]+>/
    end
  end
end
