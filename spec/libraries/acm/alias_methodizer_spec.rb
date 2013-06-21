require 'spec_helper'

class Dummy
  extend ACM::AliasMethodizer

  def trigger
    # Do nothing :)
  end

  def foo
    1337
  end
  alias_method(:another_foo, :foo)
  alias_method(:trigger_foo, :foo) { trigger }

  def bar(x)
    "#{x} was given."
  end
  alias_method(:another_bar, :bar)
  alias_method(:trigger_bar, :bar) { trigger }

  def baz(x, y = 10)
    x + y
  end
  alias_method(:another_baz, :baz)
  alias_method(:trigger_baz, :baz) { trigger }

  def qux(x, *arr)
    arr.empty? ? x : x + arr.inject(:+)
  end
  alias_method(:another_qux, :qux)
  alias_method(:trigger_qux, :qux) { trigger }

  def quux(x, &block)
    value = x + 10
    value = yield(value) if block_given?
    value
  end
  alias_method(:another_quux, :quux)
  alias_method(:trigger_quux, :quux) { trigger }
end

describe ACM::AliasMethodizer do
  subject { Dummy.new }

  describe "working like alias method normally does" do

    context "on a method with no arguments" do
      it "returns the same value" do
        subject.another_foo.should eq(1337)
      end
    end

    context "on a method that takes 1 required argument" do
      it "returns the same value" do
        subject.another_bar("foo").should eq("foo was given.")
      end
    end

    context "on a method that has an optional argument" do
      it "returns the same value with both args given" do
        subject.another_baz(10, 20).should eq(30)
      end

      it "returns the same value without optional arg" do
        subject.another_baz(10).should eq(20)
      end
    end

    context "on a method that takes 1+ args" do
      it "returns the same value with just 1 arg" do
        subject.another_qux(10).should eq(10)
      end

      it "returns the same value with many arguments" do
        subject.another_qux(10, 20, 30, 40).should eq(100)
      end
    end

    context "on a method that takes a block" do
      it "returns the same thing without the block" do
        subject.another_quux(10).should eq(20)
      end

      it "returns the same thing with a block" do
        result = subject.another_quux(10) { |v| v + 100 }
        result.should eq(120)
      end
    end

  end

  describe "with a block" do

    context "on a method with no arguments" do
      it "returns the same value" do
        subject.trigger_foo.should eq(1337)
      end

      it "injects the execution of the block into the method" do
        subject.should_receive(:trigger)
        subject.trigger_foo
      end
    end

    context "on a method that takes 1 required argument" do
      it "returns the same value" do
        subject.trigger_bar("foo").should eq("foo was given.")
      end

      it "injects the execution of the block into the method" do
        subject.should_receive(:trigger)
        subject.trigger_bar(10)
      end
    end

    context "on a method that has an optional argument" do
      it "returns the same value with both args given" do
        subject.trigger_baz(10, 20).should eq(30)
      end

      it "returns the same value without optional arg" do
        subject.trigger_baz(10).should eq(20)
      end

      it "injects the execution of the block into the method" do
        subject.should_receive(:trigger)
        subject.trigger_baz(10)
      end
    end

    context "on a method that takes 1+ args" do
      it "returns the same value with just 1 arg" do
        subject.trigger_qux(10).should eq(10)
      end

      it "returns the same value with many arguments" do
        subject.trigger_qux(10, 20, 30, 40).should eq(100)
      end

      it "injects the execution of the block into the method" do
        subject.should_receive(:trigger)
        subject.trigger_qux(10)
      end
    end

    context "on a method that takes a block" do
      it "returns the same thing without the block" do
        subject.trigger_quux(10).should eq(20)
      end

      it "returns the same thing with a block" do
        result = subject.trigger_quux(10) { |v| v + 100 }
        result.should eq(120)
      end

      it "injects the execution of the block into the method" do
        subject.should_receive(:trigger)
        subject.trigger_quux(10)
      end
    end


  end

end
