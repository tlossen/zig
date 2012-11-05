# coding: utf-8
require "minitest/autorun"
require "jmie"

describe JMIE do

  describe "empty" do
    it "should reject an empty document" do
      assert_raises(RuntimeError) { JMIE.parse("") }
    end
  end

  describe "literals" do
    it "should parse nil" do
      assert_equal nil, JMIE.parse("nil")
    end

    it "should parse true" do
      assert_equal true, JMIE.parse("true")
    end

    it "should parse false" do
      assert_equal false, JMIE.parse("false")
    end

    it "should reject other literals" do
      assert_raises(RuntimeError) { JMIE.parse("foo") }
    end
  end

  describe "integers" do
    it "should parse zero" do
      assert_equal 0, JMIE.parse("0")
    end

    it "should parse positive integers" do
      assert_equal 7, JMIE.parse("7")
      assert_equal 23, JMIE.parse("23")
    end

    it "should parse negative integers" do
      assert_equal -7, JMIE.parse("-7")
      assert_equal -23, JMIE.parse("-23")
    end
  end

  describe "floats" do
    it "should parse zero" do
      assert_equal 0.0, JMIE.parse("0.0")
    end

    it "should parse positive floats" do
      assert_equal 0.07, JMIE.parse("0.07")
      assert_equal 23.9, JMIE.parse("23.9")
    end

    it "should parse negative floats" do
      assert_equal -0.07, JMIE.parse("-0.07")
      assert_equal -23.9, JMIE.parse("-23.9")
    end

    it "should parse pi" do
      assert_equal 3.14159265359, JMIE.parse("3.14159265359")
    end

    it "should parse exponential notation" do
      assert_equal 2.3e-10, JMIE.parse("2.3e-10")
      assert_equal 2.3e10, JMIE.parse("2.3e+10")
      assert_equal 2.3e10, JMIE.parse("2.3e10")
      assert_equal 2.3e10, JMIE.parse("2.3E10")
    end
  end

  describe "strings" do
    it "should parse simple strings" do
      assert_equal "foo bar", JMIE.parse("'foo bar'")
    end

    it "should parse unicode strings" do
      assert_equal "Übung macht den Meister", JMIE.parse("'Übung macht den Meister'")
    end
  end

  describe "multiline strings" do
    it "should parse multiline strings" do
      doc =
%{"
   one house
   two houses
   three houses}
      assert_equal "one house\ntwo houses\nthree houses", JMIE.parse(doc)
    end
  end


  describe "lists" do
    it "should parse an empty list" do
      assert_equal [], JMIE.parse("[")
    end

    it "should parse a list of simple values" do
      doc =
"[
   1
   2
   3"
      assert_equal [1, 2, 3], JMIE.parse(doc)
    end

    it "should parse a list of complex values" do
      doc =
"[
   [
      23
      42
   [
   {
      a: 1
      b: 2"
      assert_equal [[23, 42], [], {a: 1, b: 2}], JMIE.parse(doc)
    end
  end

  describe "hashes" do
    it "should parse an empty hash" do
      assert_equal Hash.new, JMIE.parse("{")
    end

    it "should parse a hash with simple values" do
      doc =
"{
   a: 1
   b: 2
   c: 3"
      assert_equal Hash[a: 1, b: 2, c: 3], JMIE.parse(doc)
    end

    it "should parse a hash with complex values" do
      doc =
"{
   x: {
      a: 1
      b: 2
   y: {
   z: [
      true
      false"
      assert_equal Hash[x: {a: 1, b: 2}, y: {}, z: [true, false]], JMIE.parse(doc)
    end

    it "should reject empty keys" do
      doc =
"{
   a: 1
   : 2
   c: 3"
      assert_raises(RuntimeError) { JMIE.parse(doc) }
    end
  end

  describe "comments" do
  end

end