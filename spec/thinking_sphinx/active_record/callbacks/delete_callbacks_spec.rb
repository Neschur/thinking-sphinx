require 'spec_helper'

describe ThinkingSphinx::ActiveRecord::Callbacks::DeleteCallbacks do
  let(:callbacks)  {
    ThinkingSphinx::ActiveRecord::Callbacks::DeleteCallbacks.new instance
  }
  let(:instance)   { double('instance', :delta? => true) }

  describe '.after_destroy' do
    let(:callbacks) { double('callbacks', :after_destroy => nil) }

    before :each do
      ThinkingSphinx::ActiveRecord::Callbacks::DeleteCallbacks.
        stub :new => callbacks
    end

    it "builds an object from the instance" do
      ThinkingSphinx::ActiveRecord::Callbacks::DeleteCallbacks.
        should_receive(:new).with(instance).and_return(callbacks)

      ThinkingSphinx::ActiveRecord::Callbacks::DeleteCallbacks.
        after_destroy(instance)
    end

    it "invokes after_destroy on the object" do
      callbacks.should_receive(:after_destroy)

      ThinkingSphinx::ActiveRecord::Callbacks::DeleteCallbacks.
        after_destroy(instance)
    end
  end

  describe '#after_destroy' do
    let(:config)     { double('config', :indices_for_references => [index],
      :preload_indices => true) }
    let(:index)      { double('index', :name => 'foo_core',
      :document_id_for_key => 14, :type => 'plain') }
    let(:instance)   { double('instance', :id => 7) }

    before :each do
      ThinkingSphinx::Configuration.stub :instance => config
    end

    it "performs the deletion for the index and instance" do
      ThinkingSphinx::Deletion.should_receive(:perform).with(index, instance)

      callbacks.after_destroy
    end
  end
end
