#! /usr/bin/env ruby
# frozen_string_literal: true

dummy_text = [['This is a text that', ' has the function to look', ' for the word years and return true if it finds it'], ['This is other', ' Test to see', 'how this thing of years', 'behaves years']]

arr = dummy_text.map{ |x| x.select{ |x| x if x.include?('years') } }

print arr
