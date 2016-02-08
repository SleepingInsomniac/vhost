require_relative "../lib/vhost.rb"

describe "Vhost" do
  
  describe "create" do
    
    it "creates a new virtual host conf file" do
      conf = Vhost.create("vhost-test.com")
      expect(conf.name).to eq("vhost-test.com.conf")
    end
    
    it "skips creation if a configuration exists" do
      expect(Vhost.create("vhost-test.com")).to eq(false)
    end
    
  end
  
  describe "find" do
    
    it "finds a configuration based on search" do
      expect(Vhost.find("vhost-test")).to be_truthy
    end
    
  end
  
  describe "delete!" do
    
    it "removes the configuration and link if enabled" do
      conf = Vhost.new("vhost-test.com.conf")
      conf.delete!
      expect(File.exists?(conf.paths[:available])).to be_falsey
      expect(File.exists?(conf.paths[:enabled])).to be_falsey
    end
    
  end
  
end