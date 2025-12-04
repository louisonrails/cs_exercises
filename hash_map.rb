# frozen_string_literal: true

class HashMap
  DEFAULT_CAPACITY = 16
  LOAD_FACTOR = 0.75

  def initialize(capacity = DEFAULT_CAPACITY)
    @capacity = capacity
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def hash(key)
    raise ArgumentError, 'Keys must be strings' unless key.is_a?(String)

    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def index_for(key)
    hash(key) % @capacity
  end

  def bucket_at(index)
    raise IndexError if index.negative? || index >= @buckets.length

    @buckets[index]
  end

  def set(key, value)
    raise ArgumentError, 'keys must be strings' unless key.is_a?(String)

    resize! if (@size + 1) > (@capacity * LOAD_FACTOR)

    index = index_for(key)
    bucket = bucket_at(index)

    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        break
      end
    end

    bucket << [key, value]
    @size += 1
  end

  def get(key)
    index = index_for(key)
    bucket = bucket_at(index)

    bucket.each do |pair|
      return pair[1] if pair[0] == key
    end

    nil
  end

  def has?(key)
    !get(key).nil?
  end

  def remove(key)
    index = index_for(key)
    bucket = bucket_at(index)

    bucket.each_with_index do |pair, i|
      next unless pair[0] == key

      removed_value = pair[1]
      bucket.delete_at(i)
      @size -= 1
      return removed_value
    end

    nil
  end

  def length
    @size
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  def keys
    @buckets.flat_map { |bucket| bucket.map(&:first) }
  end

  def values
    @buckets.flat_map { |bucket| bucket.map(&:last) }
  end

  def entries
    @buckets.flat_map { |bucket| bucket.map { |pair| pair } }
  end

  private

  def resize!
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.each do |bucket|
      bucket.each do |key, value|
        set(key, value)
      end
    end
  end
end

map = HashMap.new

map.set('Carlos', 'I am the new value.')
map.set('Rama', 'Value for Rama')
map.set('Sita', 'Value for Sita')

puts map.get('Carlos')
puts map.has?('Sita')

map.remove('Rama')

puts map.length

p map.keys
p map.values
p map.entries
