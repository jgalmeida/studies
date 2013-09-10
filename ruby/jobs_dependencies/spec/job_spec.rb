require_relative '../jobs_dependencies'

describe "empty jobs list" do
  it "returns an empty list" do
    jobs = ""
    JobDependencies.resolve_dependencies(jobs).size.should eql 0
  end
end

describe "no dependencies list" do
  it "returns a list by the order that was given" do
    jobs = "a => , b =>, c => "
    JobDependencies.resolve_dependencies(jobs).should eql ['a', 'b', 'c']
  end
end

describe "one dependency list" do
  it "a list with one solved dependency" do
    jobs = "a => , b => c, c => "
    JobDependencies.resolve_dependencies(jobs).should eql ['a', 'c', 'b']
  end
end

describe "multi dependency list" do
  it "returns a list with all dependencies resolved" do
    jobs = "a => , b => c, c => f, d => a, e => b, f => "
    JobDependencies.resolve_dependencies(jobs).should eql ['a', 'f', 'c', 'b', 'd', 'e']
  end
end

describe "dependency on self" do
  it "raises an exception indicating that the job depended on himself" do
    jobs = "a => , b => , c => c"
    expect { JobDependencies.resolve_dependencies(jobs) }.to raise_error("Jobs can't depend on themselves: c depends on c")
  end
end

describe "circular dependency" do
  it "raises an exception indicating that there are circular dependencies" do
    jobs = "a => , b => c, c => f, d => a, e => , f => b"
    expect { JobDependencies.resolve_dependencies(jobs) }.to raise_error("Jobs can't have circular dependencies")
  end
end