# coding: utf-8
require "minitest/autorun"
require "zig"

describe ZIG do

  describe "empty" do
    it "should reject an empty document" do
      assert_raises(RuntimeError) { ZIG.parse("") }
    end
  end

  describe "literals" do
    it "should parse nil" do
      assert_equal nil, ZIG.parse("nil")
    end

    it "should parse true" do
      assert_equal true, ZIG.parse("true")
    end

    it "should parse false" do
      assert_equal false, ZIG.parse("false")
    end

    it "should reject other literals" do
      assert_raises(RuntimeError) { ZIG.parse("foo") }
    end
  end

  describe "integers" do
    it "should parse zero" do
      assert_equal 0, ZIG.parse("0")
    end

    it "should parse positive integers" do
      assert_equal 7, ZIG.parse("7")
      assert_equal 23, ZIG.parse("23")
    end

    it "should parse negative integers" do
      assert_equal -7, ZIG.parse("-7")
      assert_equal -23, ZIG.parse("-23")
    end
  end

  describe "floats" do
    it "should parse zero" do
      assert_equal 0.0, ZIG.parse("0.0")
    end

    it "should parse positive floats" do
      assert_equal 0.07, ZIG.parse("0.07")
      assert_equal 23.9, ZIG.parse("23.9")
    end

    it "should parse negative floats" do
      assert_equal -0.07, ZIG.parse("-0.07")
      assert_equal -23.9, ZIG.parse("-23.9")
    end

    it "should parse pi" do
      assert_equal 3.14159265359, ZIG.parse("3.14159265359")
    end

    it "should parse exponential notation" do
      assert_equal 2.3e-10, ZIG.parse("2.3e-10")
      assert_equal 2.3e10, ZIG.parse("2.3e+10")
      assert_equal 2.3e10, ZIG.parse("2.3e10")
      assert_equal 2.3e10, ZIG.parse("2.3E10")
    end
  end

  describe "strings" do
    it "should parse simple strings" do
      assert_equal "foo bar", ZIG.parse("'foo bar'")
    end

    it "should parse unicode strings" do
      assert_equal "Übung macht den Meister", ZIG.parse("'Übung macht den Meister'")
    end
  end

  describe "multiline strings" do
    it "should parse multiline strings" do
      doc =
%{"
  one house
  two houses
  three houses}
      assert_equal "one house\ntwo houses\nthree houses", ZIG.parse(doc)
    end
  end


  describe "lists" do
    it "should parse an empty list" do
      assert_equal [], ZIG.parse("[")
    end

    it "should parse a list of simple values" do
      doc =
"[
  1
  2
  3"
      assert_equal [1, 2, 3], ZIG.parse(doc)
    end

    it "should parse nested empty lists" do
      doc =
"[
  [
  [
  ["
      assert_equal [[], [], []], ZIG.parse(doc)
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
      assert_equal [[23, 42], [], {a: 1, b: 2}], ZIG.parse(doc)
    end
  end

  describe "hashes" do
    it "should parse an empty hash" do
      assert_equal Hash.new, ZIG.parse("{")
    end

    it "should parse a hash with simple values" do
      doc =
"{
  a: 1
  b: 2
  c: 3"
      assert_equal Hash[a: 1, b: 2, c: 3], ZIG.parse(doc)
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
      assert_equal Hash[x: {a: 1, b: 2}, y: {}, z: [true, false]], ZIG.parse(doc)
    end

    it "should reject empty keys" do
      doc =
"{
  a: 1
  : 2
  c: 3"
      assert_raises(RuntimeError) { ZIG.parse(doc) }
    end
  end

  describe "comments" do
    it "should skip comment lines at the start of a document" do
      doc =
"# IMPORTANT
{
  a: 1
  b: 2
  c: 3"
      assert_equal Hash[a: 1, b: 2, c: 3], ZIG.parse(doc)
    end
    
    
    
    it "should skip comment lines inside hashes" do
      doc =
"{
  a: 1
  #b: 2
  #b: 2
  c: 3"
      assert_equal Hash[a: 1, c: 3], ZIG.parse(doc)
    end

    it "should skip comment lines inside arrays" do
      doc =
"[
  'one'
  #'two'
  #'two'
  'three'"
      assert_equal %w[one three], ZIG.parse(doc)
    end

    it "should ignore comment lines inside multiline strings" do
      doc =
%{"
  one house
  #two houses
  three houses}
      assert_equal "one house\n#two houses\nthree houses", ZIG.parse(doc)
    end
    it "should reject comments if not properly idented" do
      doc =
"{
  a: 1
   # TODO: check c
  c: 3"
      assert_raises(RuntimeError) { ZIG.parse(doc) }
    end

  end

end