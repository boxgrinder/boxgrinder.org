require 'net/http'

class ReleaseSizes
  def execute(site)
    file = "#{site.tmp_dir}/release_sizes"

    if File.exists?(file)
      site.meta_appliances.appliances = YAML.load_file(file)
    end

    site.meta_appliances.appliances.each do |release|

      release[:links] = OpenCascade.new if release[:links].nil?

      release.platforms.each do |platform|
        release.arches.each do |arch|
          release[:links][platform.to_sym] = OpenCascade.new if release[:links][platform.to_sym].nil?

          if (release[:links][platform.to_sym][arch.to_sym].nil?)

            release_path = "#{site.meta_appliances.path}/boxgrinder-meta-#{release.version}-#{release.os.name.downcase}-#{release.os.version}-#{arch}-#{platform.downcase}.tgz"
            release[:links][platform.to_sym][arch.to_sym] = OpenCascade.new({:url => "http://#{site.meta_appliances.server}#{release_path}"})

            Net::HTTP.start(site.meta_appliances.server, 80) do |http|
              response = http.head(release_path)
              b = response['content-length'] || ''
              if (!b.empty?)
                b = b.to_i
                kb = b / 1024
                mb = kb / 1024
                release[:links][platform.to_sym][arch.to_sym][:size] = mb
              else
                release[:links][platform.to_sym][arch.to_sym][:size] = 'unknown'
              end
            end
          end
        end
      end
    end

    File.open(file, 'w') do |f|
      f.write(site.meta_appliances.appliances.to_yaml)
    end unless File.exists?(file)

  end
end
