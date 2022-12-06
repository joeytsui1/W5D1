class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if (0 > num) || (@max <= num)

    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def include?(num)
    @store[num % num_buckets].include?(num) 
  end
  
  def insert(num)
    if !(@store[num % num_buckets].include?(num))
      @store[num % num_buckets] << num
      @count += 1
      resize! if @count > num_buckets
    end
  end

  def remove(num)
    if @store[num % num_buckets].include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end
  end



  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
      new_buckets = ResizingIntSet.new(num_buckets * 2)

      @store.each do |ele|
        if ele.is_a?(Array)
          ele.each {|el| new_buckets.insert(el)}
        else
          new_buckets.insert(ele)
        end
      end
      @store = new_buckets.store
  end
end
