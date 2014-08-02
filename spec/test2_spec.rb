require 'rspec'
# require_relative '../lib/rspec_html_formatter'

describe 'The second Test' do

  it 'should do cool test stuff' do
    pending('coming soon')
  end

  it 'should do amazing test stuff' do
    'boats'.should == 'boats'
  end

  it 'should do superb test stuff' do
    #-> Given there are some ships
    #-> When I sail one
    #-> Then it should go fast
    'ships'.should == 'ships'
  end

  it 'should do example stuff' do
    'apple'.should == 'apple'
    'pear'.should == 1
    #-> Given I have some stuff to do
    #-> And I like to do is wait here for a while
    #-> Then I do it real good!!
  end

  it 'should do very cool test stuff' do
    #-> Given I have some cars
    'cars'.should == 'cars'
    #-> And I drive one of them
    'diesel'.should == 'diesels'
    #-> Then I should go fast
    'apple'.should == 'apple'
  end

  it 'should do very amazing test stuff' do
    'boats'.should == 'boats'
  end

  it 'should do very superb test stuff' do
    'ships'.should == 'ships'
  end

  it 'should do very rawesome test stuff' do
        #-> Given I have some cars
    pending('give me a woop')
  end

  it 'should do insane and cool test stuff' do
    'ships'.should == 'ships'
   end


end
