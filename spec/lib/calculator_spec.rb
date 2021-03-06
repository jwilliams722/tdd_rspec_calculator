require './lib/calculator'

describe Calculator do
  it "should be a Calculator class" do
    subject.should be_a(Calculator)
  end

  describe "#add" do
    it "two numbers" do
      expect { subject.add(2, 3) }.to change { subject.total }.from(0).to(5)
    end

    it "a postive and a negative number" do
      expect { subject.add(2, -3) }.to change { subject.total }.from(0).to(-1)
    end

    it "one number" do
      expect { subject.add(3) }.to change { subject.total }.from(0).to(3)
    end

    it "no numbers" do
      expect { subject.add }.to_not change { subject.total }
    end

    it "does nothing when passed a string" do
      expect { subject.add('3') }.to_not change { subject.total }
      expect { subject.add('99 Bottles of beer') }.to_not change { subject.total }
    end

    it "decimal numbers" do
      expect { subject.add(3.0, 5.0) }.to change { subject.total }.from(0).to(8.0)
    end

    it "is chainable" do
      subject.add(5).should == subject
    end
  end

  describe "#subtract" do
    it "two numbers" do
      expect { subject.subtract(7, 2) }.to change { subject.total }.from(0).to(-9)
    end

    it "postive and a negative number" do
      expect { subject.subtract(2, -3) }.to change { subject.total }.from(0).to(1)
    end

    it "should subtract one number" do
      expect { subject.subtract(3) }.to change { subject.total }.from(0).to(-3)
    end

    it "no numbers" do
      expect { subject.subtract }.to_not change { subject.total }
    end

    it "does nothing when passed strings" do
      expect { subject.subtract('1', '2') }.to_not change { subject.total }
    end

    it "ignores strings while accepting numbers" do
      expect { subject.subtract(-3, 'fire') }.to change { subject.total }.from(0).to(3)
    end

    it "should subtract decimal numbers" do
      expect { subject.subtract(3.0, 5.0) }.to change { subject.total }.from(0).to(-8.0)
    end

    it "is chainable" do
      subject.subtract(5).should == subject
    end
  end

  describe "#multiply" do
    it "two numbers" do
      expect { subject.multiply(7, 2) }.to change { subject.total }.from(0).to(14)
    end

    it "postive and a negative number" do
      expect { subject.multiply(2, -3) }.to change { subject.total }.from(0).to(-6)
    end

    it "should multiply one number" do
      expect { subject.multiply(3) }.to change { subject.total }.from(0).to(3)
    end

    it "no numbers" do
      expect { subject.multiply }.to_not change { subject.total }
    end

    it "does nothing when passed strings" do
      expect { subject.multiply('1', '2') }.to_not change { subject.total }
    end

    it "ignores strings while accepting numbers" do
      expect { subject.multiply(-3, 'fire') }.to change { subject.total }.from(0).to(-3)
    end

    it "should multiply decimal numbers" do
      expect { subject.multiply(3.0, 5.0) }.to change { subject.total }.from(0).to(15.0)
    end

    it "is chainable" do
      subject.multiply(5).should == subject
    end

  end

  describe "#divide" do
    it "two numbers" do
      expect { subject.divide(8, 2) }.to change { subject.total }.from(0).to(4)
    end

    it "postive and a negative number" do
      expect { subject.divide(9, -3) }.to change { subject.total }.from(0).to(-3)
    end

    it "should divide one number" do
      expect { subject.divide(3) }.to change { subject.total }.from(0).to(3)
    end

    it "ignores zero" do
      expect { subject.divide(0) }.to_not change { subject.total }
      expect { subject.divide(45, 0, 15) }.to change { subject.total }.from(0).to(3)
    end

    it "when not evenly divisible" do
      expect { subject.divide(9, 2) }.to change { subject.total }.from(0).to(4.5)
    end

    it "no numbers" do
      expect { subject.divide }.to_not change { subject.total }
    end

    it "does nothing when passed strings" do
      expect { subject.divide('1', '2') }.to_not change { subject.total }
    end

    it "ignores strings while accepting numbers" do
      expect { subject.divide(-3, 'fire') }.to change { subject.total }.from(0).to(-3)
    end

    it "should divide decimal numbers" do
      expect { subject.divide(25.0, 5.0) }.to change { subject.total }.from(0).to(5.0)
    end

    it "is chainable" do
      subject.divide(5).should == subject
    end
  end

  describe "#sqrt" do
    it "with an integer argument" do
      subject.add(9)
      expect{ subject.sqrt }.to change{ subject.total }.from(9).to(3)
    end
    it "with a float argument" do
      subject.add(9.0)
      expect{ subject.sqrt }.to change{ subject.total }.from(9.0).to(3)
    end
    it "returns float answers" do
      subject.add(3.1415 ** 2)
      expect{ subject.sqrt }.to change{ subject.total }.from(3.1415 ** 2).to(3.1415)
    end
    it "with no argument" do
      expect{ subject.sqrt }.to_not change{subject.total}
    end
    it "with no argument when total != 0" do
      subject.add(49)
      expect{ subject.sqrt }.to change{subject.total}.from(49).to(7)
    end
    it "is chainable" do
      subject.sqrt.should == subject
    end
  end

  describe "#clear" do
    it "resets the total to zero" do
      subject.add(50)
      expect{ subject.clear }.to change{subject.total}.from(50).to(0)
    end

    it "is chainable" do
      subject.clear.should == subject
    end
  end

  describe "chainability rocks" do
    it "just works" do
      expect{
        subject.add(5).subtract(3)
        subject.multiply(5).divide(4)
        subject.sqrt.clear
      }.to_not change{subject.total}

      expect{
        subject.add(25).subtract(5)
        subject.multiply(4).divide(10).add(73).sqrt.add(1)
      }.to change{ subject.total }.from(0).to(10)
    end
  end
end
  
