require 'securerandom'

module Bucket

  def self.string_generator(length)
    # characters => special chars, integers, letters(uppercase&lowercase)
    characters = (32..126).to_a.pack('U*').chars.to_a
    characters.to_a.shuffle.first(length).join
  end


  def self.string_generator_2(length)
    charset = Array('A'..'Z') + Array('a'..'z')
    Array.new(length) { charset.sample }.join
  end

  def self.integer_generator(length)
    Random.new.rand((10**(length - 1))..(10**length))
  end

  def self.special_chars(length)
    ints = []
    (0..9).each {|e| ints << e.to_s}
    chars = ('!'..'?').to_a - ints
    chars.shuffle[0..length.to_i].join
  end

  def self.stamp(value)
    timestamp = Time.now
    value + "%10.9f" % timestamp.to_f
   end

  def compare(origin, compared)
    return true if origin.is_a?(Hash) && compared.is_a?(Hash) && hash_comparison(origin, compared)
    origin.each do |k, v|
      case v.class.to_s
        when 'Hash'
          return true if hash_comparison(v, compared)
          return true if has_struct_in_hash(v) && compare(v, compared)
        when 'Array'
          v.each do |obj|
            return true if compare(obj, compared)
          end
      end
    end
    return false
  end

  def hash_comparison(hash1, hash2)
    return false unless (hash2.keys - hash1.keys).empty?
    hash2.each do |k, v|
      if ['Hash', 'Array'].include?(v.class.to_s)
        return false unless compare(hash1, v)
      end
      return false if hash1[k] != v
    end
    return true
  end

  def has_struct_in_hash(obj)
    obj.values.find { |h| ['Hash', 'Array'].include?(h.class.to_s) } != nil
  end

  def self.data_creator(hash)
    # hash = {"value" => "random string(100)", "value2" => "integer(29)", "value3" => "true", "value5" => "false",
    #         "value6" => "special chars(38)", "value7" => "nil"}
    # data_creator(hash)
    # =>{"value"=>"qvb1luhtfmy9eajswzp0kg2xn8co67d534ri", "value2"=>5329187064, "value3"=>true,
    # "value5"=>true, "value6"=>"&6>1=0';#<-*5%927(.34:\"$?,/+!)8", "value7"=>nil}
    # avalible params: random string\(\d*\),integer\(\d*\), "true", "false", nil, special chars\(\d*\),
    hash.keys.each do |k|
      # create "length" long random string
      unless hash[k] == nil || hash[k].class != String
        if hash[k].match /random string\(\d*\)/ # "random string(100)"
          length = hash[k].match /\d{1,}/
          length = length[0].to_i
          hash[k] = Forgery('lorem_ipsum').characters(length)
        elsif hash[k].match /random email\(\d*\)/ # "random email"
          length = hash[k].match /\d{1,}/
          length = length[0].to_i
          hash[k] = "#{integer_generator(length-15)}@gmail.com"
        elsif hash[k].match /integer\(\d*\)/ # "integer(100)"
          length = hash[k].match /\d{1,}/
          length = length[0].to_i
          hash[k] = integer_generator(length)
        elsif hash[k].match /special chars\(\d*\)/ # "special chars(100)"
          length = hash[k].match /\d{1,}/
          length = length[0].to_i
          hash[k] = special_chars(length)
        elsif hash[k] == "true"
          hash[k] = true
        elsif hash[k] == "false"
          hash[k] = false
        elsif hash[k] == "nil"
          hash[k] = nil
        end
      end

    end
  end

end


class Hash
  def deep_include?(sub_hash)
    sub_hash.keys.all? do |key|
      self.has_key?(key) && if sub_hash[key].is_a?(Hash)
                              self[key].is_a?(Hash) && self[key].deep_include?(sub_hash[key])
                            else
                              self[key] == sub_hash[key]
                            end

    end
  end

  def keys_diff(ex_res)
    (self.keys - ex_res.keys).any?
  end
end

class Array
  def include_hash?(hash)
    self.each do |node|
      return true if node.deep_include?(hash)
    end
    false
  end
end
