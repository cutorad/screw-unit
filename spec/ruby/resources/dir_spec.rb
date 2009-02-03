require "#{File.dirname(__FILE__)}/../screw_unit_spec_helper"

module ScrewUnit
  module Resources
    describe Dir do
      attr_reader :dir
      before do
        spec_file_dir = ::File.dirname(__FILE__)
        @dir = Dir.new("/bar", "#{spec_file_dir}/file_system_fixtures")
      end

      describe "#locate" do
        context "when the string names a file in the directory" do
          it "returns a File resource with the appropriate absolute and relative paths" do
            file = dir.locate("foo.js")
            file.class.should == Resources::File
            file.relative_path.should == "/bar/foo.js"
            file.absolute_path.should == "#{dir.absolute_path}/foo.js"
          end
        end

        context "when the string names a subdirectory in the directory" do
          it "returns a Dir resource with the appropriate absolute and relative paths" do
            subdir = dir.locate("subdir")
            subdir.class.should == Resources::Dir
            subdir.relative_path.should == "/bar/subdir"
            subdir.absolute_path.should == "#{dir.absolute_path}/subdir"
          end
        end
      end
    end
  end
end
