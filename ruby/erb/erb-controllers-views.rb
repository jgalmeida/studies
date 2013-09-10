require 'erb'

class Person

  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age  = age
  end

end

class PersonView

  class << self

    def template
      <<-EOS
        <html>
          <head><%= @header %></head>
          <body>
            <p><%= @body %></p>
            <p><%= partial 'waza' %></p>
          </body>
          <footer><%= @footer %></head>
        </html>
      EOS
    end

  end

end

class ApplicationController

  def partial(name)
    ERB.new(name).result()
  end

  def render(template)
    compiled_template = ERB.new(template)
    compiled_template.result(binding)
  end

end

class PersonController < ApplicationController

  def show
    person = Person.new("João", "23")
    @header = "Person show"
    @body   = "Nome: #{person.name} - Idade: #{person.age}"
    @footer = "Footer"

    render PersonView.template
  end

end

puts PersonController.new.show
