---
title: "Preparing for Fedora 17"
author: 'Marc Savy'
layout: blog
timestamp: 2012-02-29t17:59:00.00+00:00
tags: [ boxgrinder_build, tech, ruby ]
---

## Looking to the (beefy) future
Those of you who keep an eye on happenings in Fedora-land will undoubtedly be aware that Fedora 17 is [due out][] in the near future. From BoxGrinder's perspective one of the more important changes is the move to [Ruby](http://www.ruby-lang.org/en/about/) 1.9.x from 1.8.

There are some syntactic changes and a few subtle semantic differences between versions, so it is important for us to ensure equivalent runtime behaviour in both flavours. Fedora 15 and 16 will both remain on 1.8.7, so we must straddle the fence.

Mercifully, [the changes][] required were [fairly minor][]; but for those of a more inquisitive persuasion, let's look at a few examples of alterations that were required.

### Coverage Testing 
We needed to provide code coverage analysis with both Rubies, under 1.9 via [simplecov](https://github.com/colszowka/simplecov) and [RCov](https://github.com/relevance/rcov) when using 1.8. We only want the relevant tool to be loaded and run for the appropriate version of Ruby. 

Our tests are run using Rake, and as `Rake` tasks run in a new process, a bit of ingenuity is required to ensure the code you write is affecting the correct process. 

In this instance the simplest solution was to create a couple of helper files that are run in the new process before the specs begin, ensuring everything required is kicked into action. 

---
Below is a snippet from our [`Rakefile`][]. Under 1.9, we set an environment variable to indicate to [`spec_helper`][] that simplecov should be run.

When running with 1.8 a bit of path juggling ensures [`rcov_helper`][] is run *before* RCov starts. As RCov is initialised before RSpec, we must ensure that some basic dependencies are met. 

`Rakefile`:
<!-- lang: ruby -->
    RSpec::Core::RakeTask.new('spec:coverage') do |t|
      t.ruby_opts = "-I ../boxgrinder-core/lib"
      t.pattern = "spec/**/*-spec.rb"
      t.rspec_opts = ['-r spec_helper', '-r boxgrinder-core', 
              '-r rubygems', <snip>]
      t.verbose = true

      if RUBY_VERSION =~ /^1.8/
        t.rcov = true
        t.rcov_opts = ["-Ispec:lib spec/rcov_helper.rb", <snip>]
      else
        ENV['COVERAGE'] = 'true'
      end
    end

`spec_helper.rb`:
<!-- lang: ruby -->
    if ENV['COVERAGE']
      require 'simplecov'

      FILTER_DIRS = ['spec']

      SimpleCov.start do
        FILTER_DIRS.each{ |f| add_filter f }
      end
    end
    
This might seem fairly circuitous, but if we attempted to start code coverage in the Rakefile itself, we'd simply be analysing Rake, not **our** code!

### Sycked up
<!-- lang: ruby -->
    module BoxGrinder
      # Avoid Psych::SyntaxError (<unknown>): couldn't parse YAML in 1.9
      if RUBY_VERSION.split('.')[1] == '9'
        require 'yaml'
        YAML::ENGINE.yamler = 'syck'
      end
    end

Psych, the default cRuby 1.9.3 YAML parser, causes problems with our YAML parsing and validation (through [Kwalify](http://www.kuwata-lab.com/kwalify/)), but fortunately the only change required was to set the parser back to Syck.  

### Syntactical slips
<!-- lang: diff -->
    -    when :ec2:
    +    when :ec2
           disk_format = :ami
           container_format = :ami
    -    when :vmware:
    +    when :vmware
           disk_format = :vmdk

This is a single example of a few slightly unusual *case* (switch) syntaxes which had crept into the codebase, and due to 1.9's new [hash syntax][], something like `:ec2:` appears to be a mangled hash key.

### String it out
<!-- lang: diff -->
    -    repoquery_output.each do |line|
    +    repoquery_output.each_line do |line|

`String#each` is no longer an alias to `#each_line`, which splits a string into an array with `newline` as the separator. The change is probably rather sensible, given that the behaviour is surprising at first encounter. 

### Regex 
<!-- lang: diff -->
    -    vmdk_image.scan(/^createType="(.*)"\s?$/).to_s.should == "vmfs"
    +    vmdk_image.match(/^createType="(.*)"\s?$/)[1].should == "vmfs"

<!-- lang: ruby -->
    [1] pry(main)> 'createType="BG"'.scan(/^createType="(.*)"\s?$/).to_s
    => "example" # Ruby 1.8.7

    [1] pry(main)> 'createType="BG"'.scan(/^createType="(.*)"\s?$/).to_s
    => "[[\"example\"]]" # Ruby 1.9.3

Numerous examples of *slightly dodgy* regex matching that relied upon `to_s` in our tests were eliminated from the codebase.

### Other bits
Amongst other changes that bit us was our reliance upon quirky behaviour in Ruby 1.8 [bindings][] (albeit our usage is slightly dubious anyway), and a couple of situations where [implicit arrays][] were assumed.  

### RSpec 2, when dependencies strike 
A few of our newer RSpec tests only work properly with `rspec-expectations >= 2.7.0`, which is available only on Fedora 17 and above.

<!-- lang: diff -->
    - it "should add the path to the path_set" do
    + <snip> :if => RSpec::Expectations::Version::STRING >= '2.7.0' do
        expect{ simple_update }.to change(subject, :path_set).
          from(empty_set).to(mkset('/the/great/escape'))
      end

By using RSpec 2 [*filters*](http://blog.davidchelimsky.net/2010/06/14/filtering-examples-in-rspec-2/) we avoid running [tests][] known to fail spuriously. This is a useful technique if you temporarily need to straddle multiple versions, and refactoring isn't desirable. 

## Onwards
Thankfully the process was rather easy, with all but a couple of issues being caught by our tests. It would seem that all of the cases were circumstances where we should have been using better approaches anyway, so the outcome was certainly positive.

[`spec_helper`]: https://github.com/boxgrinder/boxgrinder-build/blob/947c256f5ac55b7053ce78503d0628e00a2b5d5e/spec/spec_helper.rb
[`Rakefile`]: https://github.com/boxgrinder/boxgrinder-build/blob/884980efb9faa01dcbbed3c86afec8cc02869dd0/Rakefile
[`rcov_helper`]: https://github.com/boxgrinder/boxgrinder-build/blob/947c256f5ac55b7053ce78503d0628e00a2b5d5e/spec/rcov_helper.rb
[implicit arrays]: https://github.com/boxgrinder/boxgrinder-build/commit/af42eb9f2819fddf3eea54a7a2cd3158abedcb74#L2L30
[bindings]: https://github.com/boxgrinder/boxgrinder-build/commit/af42eb9f2819fddf3eea54a7a2cd3158abedcb74#L4L40
[the changes]: https://github.com/boxgrinder/boxgrinder-build/compare/f45412e54c7fa94965179dc780b4442f4d8e990c...884980efb9faa01dcbbed3c86afec8cc02869dd0
[fairly minor]: https://github.com/boxgrinder/boxgrinder-core/compare/3a55db5af5daa694cbf362b349988edf94649c5f...ff7de635396422fa6059f1bc1b50f9e2078b7bdb
[due out]: http://fedoraproject.org/wiki/Releases/17/Schedule
[hash syntax]: http://logicalfriday.com/2011/06/20/i-dont-like-the-ruby-1-9-hash-syntax/
[tests]: https://github.com/rspec/rspec-expectations/commit/ea01a6f8787564406e951108a5d6a942880c0152
