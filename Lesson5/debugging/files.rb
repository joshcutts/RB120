class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

=begin

The error occurs when we use the `File#to_s` method. The reason is our use
of the constant `FORMAT`. When Ruby resolves a consant, it looks it up
in its lexical scope, in this case in the `File` class as well as in
all of its ancesotr classes. Since it does't find it in any of them Ruby
throws a NameError.

There are several ways to fix this. For example, instead of defining `to_s`
in the `File` class, we could define it in each of the subclasses in which the
`FORMAT` constant is defined. But this would duplicate the exact same
method, so the DRY principle advises us against it. Alternatively, we can
add explicit namespacing, as we do in our solution, by prepending the class name.

The class is determined by referencing the calling subclass, utilziiing `self.class`.
The class of the caller of the method is returned.


=end

=begin

`attr_accessor :byte_content` essentially does the following:

```
def byte_content
  @byte_content
end

def byte_content=(value)
  @byte_content = value
end
```

Then 

`alias_method :read, :byte_content`
`alias_method :write, :byte_content=`

will create copies of the byte_content and byte_content= instance methods with
read and write as the new names. 

=end