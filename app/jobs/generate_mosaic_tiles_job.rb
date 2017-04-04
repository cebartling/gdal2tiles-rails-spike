require 'open3'

class GenerateMosaicTilesJob < ApplicationJob
  queue_as :default

  def perform()
    puts "START: GenerateMosaicTilesJob.perform"
    input_file = Rails.root.join('data/input/sample-ndvi.tif')
    output_dir = Rails.root.join("data/output/#{Time.now.to_i}")
    command = 'python /usr/local/bin/gdal2tiles.py --profile=mercator -z 18-20 --srcnodata=0'

    Open3.popen2e("#{command} #{input_file} #{output_dir}") { |stdin, stdout_err, wait_thr|
      while line = stdout_err.gets
        puts line
      end

      pid = wait_thr.pid # pid of the started process.
      puts "Process #{pid} started"

      exit_status = wait_thr.value # Process::Status object returned.
      puts "Process #{pid} exited with a status of #{exit_status}"
    }
    puts "END: GenerateMosaicTilesJob.perform"
  end
end
